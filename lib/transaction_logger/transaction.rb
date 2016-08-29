module TransactionLogger
  module Transaction
    def add_record(record)
      TransactionLogger.add_record(record)
      super
    end
  end
end

ActiveRecord::ConnectionAdapters::Transaction.send(:prepend, TransactionLogger::Transaction)