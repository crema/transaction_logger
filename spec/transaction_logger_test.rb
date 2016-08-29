require 'minitest/autorun'
require 'transaction_logger'
require_relative 'database/database'

describe TransactionLogger do
  before do
    @database = Database.new('transaction_logger_test')
    @database.create
    @database.connection
  end

  after do
    @database.drop
  end

  it 'should work' do
    ActiveRecord::Base.connection.transaction do
      user = User.new
      user.user_items.build
      user.save

      sql = <<-SQL
        BEGIN
        SHOW FULL FIELDS FROM `users`
        SHOW TABLES
        SHOW CREATE TABLE `users`
        SHOW FULL FIELDS FROM `user_items`
        SHOW CREATE TABLE `user_items`
        INSERT INTO `users` VALUES ()
        INSERT INTO `user_items` (`user_id`) VALUES (1)
      SQL
      TransactionLogger.current_transaction.query.squish.must_equal sql.squish
    end

    ActiveRecord::Base.connection.transaction do
      user = User.first
      user.user_items.build
      user.save

      sql = <<-SQL
        BEGIN
        SELECT  `users`.* FROM `users`  ORDER BY `users`.`id` ASC LIMIT 1
        INSERT INTO `user_items` (`user_id`) VALUES (1)
      SQL

      TransactionLogger.current_transaction.query.squish.must_equal sql.squish
    end
  end
end