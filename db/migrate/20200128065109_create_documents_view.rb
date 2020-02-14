# This migration comes from sthapana (originally 20180902040053)
class CreateDocumentsView < ActiveRecord::Migration[5.2]
  def up
    self.connection.execute %Q( 

      CREATE OR REPLACE VIEW documents_view AS
        SELECT DISTINCT 
          tabl.id as id,
          'table_document' as doc_type,
          tabl.title as title,
      
          tabl.input_language as input_language,
          tabl.output_1_language as output_1_language,
          tabl.output_2_language as output_2_language,
          tabl.output_3_language as output_3_language,
          tabl.output_4_language as output_4_language,
          tabl.output_5_language as output_5_language,

          tabl.status as status,
          tabl.favorite as favorite,

          tabl.user_id as user_id,
          tabl.created_at as created_at,
          tabl.updated_at as updated_at,

          null as template_id,
          "" as input_html_source,
          "" as output_html_source

        FROM table_documents tabl

      UNION

        SELECT DISTINCT 
          templ.id as id,
          'template_document' as doc_type,
          templ.title as title,
      
          templ.input_language as input_language,
          templ.output_language as output_1_language,
          "" as output_2_language,
          "" as output_3_language,
          "" as output_4_language,
          "" as output_5_language,

          templ.status as status,
          templ.favorite as favorite,

          templ.user_id as user_id,
          templ.created_at as created_at,
          templ.updated_at as updated_at,

          templ.template_id as template_id,
          templ.input_html_source as input_html_source,
          templ.output_html_source as output_html_source

        FROM template_documents templ
    )
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS documents_view;"
  end
end