require 'colorize'

puts "Adding Subscriptions".green

# Adding free subscription
Subscription.create([{ title: 'Free',  price: "0", status: "Active"}])

# Adding other subscritions
susbscription_date = [
      { title: 'Monthly',  price: 49.99, status: "Active"}, 
      { title: '3 Months',  price: 149.99, status: "Active"},
      { title: '6 Months',  price: 269.99, status: "Active"}, 
      { title: '12 Months',  price: 509.99, status: "Active"}, 
  ]

susbscription_date.each do |sub_data|
  susbscription = Subscription.new
  susbscription.title = sub_data[:title]
  susbscription.price = sub_data[:price]
  susbscription.status = sub_data[:status]

  if susbscription.valid?
    susbscription.save
  else
    puts "Couldn't save susbscription with title #{sub_data[:title]}".red
  end
end

puts "Adding Admin Users".green
if Rails.env.production?
  AdminUser.create([
                  { first_name: 'Ben',  last_name: "Castree", mobile_number: "12345678", email: "Ben.castree@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Abdul Karim',  last_name: "Samaan", mobile_number: "12345678", email: "akarim.samaan@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Hari',  last_name: "Kuppuswamy", mobile_number: "12345678", email: "harishsmc@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Krishna Prasad',  last_name: "Varma", mobile_number: "12345678", email: "krishna@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}
                ])

else
  AdminUser.create([
                  { first_name: 'Ben',  last_name: "Castree", mobile_number: "12345678", email: "Ben.castree@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Abdul Karim',  last_name: "Samaan", mobile_number: "12345678", email: "akarim.samaan@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Hari',  last_name: "Kuppuswamy", mobile_number: "12345678", email: "harishsmc@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Krishna Prasad',  last_name: "Varma", mobile_number: "12345678", email: "krishna@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Sanoop',  last_name: "Nair", mobile_number: "12345678", email: "sanoop@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Vedaditya',  last_name: "Nirankar", mobile_number: "12345678", email: "nirankar@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1"}, 
                ])
end

puts "Adding Client Users".green
if Rails.env.production?
  ClientUser.create([
                  { first_name: 'KP Varma',  last_name: "", country: "AE", mobile_number: "+971501370320", organisation: "Right Solutions", email: "krshnaprsad@gmail.com", password: "Password@1", password_confirmation: "Password@1", t_c_accepted: true, position: "manager"}, 
                ])
else
  ClientUser.create([
                  { first_name: 'Sherlock',  last_name: "Holmes", country: "GB", mobile_number: "12345678", organisation: "Conon Doyle", email: "holmes@yopmail.com", password: "Password@1", password_confirmation: "Password@1", position: "manager", t_c_accepted: true},
                  { first_name: 'anoop',  last_name: "s", country: "GB", mobile_number: "12345678", organisation: "Conon Doyle", email: "anoop@yopmail.com", password: "Password@1", password_confirmation: "Password@1", position: "manager", t_c_accepted: true},
                  #{ first_name: 'Athira',  last_name: "Nair", country: "GB", mobile_number: "12345678", organisation: "Rigt Solution", email: "athira@rightsolutions.ae", password: "Password@1", password_confirmation: "Password@1", position: "developer", t_c_accepted: true}, 
                  # { first_name: 'Huckleburry',  last_name: "Finn", country: "US", mobile_number: "12345678", organisation: "DM Studios", email: "finn@yopmail.com", password: "Password@1", password_confirmation: "Password@1", t_c_accepted: True}, 
                  # { first_name: 'Joan',  last_name: "Arc", country: "FR", mobile_number: "12345678", organisation: "French Ltd", email: "joan@yopmail.com", password: "Password@1", password_confirmation: "Password@1", t_c_accepted: True}, 
                ])
end

admin_user = AdminUser.first
client_user = ClientUser.first

puts "Adding Translations".green
Translation.create([
  { input_phrase: "and",                      input_language: "ENGLISH", output_phrase: "و",      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  
  { input_phrase: "Ingredients",              input_language: "ENGLISH", output_phrase: "مكونات", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Please type your ingredients below",        input_language: "ENGLISH",         output_phrase: "يرجى كتابة المكونات الخاصة بك أدناه",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Ingredients",                 input_language: "ENGLISH", output_phrase: "",                                    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Please type your ingredients below",                 input_language: "ENGLISH", output_phrase: "",                   output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Corn",                    input_language: "ENGLISH", output_phrase: "حبوب ذرة",                                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Vegetable Oils",          input_language: "ENGLISH", output_phrase: "الزيوت النباتية",                                 output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Cheese Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الجبن",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Milk",                    input_language: "ENGLISH", output_phrase: "ليت",                                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Salt",                    input_language: "ENGLISH", output_phrase: "سيل",                                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Buttermilk Powder",       input_language: "ENGLISH", output_phrase: "مسحوق زبدة الحليب",              output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Wheat Flour",             input_language: "ENGLISH", output_phrase: "دقيق القمح",                            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Protein",            input_language: "ENGLISH", output_phrase: "بروتين مصل اللبن",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Concentrate",             input_language: "ENGLISH", output_phrase: "تركيز",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Tomato Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الطماطم",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Flavour Enhancers",       input_language: "ENGLISH", output_phrase: "معززات النكهة",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Onion Powder",            input_language: "ENGLISH", output_phrase: "بودرة البصل",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Powder",             input_language: "ENGLISH", output_phrase: "مسحوق مصل اللبن",                  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Garlic Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الثوم",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Dextrose",                input_language: "ENGLISH", output_phrase: "سكر العنب",                              output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Sugar",                   input_language: "ENGLISH", output_phrase: "السكر",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Natural Flavour",         input_language: "ENGLISH", output_phrase: "نكهة طبيعية",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Minieral",                input_language: "ENGLISH", output_phrase: "معدني",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Food Acids",                  input_language: "ENGLISH", output_phrase: "الأحماض الغذائية",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Lactic Acid",                 input_language: "ENGLISH", output_phrase: "حمض اللاكتيك",                     output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Citric Acid",                 input_language: "ENGLISH", output_phrase: "حمض الستريك",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Spice",                             input_language: "ENGLISH", output_phrase: "التوابل",                        output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whitepepper",                 input_language: "ENGLISH", output_phrase: "الفلفل الأبيض",                   output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Colours",                         input_language: "ENGLISH", output_phrase: "الألوان",                           output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Corn",                               input_language: "ENGLISH", output_phrase: "blé",                            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Vegetable Oils",           input_language: "ENGLISH", output_phrase: "Les Huiles végétales",      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Cheese Powder",             input_language: "ENGLISH", output_phrase: "Poudre de fromage",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Milk",                               input_language: "ENGLISH", output_phrase: "Lait",                            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Salt",                               input_language: "ENGLISH", output_phrase: "Sel",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Buttermilk Powder",     input_language: "ENGLISH", output_phrase: "Poudre de papillon",            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Wheat Flour",                 input_language: "ENGLISH", output_phrase: "Farine de blé",                output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Protein",               input_language: "ENGLISH", output_phrase: "Protéine de whey",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Concentrate",                 input_language: "ENGLISH", output_phrase: "Concentrer",                      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Tomato Powder",             input_language: "ENGLISH", output_phrase: "Poudre de tomate",            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Flavour Enhancers",     input_language: "ENGLISH", output_phrase: "Exhausteurs de goût",          output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Onion Powder",               input_language: "ENGLISH", output_phrase: "Poudre d'oignon",             output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Powder",               input_language: "ENGLISH", output_phrase: "La poudre de lactosérum",  output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Garlic Powder",             input_language: "ENGLISH", output_phrase: "Poudre d'ail",                        output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Dextrose",                       input_language: "ENGLISH", output_phrase: "Dextrose",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Sugar",                             input_language: "ENGLISH", output_phrase: "Sucre",                              output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Natural Flavour",         input_language: "ENGLISH", output_phrase: "Saveur naturelle",               output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Minieral",                       input_language: "ENGLISH", output_phrase: "Minéral",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Food Acids",                   input_language: "ENGLISH", output_phrase: "Acides alimentaires",     output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Lactic Acid",                 input_language: "ENGLISH", output_phrase: "Acide lactique",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Citric Acid",                 input_language: "ENGLISH", output_phrase: "Acide citrique",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Spice",                             input_language: "ENGLISH", output_phrase: "Pimenter",                       output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whitepepper",                 input_language: "ENGLISH", output_phrase: "Poivre blanc",                     output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Colours",                         input_language: "ENGLISH", output_phrase: "Couleurs",                      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Biotin",  input_language: "ENGLISH",  output_phrase: "بيوتين",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
  { input_phrase: "Xylitol", input_language: "ENGLISH",  output_phrase: "إكسيليتول",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
  { input_phrase: "Amino Acids",  input_language: "ENGLISH",  output_phrase: "أحماض أمينية",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },

  { input_phrase: "Apple",  input_language: "ENGLISH", output_phrase: "تفاحة", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Mango",  input_language: "ENGLISH", output_phrase: "مانجو", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Grapes",  input_language: "ENGLISH", output_phrase: "عنب",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Apple",  input_language: "ENGLISH", output_phrase: "Pomme", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Mango",  input_language: "ENGLISH", output_phrase: "Mangue", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Grapes",  input_language: "ENGLISH", output_phrase: "Les Raisins", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

])

# puts "Adding Tags".green
# Tag.create([
#   {name: "Gulf Food"},
#   {name: "Colman Mustard"},
#   {name: "Marmite (2020)"},
#   {name: "Marmite (2019)"},
#   {name: "Marmite (2018)"}
# ])

puts "Adding Templates".green
LabelTemplate.create([
  {
    name: "Square Template",
    latest: true,
    description: "A Simple template with some ingedients put as an example",
    style: "Basic",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>}
  },
  {
    name: "Square Template",
    latest: true,
    description: "Simple Template 1",
    style: "with Distributor",
    ltr_html_source: %{},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Vertical Template",
    latest: true,
    description: "Basic",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Vertical Template - 300",
    latest: false,
    description: "with Distributor",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Old Template",
    latest: false,
    description: "the First Template we created",
    style: "Old Style",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  
])


puts "Adding Permissions".green

  Permission.create([
                  { title: 'Dashboard',  description: "Home", permission_group: "Dashboard",route:'home#index'}, 

                  { title: 'Free From Widget',  description: "free_form_widget", permission_group: "Free Form",route:'free_form_widget#index'}, 
                 # { title: 'Free From Widget Translate',  description: "free_form_widget", permission_group: "Free Form",route:'free_form_widget#translate'},
                  { title: 'New Free From Translate',  description: "free_form_widget", permission_group: "Free Form",route:'free_form_widget#new_translation_request'},
                 # { title: 'Free From Save Translate',  description: "free_form_widget", permission_group: "Free Form",route:'free_form_widget#create_translation_request'},

               #   { title: 'Table Docoment CSV Upload',  description: "free_form_widget", permission_group: "Table Import",route:'table_documents#csv_upload'},
               #   { title: 'Table Docoment CSV Parse',  description: "free_form_widget", permission_group: "Table Import",route:'table_documents#csv_parse'},

                  
                  { title: 'Documents',  description: "Documents", permission_group: "Documents",route:'documents#index'}, 
                  #{ title: 'Document Update Status',  description: "Documents", permission_group: "Documents",route:'documents#update_status'}, 
                  #{ title: 'Delete Document',  description: "Documents", permission_group: "Documents",route:'documents#destroy'},
                  
                  { title: 'New Template Translate',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#save_and_translate'}, 
                  { title: 'Preview Template Document',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#preview'}, 
                


                #  { title: 'Print Template',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#print'}, 
                 # { title: 'Update Template Status',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#update_status'}, 
                  { title: 'Template Document',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#select_template'}, 
                  { title: 'Select Template',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#index'}, 
                 # { title: 'Save New Template',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#create'}, 
                  { title: 'New Template',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#new'}, 
                 # { title: 'Show Template Document',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#show'}, 
                 # { title: 'Update Template Document',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#update'}, 
                 # { title: 'Destroy Template Document',  description: "TemplateDocuments", permission_group: "Template",route:'template_documents#destroy'}, 
                  
                  { title: 'List Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#index'}, 
                 # { title: 'Save New Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#create'}, 
                  { title: 'New Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#new'}, 
                 # { title: 'Show Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#show'}, 
                 # { title: 'Edit Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#edit'}, 
                  #{ title: 'Update Table Document',  description: "TableDocuments", permission_group: "TableDocuments",route:'table_documents#update'}, 
                  
                 # { title: 'Client Profile',  description: "ClientProfile", permission_group: "Profile",route:'client_profile#edit'}, 
                #  { title: 'Update Profile ',  description: "ClientProfile", permission_group: "Profile",route:'client_profile#update'}, 
                #  { title: 'Update Client Profile Password',  description: "ClientProfile", permission_group: "Profile",route:'client_profile#update_password'}, 
                  
               #   { title: 'User Subscription',  description: "UserSubscription", permission_group: "Subscription",route:'user_subscriptions#index'}, 
                 # { title: 'Save Subscription',  description: "UserSubscription", permission_group: "Subscription",route:'user_subscriptions#create'}, 
               #   { title: 'Add Subscription',  description: "UserSubscription", permission_group: "Subscription",route:'user_subscriptions#new'}, 
                #  { title: 'Edit Subscription',  description: "UserSubscription", permission_group: "Subscription",route:'user_subscriptions#edit'}, 
                #  { title: 'Update Subscription',  description: "UserSubscription", permission_group: "Subscription",route:'user_subscriptions#update'}, 
                ])
              
puts "Adding Subscription Permissions".green

  SubscriptionPermission.create([
        { title: 'Free',  permission_id: "1", subscription_id: "1"}, 
        { title: 'Free',  permission_id: "2", subscription_id: "1"}, 
        { title: 'Free',  permission_id: "3", subscription_id: "1"}, 
        { title: 'Free',  permission_id: "4", subscription_id: "1"}, 
        { title: 'Free',  permission_id: "5", subscription_id: "1"}, 
        { title: 'Free',  permission_id: "6", subscription_id: "1"}, 

        { title: 'Premium',  permission_id: "1", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "2", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "3", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "4", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "5", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "6", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "7", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "8", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "9", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "10", subscription_id: "2"}, 
        { title: 'Premium',  permission_id: "11", subscription_id: "2"}, 
     
     ])

#   a = AdminUser.first

#    t = TranslationQueryHistory.create(
#   input_language: "input_language", 
#   output_language: "output_language",
#   input_phrase: "input_text", 
#   output_phrase: "input_text", 
#   error: false,
#   error_message: "error_message",
#   admin_user: a,
#   doc_type: 'Free Form',
#   status: "ACTIVE"
# )

#template = LabelTemplate.first

# puts "Adding Documents".green
# TemplateDocument.create([
#   {title: "Template Document 1", input_language: "ENGLISH", output_language: "ARABIC", template: template, user: client_user},
#   {title: "Template Document 2", input_language: "ENGLISH", output_language: "FRENCH", template: template, user: client_user},
#   {title: "Template Document 3", input_language: "ENGLISH", output_language: "ARABIC", template: template, user: client_user},
#   {title: "Template Document 4", input_language: "FRENCH", output_language: "ENGLISH", template: template, user: client_user},
#   {title: "Template Document 5", input_language: "FRENCH", output_language: "ARABIC", template: template, user: client_user},
#   {title: "Template Document 6", input_language: "ARABIC", output_language: "ENGLISH", template: template, user: client_user},
# ])

# TableDocument.create([
#   {title: "Table Document 1", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", user: client_user},
#   {title: "Table Document 2", input_language: "ARABIC", output_1_language: "ENGLISH", output_2_language: "FRENCH", user: client_user},
#   {title: "Table Document 3", input_language: "FRENCH", output_1_language: "ARABIC", output_2_language: "ENGLISH", user: client_user},
#   {title: "Table Document 4", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", user: client_user},
#   {title: "Table Document 5", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", user: client_user},
#   {title: "Table Document 6", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", user: client_user},
# ])