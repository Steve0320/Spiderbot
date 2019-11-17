require "active_record"
require 'yaml'

namespace :db do

	db_config = YAML::load(File.open('db/database.yml'))
	db_config_admin = db_config.merge({ 'database' => 'postgres', 'schema_search_path' => 'public'})

	desc "Create the database"
	task :create do
		ActiveRecord::Base.establish_connection(db_config_admin)
		ActiveRecord::Base.connection.create_database(db_config["database"])
		puts "Database created."
	end

end