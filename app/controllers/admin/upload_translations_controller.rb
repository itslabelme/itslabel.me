module Admin
  class UploadTranslationsController < Admin::BaseController

    require 'csv'

    def index
      @page_title = "Upload Translation Data"
      @nav = 'admin/translations'
      @errors = {}
      @summary = {}
    end

    def create
      csv_file = params[:file]
      error = nil

      @csv_contents = nil
      @error_data = 0
      @existing_data = 0
      @inserted_data = 0
      @summary = {}
      
      if csv_file
        begin
          @csv_contents = CSV.read(csv_file.path)
          # @csv_headers = CSV.read(csv_file.path, headers: true).headers
          # processed_csv = File.read(csv_file.path).gsub(/\\"/,'""')
          # @csv_contents = CSV.parse(processed_csv, headers: true)
          # processed_csv = File.readlines(csv_file.path).map do |row|
          #   row.strip.gsub('""', '"')
          # end.join("\n")
          # @csv_contents = CSV.parse(processed_csv)
         rescue
          error = "Unable to read the contents of the uploaded file, Please upload valid file"
        end
      else 
        error = "CSV file not uploaded"
      end

      if is_csv_in_right_format? == false
        error = "The format of the CSV is not correct. Please download the template, fill in the data and upload again."
      elsif is_csv_empty?
        error = "CSV is blank - no contents found"
      end

      if error.blank?
        save_csv_file
        import_data_from_csv
        save_upload_history
        if @summary
          set_notification(true, I18n.t('status.success'), I18n.t('success.created', item: "Translation"))
          set_flash_message(I18n.translate("success.created", item: "Translation"), :success)
        end
      else
        set_notification(false, I18n.t('status.error'), error)
        set_flash_message(error, :error)
      end
    end

    private

    def is_csv_in_right_format?
      return false if @csv_contents.blank?
      return false unless @csv_contents.is_a?(Array)
      return false unless @csv_contents.try(:first).is_a?(Array)
      
      # FIXME - this needs to be fixed properly
      # return false unless @csv_contents[0][0].upcase == "ENGLISH"
      # return false unless @csv_contents[0][1].upcase == "ARABIC"
      # return false unless @csv_contents[0][2].upcase == "FRENCH"
      # return false unless @csv_contents[0][3].upcase == "CATEGORY"

      return false unless @csv_contents[0][0].upcase.include?("ENGLISH")
      return false unless @csv_contents[0][1].upcase.include?("ARABIC")
      return false unless @csv_contents[0][2].upcase.include?("FRENCH")
      return false unless @csv_contents[0][3].upcase.include?("CATEGORY")
      return true
    end

    def is_csv_empty?
      return true if @csv_contents[1].blank?
      return true unless @csv_contents[1].is_a?(Array)
      return false
    end

    def import_data_from_csv

      @csv_contents = @csv_contents.drop(1)

      @csv_contents.each do |csv_content|
        begin
          if csv_content[0] && csv_content[1]
            add_english_to_arabic_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['english-arabic'] = {
              input_phrase: csv_content[0], output_phrase: csv_content[1], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

          if csv_content[0] && csv_content[2]
            add_english_to_french_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['english-french'] = {
              input_phrase: csv_content[0], output_phrase: csv_content[2], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

          if csv_content[1] && csv_content[0]
            add_arabic_to_english_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['arabic-english'] = {
              input_phrase: csv_content[1], output_phrase: csv_content[0], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

          if csv_content[1] && csv_content[2]
            add_arabic_to_french_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['arabic-french'] = {
              input_phrase: csv_content[1], output_phrase: csv_content[2], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

          if csv_content[2] && csv_content[0]
            add_french_to_english_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['french-english'] = {
              input_phrase: csv_content[2], output_phrase: csv_content[0], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

          if csv_content[2] && csv_content[1]
            add_french_to_arabic_translation(csv_content)
          else
            @error_data = @error_data + 1
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['french-arabic'] = {
              input_phrase: csv_content[2], output_phrase: csv_content[1], 
              category: csv_content[3], admin_user: @current_admin_user,
              errors: ["Content Missing"]
            }
          end 

        rescue StandardError => e
          error = "uncaught #{e} exception while handling connection: #{e.message}"
          puts "CSV Content: #{csv_content}"
          puts "Error: #{error}"
        end
      end
    end

    def save_csv_file
      @csv_path = "#{Rails.root}/public/imported_files/UPLOAD_DATA_#{DateTime.now.strftime '%d.%m.%Y:%H.%M.%S'}.csv"
      CSV.open(@csv_path, "wb") do |csv|  
        @csv_contents.each do |csv_content|
         csv << [csv_content[0],csv_content[1],csv_content[2],csv_content[3]]
        end
      end 
    end

    def save_upload_history
      @upload_history = UploadsHistory.new(admin_user:current_admin_user.first_name, file_path: @csv_path)
      @upload_history.save

      @upload_summary = UploadsSummary.new(translation_uploads_history_id: @upload_history.id, summary_new: @summary, 
        total_inserted_data: @inserted_data, 
        total_existing_data: @existing_data,
        total_error_data: @error_data)
      @upload_summary.save
    end
    
    def add_english_to_arabic_translation(csv_content)
      @english_arabic_translation = Translation.where(
        input_language: "ENGLISH",  output_language: "ARABIC",
        input_phrase: csv_content[0].strip, output_phrase: csv_content[1].strip
        ).first

      if @english_arabic_translation.nil?
        @english_arabic_translation ||= Translation.new(
          input_language: "ENGLISH",  output_language: "ARABIC",
          input_phrase: csv_content[0].strip,  output_phrase: csv_content[1].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )
        if @english_arabic_translation.valid?
          if @english_arabic_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['english-arabic'] ||= true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['english-arabic'] = {
            input_phrase: csv_content[0].strip, output_phrase: csv_content[1].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['english-arabic'] = {
          input_phrase: csv_content[0], output_phrase: csv_content[1], 
          category: csv_content[3], admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end

    def add_english_to_french_translation(csv_content)
      @english_french_translation = Translation.where(
          input_language: "ENGLISH", output_language: "FRENCH",
          input_phrase: csv_content[0].strip, output_phrase: csv_content[2].strip, 
          ).first
      if @english_french_translation.nil?
        @english_french_translation ||= Translation.new(
          input_language: "ENGLISH", output_language: "FRENCH",
          input_phrase: csv_content[0].strip, output_phrase: csv_content[2].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )

        if @english_french_translation.valid?
          if @english_french_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['english-french'] = true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['english-french'] = {
            input_phrase: csv_content[0].strip, output_phrase: csv_content[2].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['english-french'] = {
          input_phrase: csv_content[0].strip, output_phrase: csv_content[2].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end

    def add_arabic_to_english_translation(csv_content)
      @arabic_english_translation = Translation.where(
          input_language: "ARABIC", output_language: "ENGLISH",
          input_phrase: csv_content[1].strip, output_phrase: csv_content[0].strip
          ).first
      if @arabic_english_translation.nil?
        @arabic_english_translation ||= Translation.new(
          input_language: "ARABIC", output_language: "ENGLISH",
          input_phrase: csv_content[1].strip, output_phrase: csv_content[0].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )

        if @arabic_english_translation.valid?
          if @arabic_english_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['arabic-english'] = true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['arabic-english'] = {
            input_phrase: csv_content[1].strip, output_phrase: csv_content[0].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['arabic-english'] = {
          input_phrase: csv_content[1].strip, output_phrase: csv_content[0].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end

    def add_arabic_to_french_translation(csv_content)
      @arabic_french_translation = Translation.where(
          input_language: "ARABIC", output_language: "FRENCH",
          input_phrase: csv_content[1].strip, output_phrase: csv_content[2].strip
          ).first
      if @arabic_french_translation.nil?
        @arabic_french_translation ||= Translation.new(
          input_language: "ARABIC", output_language: "FRENCH",
          input_phrase: csv_content[1].strip, output_phrase: csv_content[2].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )

        if @arabic_french_translation.valid?
          if @arabic_french_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['arabic-french'] = true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['arabic-french'] = {
            input_phrase: csv_content[1].strip, output_phrase: csv_content[2].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['arabic-french'] = {
          input_phrase: csv_content[1].strip, output_phrase: csv_content[2].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end

    def add_french_to_english_translation(csv_content)
      @french_english_translation = Translation.where(
          input_language: "FRENCH", output_language: "ENGLISH",
          input_phrase: csv_content[2].strip, output_phrase: csv_content[0].strip
          ).first 
      if @french_english_translation.nil?
        @french_english_translation ||= Translation.new(
          input_language: "FRENCH", output_language: "ENGLISH",
          input_phrase: csv_content[2].strip, output_phrase: csv_content[0].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )

        if @french_english_translation.valid?
          if @french_english_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['french-english'] = true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['french-english'] = {
            input_phrase: csv_content[2].strip, output_phrase: csv_content[0].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['french-english'] = {
          input_phrase: csv_content[2].strip, output_phrase: csv_content[0].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end

    def add_french_to_arabic_translation(csv_content)
      @french_arabic_translation = Translation.where(
          input_language: "FRENCH",  output_language: "ARABIC",
          input_phrase: csv_content[2].strip, output_phrase: csv_content[1].strip
          ).first

      if @french_arabic_translation.nil?
        @french_arabic_translation ||= Translation.new(
          input_language: "FRENCH",  output_language: "ARABIC",
          input_phrase: csv_content[2].strip,  output_phrase: csv_content[1].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          status: "APPROVED"
        )

        if @french_arabic_translation.valid?
          if @french_arabic_translation.save
            @summary[csv_content[0]] ||= {}
            @summary[csv_content[0]]['french-arabic'] = true
            @inserted_data = @inserted_data + 1
          end
        else
          @error_data = @error_data + 1
          @summary[csv_content[0]]['french-arabic'] = {
            input_phrase: csv_content[2].strip, output_phrase: csv_content[1].strip, 
            category: csv_content[3].strip, admin_user: @current_admin_user,
            errors: @english_arabic_translation.errors.full_messages
          }
        end
      else
        @existing_data = @existing_data + 1
        @summary[csv_content[0]] ||= {}
        @summary[csv_content[0]]['french-arabic'] = {
          input_phrase: csv_content[2].strip, output_phrase: csv_content[1].strip, 
          category: csv_content[3].strip, admin_user: @current_admin_user,
          errors: ["Content is already in the database"]
        }
      end
    end
  end
end
