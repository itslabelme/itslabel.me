module Itslabel::Uploads::TranslationUploads
  
  # Upload Methods
  # --------------

  def import_data_from_csv(csv_file_path, current_admin_user, upload_history_id)
    csv_contents = CSV.read(csv_file_path)
    csv_contents = csv_contents.drop(1)

    error_data = 0
    existing_data = 0
    inserted_data = 0
    self.csv_upload_summary = {}

    csv_contents.each do |csv_content|
      begin
        if csv_content[0] && csv_content[1]
          er_data,  ex_data,  in_data = add_english_to_arabic_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['english-arabic'] = {
            input_phrase: csv_content[0], output_phrase: csv_content[1], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end

        if csv_content[0] && csv_content[2]
          er_data,  ex_data,  in_data = add_english_to_french_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['english-french'] = {
            input_phrase: csv_content[0], output_phrase: csv_content[2], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if csv_content[1] && csv_content[0]
          er_data,  ex_data,  in_data = add_arabic_to_english_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['arabic-english'] = {
            input_phrase: csv_content[1], output_phrase: csv_content[0], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if csv_content[1] && csv_content[2]
          er_data,  ex_data,  in_data = add_arabic_to_french_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['arabic-french'] = {
            input_phrase: csv_content[1], output_phrase: csv_content[2], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if csv_content[2] && csv_content[0]
          er_data,  ex_data,  in_data = add_french_to_english_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['french-english'] = {
            input_phrase: csv_content[2], output_phrase: csv_content[0], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if csv_content[2] && csv_content[1]
          er_data,  ex_data,  in_data = add_french_to_arabic_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['french-arabic'] = {
            input_phrase: csv_content[2], output_phrase: csv_content[1], 
            category: csv_content[3], admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

      rescue StandardError => e
        error = "uncaught #{e} exception while handling connection: #{e.message}"
        puts "Error: #{error}"
        # puts "CSV Content: #{csv_content}"
      end
    end

    # Update the history with self.csv_upload_summary
    upload_summary = UploadsSummary.where(translation_uploads_history_id: upload_history_id).first || UploadsSummary.new(
      translation_uploads_history_id: upload_history_id, 
      summary_new: self.csv_upload_summary, 
      total_inserted_data: inserted_data, 
      total_existing_data: existing_data,
      total_error_data: error_data)
    upload_summary.save

    # Fix me - @sanoop
    # upload_history = UploadsHistory.find_by_id(upload_history_id)
    # upload_history.processed = true
    # upload_history.save

    self.csv_upload_summary = {}
  end

  def add_english_to_arabic_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    english_arabic_translation = Translation.where(
      input_language: "ENGLISH",  output_language: "ARABIC",
      input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[1].try(:strip)
      ).first

    if english_arabic_translation.nil?
      english_arabic_translation ||= Translation.new(
        input_language: "ENGLISH",  output_language: "ARABIC",
        input_phrase: csv_content[0].try(:strip),  output_phrase: csv_content[1].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )
      if english_arabic_translation.valid?
        if english_arabic_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['english-arabic'] ||= true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['english-arabic'] = {
          input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[1].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: english_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['english-arabic'] = {
        input_phrase: csv_content[0], output_phrase: csv_content[1], 
        category: csv_content[3], admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end 
    return error_data,  existing_data,  inserted_data
  end

  def add_english_to_french_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    english_french_translation = Translation.where(
        input_language: "ENGLISH", output_language: "FRENCH",
        input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[2].try(:strip), 
        ).first
    if english_french_translation.nil?
      english_french_translation ||= Translation.new(
        input_language: "ENGLISH", output_language: "FRENCH",
        input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[2].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if english_french_translation.valid?
        if english_french_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['english-french'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['english-french'] = {
          input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[2].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: english_french_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['english-french'] = {
        input_phrase: csv_content[0].try(:strip), output_phrase: csv_content[2].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_arabic_to_english_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    arabic_english_translation = Translation.where(
        input_language: "ARABIC", output_language: "ENGLISH",
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[0].try(:strip)
        ).first
    if arabic_english_translation.nil?
      arabic_english_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "ENGLISH",
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[0].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if arabic_english_translation.valid?
        if arabic_english_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['arabic-english'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['arabic-english'] = {
          input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[0].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: arabic_english_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['arabic-english'] = {
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[0].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_arabic_to_french_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    arabic_french_translation = Translation.where(
        input_language: "ARABIC", output_language: "FRENCH",
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[2].try(:strip)
        ).first
    if arabic_french_translation.nil?
      arabic_french_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "FRENCH",
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[2].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if arabic_french_translation.valid?
        if arabic_french_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['arabic-french'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['arabic-french'] = {
          input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[2].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: arabic_french_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['arabic-french'] = {
        input_phrase: csv_content[1].try(:strip), output_phrase: csv_content[2].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_french_to_english_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    french_english_translation = Translation.where(
        input_language: "FRENCH", output_language: "ENGLISH",
        input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[0].try(:strip)
        ).first 
    if french_english_translation.nil?
      french_english_translation ||= Translation.new(
        input_language: "FRENCH", output_language: "ENGLISH",
        input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[0].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if french_english_translation.valid?
        if french_english_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['french-english'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['french-english'] = {
          input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[0].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: french_english_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['french-english'] = {
        input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[0].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_french_to_arabic_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    french_arabic_translation = Translation.where(
        input_language: "FRENCH",  output_language: "ARABIC",
        input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[1].try(:strip)
        ).first

    if french_arabic_translation.nil?
      french_arabic_translation ||= Translation.new(
        input_language: "FRENCH",  output_language: "ARABIC",
        input_phrase: csv_content[2].try(:strip),  output_phrase: csv_content[1].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if french_arabic_translation.valid?
        if french_arabic_translation.save
          self.csv_upload_summary[csv_content[0]] ||= {}
          self.csv_upload_summary[csv_content[0]]['french-arabic'] = true
         inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[csv_content[0]]['french-arabic'] = {
          input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[1].try(:strip), 
          category: csv_content[3].try(:strip), admin_user: current_admin_user,
          errors: french_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[csv_content[0]] ||= {}
      self.csv_upload_summary[csv_content[0]]['french-arabic'] = {
        input_phrase: csv_content[2].try(:strip), output_phrase: csv_content[1].try(:strip), 
        category: csv_content[3].try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end
  
end