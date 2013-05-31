require 'csv'

module Trade
  class TransReader
    def initialize(filename)
      @filename = filename
      raise "File passed to Trade::TransReader does not exist" if !File.exist? filename
      #_validate_trans_log
    end

    def get_transactions
      begin
        trans_data = CSV.read(@filename)
      rescue Exception => e
        puts "Exception in get_transactions, #{e.message}"
      end
      result = Hash.new
      puts headers = trans_data.shift #so we can use this to store the headers manually because its the first line, the rest will be the actual data
      p trans_data #so its an array of arrays, each index is a row. We can store this in the hash. Not sure what to use as the key. Or.. hmm.
    end
  end
end

reader = Trade::TransReader.new('../data/sample_trans.csv')
reader.get_transactions

