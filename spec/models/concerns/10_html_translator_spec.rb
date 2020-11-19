require 'rails_helper'
require './spec/models/concerns/00_context.rb'

RSpec.describe Translation, type: :model do

  include_context 'dataset'

  context "HTML Translations" do
    it "should translate html input" do
      input_html =  %{ <div><span>10g</span></div>}
      output_html =  %{ <div><span>10غ</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10غ')

      input_html =  %{ <div><span>10gm</span></div>}
      output_html =  %{ <div><span>10جم</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10جم')

      input_html =  %{ <div><span>10grams</span></div>}
      output_html =  %{ <div><span>10جرامات</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('10جرامات')

      input_html =  %{ <div><span>1gram</span></div>}
      output_html =  %{ <div><span>1غرام</span></div>}
      translated_html = Translation.translate_html(input_html, input_language: "ENGLISH", output_language: "ARABIC").to_html
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('1غرام')
    end

    xit "should translate html input" do
      input_html =  %{ <html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">CORN, VEGETABLE OILS, CHEESE POWDER (MILK), SALT,BUTTERMILK POWDER (MILK), WHEAT FLOUR, WHEY PROTEIN, CONCENTRATE (MILK), TOMATO POWDER, FLAVOUR ENHANCERS, (621,631,627),ONION POWDER, WHEY POWDER (MILK), GARLIC POWDER, DEXTROSE, SUGAR, NATURAL FLAVOUR, MINIERAL, SALT (339), FOOD ACIDS (LACTIC ACID, CITRIC ACID), SPICE (WHITEPEPPER), COLOURS (110, 150D).</td></tr></tbody></table></body></html>}
      output_html = %{ <html dir="ltr" lang="en"><head><title data-cke-title="Rich Text Editor, ckeditor">Rich Text Editor, ckeditor</title></head><body contenteditable="true" class="cke_editable cke_editable_themed cke_contents_ltr cke_show_borders" spellcheck="false"><table class=" cke_show_border"><thead><tr><th>INGREDIENTS</th></tr></thead><tbody><tr><td style="text-align:center">blé, Les Huiles végétales, Poudre de fromage (Lait), Sel,BUTTERLait POWDER (Lait), Farine de blé, Protéine de whey, Concentrer (Lait), Poudre de tomate, Exhausteurs de goût, (621,631,627),Poudre d'oignon, La poudre de lactosérum (Lait), Poudre d'ail, Dextrose, Sucre, Saveur naturelle, Minéral, Sel (339), Acides alimentaires (Acide lactique, Acide citrique), Pimenter (Poivre blanc), Couleurs (110, 150D).</td></tr></tbody></table></body></html>}
      translated_html = Translation.translate_html(input_html, output_language: "FRENCH")
      expect(translated_html).not_to be_empty
      expect(translated_html).to include('blé')
      expect(translated_html).to include('Couleurs')
      expect(translated_html).to include('Poudre de fromage')
      expect(translated_html).to include('Lait')
      expect(translated_html).to include('(Poivre blanc)')
    end
  end

end
