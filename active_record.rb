# Basic ActiveRecord setup
require 'sqlite3'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
		adapter: 'sqlite3',
		database: ':memory:'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
	create_table :memorized_responses, force: true do |t|
		t.string :trigger
		t.string :response
	end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
end

# Define a user-taught response
class MemorizedResponse < ApplicationRecord

	self.table_name = 'memorized_responses'

	validates :trigger, presence: true
	validates :response, presence: true

end