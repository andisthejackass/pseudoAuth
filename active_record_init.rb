dbconfig = YAML::load(File.open('db.yml'))
ActiveRecord::Base.establish_connection(dbconfig)

class User < ActiveRecord::Base
end
