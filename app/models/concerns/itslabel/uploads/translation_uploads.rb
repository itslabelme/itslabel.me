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
    
    category = csv_contents[0]
    english_phrase = csv_contents[1]
    arabic_phrase = csv_contents[2]
    french_phrase = csv_contents[3]
    spanish_phrase = csv_contents[4]

    csv_contents.each do |csv_content|
      begin
        if english_phrase && arabic_phrase
          er_data,  ex_data,  in_data = add_english_to_arabic_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-arabic'] = {
            input_phrase: english_phrase, output_phrase: arabic_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end

        if english_phrase && french_phrase
          er_data,  ex_data,  in_data = add_english_to_french_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-french'] = {
            input_phrase: english_phrase, output_phrase: french_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end

        if english_phrase && spanish_phrase
          er_data,  ex_data,  in_data = add_english_to_spanish_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-spanish'] = {
            input_phrase: english_phrase, output_phrase: spanish_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end  

        if arabic_phrase && english_phrase
          er_data,  ex_data,  in_data = add_arabic_to_english_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-english'] = {
            input_phrase: arabic_phrase, output_phrase: english_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if arabic_phrase && french_phrase
          er_data,  ex_data,  in_data = add_arabic_to_french_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-french'] = {
            input_phrase: arabic_phrase, output_phrase: french_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if arabic_phrase && spanish_phrase
          er_data,  ex_data,  in_data = add_arabic_to_spanish_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-spanish'] = {
            input_phrase: arabic_phrase, output_phrase: spanish_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end

        if french_phrase && english_phrase
          er_data,  ex_data,  in_data = add_french_to_english_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-english'] = {
            input_phrase: french_phrase, output_phrase: english_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if french_phrase && arabic_phrase
          er_data,  ex_data,  in_data = add_french_to_arabic_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-arabic'] = {
            input_phrase: french_phrase, output_phrase: arabic_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if french_phrase && spanish_phrase
          er_data,  ex_data,  in_data = add_french_to_spanish_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-spanish'] = {
            input_phrase: french_phrase, output_phrase: spanish_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if spanish_phrase && english_phrase
          er_data,  ex_data,  in_data = add_spanish_to_english_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-english'] = {
            input_phrase: spanish_phrase, output_phrase: english_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if spanish_phrase && arabic_phrase
          er_data,  ex_data,  in_data = add_spanish_to_arabic_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-arabic'] = {
            input_phrase: spanish_phrase, output_phrase: arabic_phrase, 
            category: category, admin_user: current_admin_user,
            errors: ["Content Missing"]
          }
        end 

        if spanish_phrase && french_phrase
          er_data,  ex_data,  in_data = add_spanish_to_french_translation(csv_content, current_admin_user)
          error_data += er_data
          existing_data += ex_data
          inserted_data += in_data
        else
          error_data += 1
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-french'] = {
            input_phrase: spanish_phrase, output_phrase: french_phrase, 
            category: category, admin_user: current_admin_user,
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

  # English translations
  def add_english_to_arabic_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    english_arabic_translation = Translation.where(
      input_language: "ENGLISH",  output_language: "ARABIC",
      input_phrase: english_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip)
      ).first

    if english_arabic_translation.nil?
      english_arabic_translation ||= Translation.new(
        input_language: "ENGLISH",  output_language: "ARABIC",
        input_phrase: english_phrase.try(:strip),  output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )
      if english_arabic_translation.valid?
        if english_arabic_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-arabic'] ||= true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['english-arabic'] = {
          input_phrase: english_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: english_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['english-arabic'] = {
        input_phrase: english_phrase, output_phrase: arabic_phrase, 
        category: category, admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end 
    return error_data,  existing_data,  inserted_data
  end

  def add_english_to_french_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    english_french_translation = Translation.where(
        input_language: "ENGLISH", output_language: "FRENCH",
        input_phrase: english_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
        ).first
    if english_french_translation.nil?
      english_french_translation ||= Translation.new(
        input_language: "ENGLISH", output_language: "FRENCH",
        input_phrase: english_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if english_french_translation.valid?
        if english_french_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-french'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['english-french'] = {
          input_phrase: english_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: english_french_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['english-french'] = {
        input_phrase: english_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_english_to_spanish_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    english_spanish_translation = Translation.where(
        input_language: "ENGLISH", output_language: "SPANISH",
        input_phrase: english_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        ).first
    if english_spanish_translation.nil?
      english_spanish_translation ||= Translation.new(
        input_language: "ENGLISH", output_language: "SPANISH",
        input_phrase: english_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if english_spanish_translation.valid?
        if english_spanish_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['english-spanish'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['english-spanish'] = {
          input_phrase: english_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: english_spanish_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['english-spanish'] = {
        input_phrase: english_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  # Arabic translations
  def add_arabic_to_english_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    arabic_english_translation = Translation.where(
        input_language: "ARABIC", output_language: "ENGLISH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: english_phrase.try(:strip)
        ).first
    if arabic_english_translation.nil?
      arabic_english_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "ENGLISH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if arabic_english_translation.valid?
        if arabic_english_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-english'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['arabic-english'] = {
          input_phrase: arabic_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: arabic_english_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['arabic-english'] = {
        input_phrase: arabic_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_arabic_to_french_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    arabic_french_translation = Translation.where(
        input_language: "ARABIC", output_language: "FRENCH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: french_phrase.try(:strip)
        ).first
    if arabic_french_translation.nil?
      arabic_french_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "FRENCH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if arabic_french_translation.valid?
        if arabic_french_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-french'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['arabic-french'] = {
          input_phrase: arabic_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: arabic_french_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['arabic-french'] = {
        input_phrase: arabic_phrase.try(:strip), output_phrase: french_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_arabic_to_spanish_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    arabic_french_translation = Translation.where(
        input_language: "ARABIC", output_language: "SPANISH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip)
        ).first
    if arabic_spanish_translation.nil?
      arabic_spanish_translation ||= Translation.new(
        input_language: "ARABIC", output_language: "SPANISH",
        input_phrase: arabic_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if arabic_spanish_translation.valid?
        if arabic_spanish_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['arabic-spanish'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['arabic-spanish'] = {
          input_phrase: arabic_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: arabic_spanish_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['arabic-spanish'] = {
        input_phrase: arabic_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  # French translations
  def add_french_to_english_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    french_english_translation = Translation.where(
        input_language: "FRENCH", output_language: "ENGLISH",
        input_phrase: french_phrase.try(:strip), output_phrase: english_phrase.try(:strip)
        ).first 
    if french_english_translation.nil?
      french_english_translation ||= Translation.new(
        input_language: "FRENCH", output_language: "ENGLISH",
        input_phrase: french_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if french_english_translation.valid?
        if french_english_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-english'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['french-english'] = {
          input_phrase: french_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: french_english_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['french-english'] = {
        input_phrase: french_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_french_to_arabic_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    french_arabic_translation = Translation.where(
        input_language: "FRENCH",  output_language: "ARABIC",
        input_phrase: french_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip)
        ).first

    if french_arabic_translation.nil?
      french_arabic_translation ||= Translation.new(
        input_language: "FRENCH",  output_language: "ARABIC",
        input_phrase: french_phrase.try(:strip),  output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if french_arabic_translation.valid?
        if french_arabic_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-arabic'] = true
         inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['french-arabic'] = {
          input_phrase: french_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: french_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['french-arabic'] = {
        input_phrase: french_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_french_to_spanish_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    french_spanish_translation = Translation.where(
        input_language: "FRENCH",  output_language: "SPANISH",
        input_phrase: french_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip)
        ).first

    if french_spanish_translation.nil?
      french_spanish_translation ||= Translation.new(
        input_language: "FRENCH",  output_language: "SPANISH",
        input_phrase: french_phrase.try(:strip),  output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if french_spanish_translation.valid?
        if french_spanish_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['french-spanish'] = true
         inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['french-spanish'] = {
          input_phrase: french_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: french_spanish_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['french-spanish'] = {
        input_phrase: french_phrase.try(:strip), output_phrase: spanish_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  # Spanish translations
  def add_spanish_to_english_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    spanish_english_translation = Translation.where(
        input_language: "SPANISH", output_language: "ENGLISH",
        input_phrase: spanish_phrase.try(:strip), output_phrase: english_phrase.try(:strip)
        ).first 
    if spanish_english_translation.nil?
      spanish_english_translation ||= Translation.new(
        input_language: "SPANISH", output_language: "ENGLISH",
        input_phrase: spanish_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if spanish_english_translation.valid?
        if spanish_english_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-english'] = true
          inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['spanish-english'] = {
          input_phrase: spanish_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: spanish_english_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['spanish-english'] = {
        input_phrase: spanish_phrase.try(:strip), output_phrase: english_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_spanish_to_arabic_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    spanish_arabic_translation = Translation.where(
        input_language: "SPANISH",  output_language: "ARABIC",
        input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip)
        ).first

    if spanish_arabic_translation.nil?
      spanish_arabic_translation ||= Translation.new(
        input_language: "SPANISH",  output_language: "ARABIC",
        input_phrase: spanish_phrase.try(:strip),  output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if spanish_arabic_translation.valid?
        if spanish_arabic_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-arabic'] = true
         inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['spanish-arabic'] = {
          input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: spanish_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['spanish-arabic'] = {
        input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end

  def add_spanish_to_french_translation(csv_content, current_admin_user)
    error_data = 0
    existing_data = 0
    inserted_data = 0

    category = csv_content[0]
    english_phrase = csv_content[1]
    arabic_phrase = csv_content[2]
    french_phrase = csv_content[3]
    spanish_phrase = csv_content[4]

    spanish_arabic_translation = Translation.where(
        input_language: "SPANISH",  output_language: "FRENCH",
        input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip)
        ).first

    if spanish_arabic_translation.nil?
      spanish_arabic_translation ||= Translation.new(
        input_language: "SPANISH",  output_language: "FRENCH",
        input_phrase: spanish_phrase.try(:strip),  output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        status: "APPROVED"
      )

      if spanish_arabic_translation.valid?
        if spanish_arabic_translation.save
          self.csv_upload_summary[english_phrase] ||= {}
          self.csv_upload_summary[english_phrase]['spanish-arabic'] = true
         inserted_data = 1
        end
      else
        error_data = 1
        self.csv_upload_summary[english_phrase]['spanish-arabic'] = {
          input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
          category: category.try(:strip), admin_user: current_admin_user,
          errors: spanish_arabic_translation.errors.full_messages
        }
      end
    else
      existing_data = 1
      self.csv_upload_summary[english_phrase] ||= {}
      self.csv_upload_summary[english_phrase]['spanish-arabic'] = {
        input_phrase: spanish_phrase.try(:strip), output_phrase: arabic_phrase.try(:strip), 
        category: category.try(:strip), admin_user: current_admin_user,
        errors: ["Content is already in the database"]
      }
    end
    return error_data,  existing_data,  inserted_data
  end
  
end