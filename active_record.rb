# Basic ActiveRecord setup
require 'active_record'

db_config = YAML::load(File.open('db/database.yml'))
ActiveRecord::Base.establish_connection(db_config)

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
end

# Define a user-taught response
# CREATE TABLE memorized_responses(trigger text, response text)
class MemorizedResponse < ApplicationRecord

	validates :trigger, presence: true
	validates :response, presence: true

end