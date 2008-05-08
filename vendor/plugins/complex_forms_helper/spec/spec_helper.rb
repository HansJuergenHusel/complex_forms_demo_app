begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))
ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(plugin_spec_dir, "db", "schema.rb"))

class Winken < ActiveRecord::Base
  has_many :blinkens, :enable_creation_from_params => true
  has_many :nods, :through => :blinkens, :enable_creation_from_params => true
  has_many :taggings
  has_many :tags, :through => :taggings, :enable_creation_from_params => true
  has_and_belongs_to_many :bars
  has_one :foo
end

class Blinken < ActiveRecord::Base
  belongs_to :blinken
  belongs_to :nod
end

class Nod < ActiveRecord::Base
  has_many :blinkens
  has_many :winkens, :through => :blinkens
end

class Bar < ActiveRecord::Base
  has_and_belongs_to_many :winkens
end

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :winkens, :through => :taggings
end

class Tagging < ActiveRecord::Base
  belongs_to :winken
  belongs_to :tag
end

class Foo < ActiveRecord::Base
  belongs_to :winken
end