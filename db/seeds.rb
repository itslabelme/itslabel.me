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
                  { first_name: 'KP Varma',  last_name: "", country: "United Arab Emirates", mobile_number: "+971501370320", organisation: "Right Solutions", email: "krshnaprsad@gmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])
else
  ClientUser.create([
                  { first_name: 'Sherlock',  last_name: "Holmes", country: "United Kingdom", mobile_number: "12345678", organisation: "Conon Doyle", email: "holmes@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Huckleburry',  last_name: "Finn", country: "United States", mobile_number: "12345678", organisation: "DM Studios", email: "finn@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                  { first_name: 'Joan',  last_name: "Arc", country: "France", mobile_number: "12345678", organisation: "French Ltd", email: "joan@yopmail.com", password: "Password@1", password_confirmation: "Password@1"}, 
                ])
end

admin_user = AdminUser.first
client_user = ClientUser.first

# puts "Adding Translations".green
# Translation.create([
#   { input_phrase: "and",                      input_language: "ENGLISH", output_phrase: "و",      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  
#   { input_phrase: "Ingredients",              input_language: "ENGLISH", output_phrase: "مكونات", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Please type your ingredients below",        input_language: "ENGLISH",         output_phrase: "يرجى كتابة المكونات الخاصة بك أدناه",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

#   { input_phrase: "Ingredients",                 input_language: "ENGLISH", output_phrase: "",                                    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Please type your ingredients below",                 input_language: "ENGLISH", output_phrase: "",                   output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

#   { input_phrase: "Corn",                    input_language: "ENGLISH", output_phrase: "حبوب ذرة",                                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Vegetable Oils",          input_language: "ENGLISH", output_phrase: "الزيوت النباتية",                                 output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Cheese Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الجبن",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Milk",                    input_language: "ENGLISH", output_phrase: "ليت",                                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Salt",                    input_language: "ENGLISH", output_phrase: "سيل",                                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Buttermilk Powder",       input_language: "ENGLISH", output_phrase: "مسحوق زبدة الحليب",              output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Wheat Flour",             input_language: "ENGLISH", output_phrase: "دقيق القمح",                            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whey Protein",            input_language: "ENGLISH", output_phrase: "بروتين مصل اللبن",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Concentrate",             input_language: "ENGLISH", output_phrase: "تركيز",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Tomato Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الطماطم",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Flavour Enhancers",       input_language: "ENGLISH", output_phrase: "معززات النكهة",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Onion Powder",            input_language: "ENGLISH", output_phrase: "بودرة البصل",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whey Powder",             input_language: "ENGLISH", output_phrase: "مسحوق مصل اللبن",                  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Garlic Powder",           input_language: "ENGLISH", output_phrase: "مسحوق الثوم",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Dextrose",                input_language: "ENGLISH", output_phrase: "سكر العنب",                              output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Sugar",                   input_language: "ENGLISH", output_phrase: "السكر",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Natural Flavour",         input_language: "ENGLISH", output_phrase: "نكهة طبيعية",                          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Minieral",                input_language: "ENGLISH", output_phrase: "معدني",                                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Food Acids",                  input_language: "ENGLISH", output_phrase: "الأحماض الغذائية",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Lactic Acid",                 input_language: "ENGLISH", output_phrase: "حمض اللاكتيك",                     output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Citric Acid",                 input_language: "ENGLISH", output_phrase: "حمض الستريك",                      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Spice",                             input_language: "ENGLISH", output_phrase: "التوابل",                        output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whitepepper",                 input_language: "ENGLISH", output_phrase: "الفلفل الأبيض",                   output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Colours",                         input_language: "ENGLISH", output_phrase: "الألوان",                           output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

#   { input_phrase: "Corn",                               input_language: "ENGLISH", output_phrase: "blé",                            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Vegetable Oils",           input_language: "ENGLISH", output_phrase: "Les Huiles végétales",      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Cheese Powder",             input_language: "ENGLISH", output_phrase: "Poudre de fromage",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Milk",                               input_language: "ENGLISH", output_phrase: "Lait",                            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Salt",                               input_language: "ENGLISH", output_phrase: "Sel",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Buttermilk Powder",     input_language: "ENGLISH", output_phrase: "Poudre de papillon",            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Wheat Flour",                 input_language: "ENGLISH", output_phrase: "Farine de blé",                output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whey Protein",               input_language: "ENGLISH", output_phrase: "Protéine de whey",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Concentrate",                 input_language: "ENGLISH", output_phrase: "Concentrer",                      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Tomato Powder",             input_language: "ENGLISH", output_phrase: "Poudre de tomate",            output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Flavour Enhancers",     input_language: "ENGLISH", output_phrase: "Exhausteurs de goût",          output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Onion Powder",               input_language: "ENGLISH", output_phrase: "Poudre d'oignon",             output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whey Powder",               input_language: "ENGLISH", output_phrase: "La poudre de lactosérum",  output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Garlic Powder",             input_language: "ENGLISH", output_phrase: "Poudre d'ail",                        output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Dextrose",                       input_language: "ENGLISH", output_phrase: "Dextrose",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Sugar",                             input_language: "ENGLISH", output_phrase: "Sucre",                              output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Natural Flavour",         input_language: "ENGLISH", output_phrase: "Saveur naturelle",               output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Minieral",                       input_language: "ENGLISH", output_phrase: "Minéral",                           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Food Acids",                   input_language: "ENGLISH", output_phrase: "Acides alimentaires",     output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Lactic Acid",                 input_language: "ENGLISH", output_phrase: "Acide lactique",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Citric Acid",                 input_language: "ENGLISH", output_phrase: "Acide citrique",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Spice",                             input_language: "ENGLISH", output_phrase: "Pimenter",                       output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Whitepepper",                 input_language: "ENGLISH", output_phrase: "Poivre blanc",                     output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Colours",                         input_language: "ENGLISH", output_phrase: "Couleurs",                      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

#   { input_phrase: "Biotin",  input_language: "ENGLISH",  output_phrase: "بيوتين",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
#   { input_phrase: "Xylitol", input_language: "ENGLISH",  output_phrase: "إكسيليتول",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
#   { input_phrase: "Amino Acids",  input_language: "ENGLISH",  output_phrase: "أحماض أمينية",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },

#   { input_phrase: "Apple",  input_language: "ENGLISH", output_phrase: "تفاحة", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Mango",  input_language: "ENGLISH", output_phrase: "مانجو", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Grapes",  input_language: "ENGLISH", output_phrase: "عنب",  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

#   { input_phrase: "Apple",  input_language: "ENGLISH", output_phrase: "Pomme", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Mango",  input_language: "ENGLISH", output_phrase: "Mangue", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
#   { input_phrase: "Grapes",  input_language: "ENGLISH", output_phrase: "Les Raisins", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

# ])

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