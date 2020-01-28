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
client_user = ClientUser.first

puts "Adding Translations".green
Translation.create([
  { input_phrase: "Ingredients",        input_description: "Ingredients",         input_language: "ENGLISH", output_phrase: "مكونات",                   output_description: "مكونات",                 output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Please type your ingredients below",        input_description: "Please type your ingredients below",         input_language: "ENGLISH", output_phrase: "يرجى كتابة المكونات الخاصة بك أدناه",                   output_description: "يرجى كتابة المكونات الخاصة بك أدناه",                 output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Ingredients",        input_description: "Ingredients",         input_language: "ENGLISH", output_phrase: "",                   output_description: "Ingrédients",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Please type your ingredients below",        input_description: "Please type your ingredients below",         input_language: "ENGLISH", output_phrase: "",                   output_description: "Veuillez saisir vos ingrédients ci-dessous",                 output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Corn",               input_description: "Corn",                input_language: "ENGLISH", output_phrase: "حبوب ذرة",                 output_description: "حبوب ذرة",               output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Vegetable Oils",     input_description: "Vegetable Oils",      input_language: "ENGLISH", output_phrase: "الزيوت النباتية",          output_description: "",                       output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Cheese Powder",      input_description: "Cheese Powder",       input_language: "ENGLISH", output_phrase: "مسحوق الجبن",              output_description: "مسحوق الجبن",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Milk",               input_description: "Milk",                input_language: "ENGLISH", output_phrase: "ليت",                      output_description: "ليت",                    output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Salt",               input_description: "Salt",                input_language: "ENGLISH", output_phrase: "سيل",                      output_description: "سيل",                    output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Buttermilk Powder",  input_description: "Buttermilk Powder",   input_language: "ENGLISH", output_phrase: "مسحوق زبدة الحليب",        output_description: "مسحوق زبدة الحليب",      output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Wheat Flour",        input_description: "Wheat Flour",         input_language: "ENGLISH", output_phrase: "دقيق القمح",               output_description: "دقيق القمح",             output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Protein",       input_description: "Whey Protein",        input_language: "ENGLISH", output_phrase: "بروتين مصل اللبن",         output_description: "بروتين مصل اللبن",       output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Concentrate",        input_description: "Concentrate",         input_language: "ENGLISH", output_phrase: "تركيز",                    output_description: "تركيز",                  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Tomato Powder",      input_description: "Tomato Powder",       input_language: "ENGLISH", output_phrase: "مسحوق الطماطم",            output_description: "مسحوق الطماطم",          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Flavour Enhancers",  input_description: "Flavour Enhancers",   input_language: "ENGLISH", output_phrase: "معززات النكهة",            output_description: "معززات النكهة",          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Onion Powder",       input_description: "Onion Powder",        input_language: "ENGLISH", output_phrase: "بودرة البصل",              output_description: "بودرة البصل",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Powder",        input_description: "Whey Powder",         input_language: "ENGLISH", output_phrase: "مسحوق مصل اللبن",          output_description: "مسحوق مصل اللبن",        output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Garlic Powder",      input_description: "Garlic Powder",       input_language: "ENGLISH", output_phrase: "مسحوق الثوم",              output_description: "مسحوق الثوم",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Dextrose",           input_description: "Dextrose",            input_language: "ENGLISH", output_phrase: "سكر العنب",                output_description: "سكر العنب",              output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Sugar",              input_description: "Sugar",               input_language: "ENGLISH", output_phrase: "السكر",                    output_description: "السكر",                  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Natural Flavour",    input_description: "Natural Flavour",     input_language: "ENGLISH", output_phrase: "نكهة طبيعية",              output_description: "نكهة طبيعية",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Minieral",           input_description: "Minieral",            input_language: "ENGLISH", output_phrase: "معدني",                    output_description: "معدني",                  output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Food Acids",         input_description: "Food Acids",          input_language: "ENGLISH", output_phrase: "الأحماض الغذائية",         output_description: "الأحماض الغذائية",       output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Lactic Acid",        input_description: "Lactic Acid",         input_language: "ENGLISH", output_phrase: "حمض اللاكتيك",             output_description: "حمض اللاكتيك",           output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Citric Acid",        input_description: "Citric Acid",         input_language: "ENGLISH", output_phrase: "حمض الستريك",              output_description: "حمض الستريك",            output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Spice",              input_description: "Spice",               input_language: "ENGLISH", output_phrase: "التوابل",                  output_description: "التوابل",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whitepepper",        input_description: "Whitepepper",         input_language: "ENGLISH", output_phrase: "الفلفل الأبيض",            output_description: "الفلفل الأبيض",          output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Colours",            input_description: "Colours",             input_language: "ENGLISH", output_phrase: "الألوان",                  output_description: "الألوان",                output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Corn",               input_description: "Corn",                input_language: "ENGLISH", output_phrase: "blé",                      output_description: "blé",                    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Vegetable Oils",     input_description: "Vegetable Oils",      input_language: "ENGLISH", output_phrase: "Les Huiles végétales",     output_description: "Les Huiles végétales",   output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Cheese Powder",      input_description: "Cheese Powder",       input_language: "ENGLISH", output_phrase: "Poudre de fromage",        output_description: "Poudre de fromage",      output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Milk",               input_description: "Milk",                input_language: "ENGLISH", output_phrase: "Lait",                     output_description: "Lait",                   output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Salt",               input_description: "Salt",                input_language: "ENGLISH", output_phrase: "Sel",                      output_description: "Sel",                    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Buttermilk Powder",  input_description: "Buttermilk Powder",   input_language: "ENGLISH", output_phrase: "Poudre de papillon",       output_description: "Poudre de papillon",     output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Wheat Flour",        input_description: "Wheat Flour",         input_language: "ENGLISH", output_phrase: "Farine de blé",            output_description: "Farine de blé",          output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Protein",       input_description: "Whey Protein",        input_language: "ENGLISH", output_phrase: "Protéine de whey",         output_description: "Protéine de whey",       output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Concentrate",        input_description: "Concentrate",         input_language: "ENGLISH", output_phrase: "Concentrer",               output_description: "Concentrer",             output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Tomato Powder",      input_description: "Tomato Powder",       input_language: "ENGLISH", output_phrase: "Poudre de tomate",         output_description: "Poudre de tomate",       output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Flavour Enhancers",  input_description: "Flavour Enhancers",   input_language: "ENGLISH", output_phrase: "Exhausteurs de goût",      output_description: "Exhausteurs de goût",    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Onion Powder",       input_description: "Onion Powder",        input_language: "ENGLISH", output_phrase: "Poudre d'oignon",          output_description: "Poudre d'oignon",        output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whey Powder",        input_description: "Whey Powder",         input_language: "ENGLISH", output_phrase: "La poudre de lactosérum",  output_description: "La poudre de lactosérum",output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Garlic Powder",      input_description: "Garlic Powder",       input_language: "ENGLISH", output_phrase: "Poudre d'ail",             output_description: "Poudre d'ail",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Dextrose",           input_description: "Dextrose",            input_language: "ENGLISH", output_phrase: "Dextrose",                 output_description: "Dextrose",               output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Sugar",              input_description: "Sugar",               input_language: "ENGLISH", output_phrase: "Sucre",                    output_description: "Sucre",                  output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Natural Flavour",    input_description: "Natural Flavour",     input_language: "ENGLISH", output_phrase: "Saveur naturelle",         output_description: "Saveur naturelle",       output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Minieral",           input_description: "Minieral",            input_language: "ENGLISH", output_phrase: "Minéral",                  output_description: "Minéral",                output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Food Acids",         input_description: "Food Acids",          input_language: "ENGLISH", output_phrase: "Acides alimentaires",      output_description: "Acides alimentaires",    output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Lactic Acid",        input_description: "Lactic Acid",         input_language: "ENGLISH", output_phrase: "Acide lactique",           output_description: "Acide lactique",         output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Citric Acid",        input_description: "Citric Acid",         input_language: "ENGLISH", output_phrase: "Acide citrique",           output_description: "Acide citrique",         output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Spice",              input_description: "Spice",               input_language: "ENGLISH", output_phrase: "Pimenter",                 output_description: "Pimenter",               output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Whitepepper",        input_description: "Whitepepper",         input_language: "ENGLISH", output_phrase: "Poivre blanc",             output_description: "Poivre blanc",           output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Colours",            input_description: "Colours",             input_language: "ENGLISH", output_phrase: "Couleurs",                 output_description: "Couleurs",               output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Biotin", input_description: "Biotin", input_language: "ENGLISH",  output_phrase: "بيوتين", output_description: "بيوتين", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
  { input_phrase: "Xylitol", input_description: "Xylitol", input_language: "ENGLISH",  output_phrase: "إكسيليتول", output_description: "إكسيليتول", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },
  { input_phrase: "Amino Acids", input_description: "Amino Acids", input_language: "ENGLISH",  output_phrase: "أحماض أمينية", output_description: "أحماض أمينية", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED" },

  { input_phrase: "Apple", input_description: "Apple", input_language: "ENGLISH", output_phrase: "تفاحة", output_description: "تفاحة", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Mango", input_description: "Mango", input_language: "ENGLISH", output_phrase: "مانجو", output_description: "مانجو", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Grapes", input_description: "Grapes", input_language: "ENGLISH", output_phrase: "عنب", output_description: "عنب", output_language: "ARABIC", admin_user_id: admin_user.id, status: "APPROVED"},

  { input_phrase: "Apple", input_description: "Apple", input_language: "ENGLISH", output_phrase: "Pomme", output_description: "Pomme", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Mango", input_description: "Mango", input_language: "ENGLISH", output_phrase: "Mangue", output_description: "Mangue", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},
  { input_phrase: "Grapes", input_description: "Grapes", input_language: "ENGLISH", output_phrase: "Les Raisins", output_description: "Les Raisins", output_language: "FRENCH", admin_user_id: admin_user.id, status: "APPROVED"},

])

puts "Adding Tags".green
Tag.create([
  {name: "Gulf Food"},
  {name: "Colman Mustard"},
  {name: "Marmite (2020)"},
  {name: "Marmite (2019)"},
  {name: "Marmite (2018)"}
])

puts "Adding Templates".green
LabelTemplate.create([
  {
    name: "Simple Template 1",
    description: "A Basic template with some ingedients put as an example",
    style: "template_preview_1",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>}
  },
  {
    name: "Simple Template 2",
    description: "Simple Template 1",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Simple Template 3",
    description: "Simple Template 2",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Simple Template 4",
    description: "Simple Template 3",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  {
    name: "Simple Template 5",
    description: "Simple Template 4",
    style: "template_preview_2",
    ltr_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>},
    rtl_html_source: %{<html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">Please type your ingredients below</td></tr></tbody></table></body></html>}
  },
  
])

template = LabelTemplate.first

puts "Adding Documents".green
Document::TemplateBased.create([
  {title: "Sample Document 1", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
  {title: "Sample Document 2", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
  {title: "Sample Document 3", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
  {title: "Sample Document 4", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
  {title: "Sample Document 5", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
  {title: "Sample Document 6", description: "Some Description", input_language: "ENGLISH", output_1_language: "ARABIC", output_2_language: "FRENCH", template: template, user: client_user},
])
