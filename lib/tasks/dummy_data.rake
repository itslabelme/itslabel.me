require 'csv'
require 'open-uri'
require 'time'

namespace 'itslabel' do
	namespace 'import' do
		namespace 'dummy_data' do
			desc "Import all data in sequence"
		  task 'all' => :environment do
		    begin
		        
          puts "\n\nImporting Dummy Data \t".white
          puts "----------------------------- \t\n\n".white

          puts "\nImporting Translations \t".light_blue
          Rake::Task["itslabel:import:dummy_data:translations"].invoke          
          

		    rescue ArgumentError => e
		        puts "Loading data - failed - #{e.message}".red
		    rescue StandardError => e
		      puts "Importing data - failed - #{e.message}".red
		      puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
		    end
		    puts " "
		  end

	    {
        translations: {
          class_name: "Translation",
          folder_name: "stranslation"
        }        
		  }.each do |key, values|
		  	cls_name = values[:class_name]
		  	folder_name = values[:folder_name]
	      
	      desc "Import #{cls_name.pluralize}"
	      task key => :environment do
	        verbose = true
          verbose = false if ["false", "f","0","no","n"].include?(ENV["verbose"].to_s.downcase.strip)

	        destroy_all = false
	        destroy_all = true if ["true", "t","1","yes","y"].include?(ENV["destroy_all"].to_s.downcase.strip)

	        path = Rails.root.join('db', 'dummy_data', 'itslabel', folder_name)
	        path = Manava::Engine.root.join('db', 'dummy_data', 'itslabel', folder_name) unless File.exists?(path)

          cls_name.constantize.destroy_all if destroy_all
	        cls_name.constantize.import_data_recursively(path, true, verbose)
	        
	        # puts "Importing Completed \n\n".green if verbose
	      end
	    end
	    
		end
	end
end
