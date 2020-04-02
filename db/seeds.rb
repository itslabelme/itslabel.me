require 'colorize'

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
                  { first_name: 'KP Varma',  last_name: "", country: "AE", mobile_number: "+971501370320", organisation: "Right Solutions", email: "krshnaprsad@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])
else
  ClientUser.create([
                  { first_name: 'Sherlock',  last_name: "Holmes", country: "GB", mobile_number: "12345678", organisation: "Conon Doyle", email: "holmes@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Huckleburry',  last_name: "Finn", country: "US", mobile_number: "12345678", organisation: "DM Studios", email: "finn@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Joan',  last_name: "Arc", country: "FR", mobile_number: "12345678", organisation: "French Ltd", email: "joan@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])
end

admin_user = AdminUser.first
client_user = ClientUser.first

puts "Adding Translations".green
Translation.create([
  { english_phrase: "and",arabic_phrase: "و",french_phrase: "et", admin_user_id: admin_user.id, status: "APPROVED"},
  
  { english_phrase: "Ingredients", arabic_phrase: "مكونات",french_phrase: "Ingrédients" , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Please type your ingredients below", arabic_phrase: "يرجى كتابة المكونات الخاصة بك أدناه",french_phrase: "Veuillez saisir vos ingrédients ci-dessous", admin_user_id: admin_user.id, status: "APPROVED"},


  { english_phrase: "Corn",arabic_phrase: "حبوب ذرة",french_phrase: "", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Vegetable Oils",          arabic_phrase: "الزيوت النباتية",french_phrase: "Les huiles végétales", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Cheese Powder",           arabic_phrase: "مسحوق الجبن",french_phrase: "Fromage en poudre", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Milk",                    arabic_phrase: "ليت",french_phrase: "Lait", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Salt",                    arabic_phrase: "سيل",french_phrase: "Sel", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Buttermilk Powder",       arabic_phrase: "مسحوق زبدة الحليب", french_phrase: "Poudre de babeurre"             , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Wheat Flour",             arabic_phrase: "دقيق القمح",   french_phrase: "Farine de blé"                  , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Whey Protein",            arabic_phrase: "بروتين مصل اللبن",french_phrase: "Protéine de lactosérum"               , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Concentrate",             arabic_phrase: "تركيز",   french_phrase: "Concentrer"                       , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Tomato Powder",           arabic_phrase: "مسحوق الطماطم", french_phrase: "Poudre de tomate"                 , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Flavour Enhancers",       arabic_phrase: "معززات النكهة",french_phrase: "Exhausteurs de goût"            , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Onion Powder",            arabic_phrase: "بودرة البصل", french_phrase: "Poudre d'oignon"                   , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Whey Powder",             arabic_phrase: "مسحوق مصل اللبن", french_phrase: "La poudre de lactosérum"               , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Garlic Powder",           arabic_phrase: "مسحوق الثوم",  french_phrase: "Poudre d'ail"                  ,admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Dextrose",                arabic_phrase: "سكر العنب", french_phrase: "Dextrose"                      , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Sugar",                   arabic_phrase: "السكر",  french_phrase: "Sucre"                         , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Natural Flavour",         arabic_phrase: "معدني", french_phrase: "Saveur naturelle"                          , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Food Acids",              arabic_phrase: "الأحماض الغذائية",  french_phrase: "Acides alimentaires"              , admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Lactic Acid",             arabic_phrase: "حمض اللاكتيك",  french_phrase: "Acide lactique", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Citric Acid",             arabic_phrase: "حمض الستريك",french_phrase:"", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Spice",                      arabic_phrase: "التوابل", french_phrase:"", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Whitepepper",            arabic_phrase: "الفلفل الأبيض",  french_phrase:"", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Colours",                  arabic_phrase: "الألوان",   french_phrase:"", admin_user_id: admin_user.id, status: "APPROVED"},

  

  { english_phrase: "Biotin",  arabic_phrase: "بيوتين",  french_phrase:"La biotine", admin_user_id: admin_user.id, status: "APPROVED" },
  { english_phrase: "Xylitol", arabic_phrase: "إكسيليتول",  french_phrase:"Xylitol", admin_user_id: admin_user.id, status: "APPROVED" },
  { english_phrase: "Amino Acids", arabic_phrase: "أحماض أمينية",  french_phrase:"Acides aminés", admin_user_id: admin_user.id, status: "APPROVED" },

  { english_phrase: "or", arabic_phrase: "أو", french_phrase:"ou", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Mango", arabic_phrase: "مانجو", french_phrase:"Mangue", admin_user_id: admin_user.id, status: "APPROVED"},
  { english_phrase: "Grapes",  arabic_phrase: "عنب",  french_phrase:"les raisins", admin_user_id: admin_user.id, status: "APPROVED"}

  

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

#template = LabelTemplate.first

# puts "Adding Documents".green
# TemplateDocument.create([
#   {title: "Template Document 1", input_language: "ENGLISH", output_language: "ARABIC", template: template, user: client_user},
#   {title: "Template Document 2", input_language: "ENGLISH", french_phrase:"", template: template, user: client_user},
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