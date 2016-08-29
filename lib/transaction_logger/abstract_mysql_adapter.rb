module TransactionLogger
  module AbstractMysqlAdapter
    def execute(sql, name = nil)
      TransactionLogger.execute(sql, name)
      super
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.send(:prepend, TransactionLogger::AbstractMysqlAdapter)