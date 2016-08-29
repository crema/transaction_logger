require_relative 'user'
require_relative 'user_item'

class Database
  def initialize(database_name)
    @database_name = database_name
  end

  def connection
    @connection ||= ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     'localhost',
      username: 'root',
      database: 'transaction_logger_test'
    )
  end

  def drop
    execute <<-SQL
      DROP DATABASE IF EXISTS `#{database_name}`;
    SQL
  end

  def create
    execute <<-SQL
      DROP DATABASE IF EXISTS `#{database_name}`;
      CREATE DATABASE `#{database_name}`;
      use `#{database_name}`;
      CREATE TABLE `users` (
        `id` int NOT NULL AUTO_INCREMENT,
        PRIMARY KEY (`id`)
      );
      CREATE TABLE `user_items` (
        `id` int NOT NULL AUTO_INCREMENT,
        `user_id` int NOT NULL,
        PRIMARY KEY (`id`),
        KEY `index_user_items_on_user_id` (`user_id`),
        CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
      );
    SQL
  end

  private

  attr_reader :database_name

  def execute(sql)
    tempfile = Tempfile.new
    tempfile.puts(sql)
    tempfile.close
    `mysql -u root < #{tempfile.path}`
    tempfile.unlink
  end
end