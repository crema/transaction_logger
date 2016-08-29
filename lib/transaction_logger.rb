require 'active_record'
require 'active_record/connection_adapters/abstract/transaction'
require 'active_record/connection_adapters/abstract_mysql_adapter'

require 'transaction_logger/version'
require 'transaction_logger/transaction_log'
require 'transaction_logger/transaction'
require 'transaction_logger/real_transaction'
require 'transaction_logger/abstract_mysql_adapter'

module TransactionLogger
  def self.begin
    TransactionLogger.last_transaction = nil
    stack.push(TransactionLog.new)
    current_transaction.begin
  end

  def self.execute(sql, name)
    current_transaction.execute(sql,name) if current_transaction
  end

  def self.commit
    current_transaction.commit
    TransactionLogger.last_transaction = stack.pop
  end

  def self.rollback
    current_transaction.rollback
    TransactionLogger.last_transaction = stack.pop
  end

  def self.add_record(record)
    current_transaction.add_record(record)
  end

  def self.current_transaction
    stack.last
  end

  def self.last_transaction
    @last_transaction
  end

  private

  def self.last_transaction=(transaction)
    @last_transaction = transaction
  end

  def self.stack
    @stack ||= []
  end
end
