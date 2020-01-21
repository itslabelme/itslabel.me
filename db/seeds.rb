require 'colorize'

puts "Adding Admin Users".green
AdminUser.create([
                  { first_name: 'Krishna Prasad',  last_name: "Varma", mobile_number: "12345678", email: "krishna@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Sanoop',  last_name: "Nair", mobile_number: "12345678", email: "sanoop@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Vedaditya',  last_name: "Nirankar", mobile_number: "12345678", email: "nirankar@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                ])

puts "Adding Client Users".green
ClientUser.create([
                  { first_name: 'Sherlock',  last_name: "Holmes", country: "United Kingdom", mobile_number: "12345678", organisation: "Conon Doyle", email: "holmes@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Huckleburry',  last_name: "Finn", country: "United States", mobile_number: "12345678", organisation: "DM Studios", email: "finn@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Joan',  last_name: "Arc", country: "France", mobile_number: "12345678", organisation: "French Ltd", email: "joan@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])

admin_user = AdminUser.first

puts "Adding Translations".green
Translation.create([
                  {
                    input_phrase: "Biotin", input_description: "Biotin", input_language: "ENGLISH", 
                    output_phrase: "بيوتين", output_description: "بيوتين", output_language: "ARABIC",
                    admin_user_id: admin_user.id, status: "APPROVED" 
                  },
                  {
                    input_phrase: "Xylitol", input_description: "Xylitol", input_language: "ENGLISH", 
                    output_phrase: "إكسيليتول", output_description: "إكسيليتول", output_language: "ARABIC",
                    admin_user_id: admin_user.id, status: "APPROVED" 
                  },
                  {
                    input_phrase: "Amino Acids", input_description: "Amino Acids", input_language: "ENGLISH", 
                    output_phrase: "أحماض أمينية", output_description: "أحماض أمينية", output_language: "ARABIC",
                    admin_user_id: admin_user.id, status: "APPROVED" 
                  }
                ])

