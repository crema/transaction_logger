module TransactionLogger
  class TransactionLog
    def initialize
      @query = ''
      @records = []
    end

    attr_reader :query, :records

    def begin
    end

    def execute(sql, name)
      @query << "#{sql}\n"
    end

    def commit
    end

    def rollback
    end

    def add_record(record)
      @records << record
    end
  end
end