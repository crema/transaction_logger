module TransactionLogger
  module RealTransaction
    def initialize(connection, options)
      TransactionLogger.begin
      super
    end

    def rollback
      TransactionLogger.rollback
      super
    end

    def commit
      TransactionLogger.commit
      super
    end
  end
end

ActiveRecord::ConnectionAdapters::RealTransaction.send(:prepend, TransactionLogger::RealTransaction)