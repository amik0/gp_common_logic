require 'active_record'
require 'fileutils'

TEST_DATABASE = File.expand_path("../../tmp/db.sqlite3", __FILE__).freeze

RSpec.configure do |config|
  config.before(:each, ar: true) do
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: TEST_DATABASE)
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migrator.migrate(File.expand_path("../migrations", __FILE__))
  end

  config.after(:each, ar: true) do
    ActiveRecord::Base.remove_connection
    FileUtils.rm_f(TEST_DATABASE)
  end
end
