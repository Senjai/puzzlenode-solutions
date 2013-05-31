#!/usr/bin/ruby
# encoding: UTF-8
# I guess I really dont need an initialize method for the class
# Since the only reason you create it is to get the transactions.
# But I'll leave it like this incase I want to add functionality to it.

module Trade
  class TransLog
    @@default_header = "store,sku,amount" 
    def initialize(filename, header=@@default_header)
      @filename = filename
      @header = header
      raise "File passed to Trade::TransReader does not exist" if !File.exist? filename
      _validate_headers
    end

    def self.default_header
      @@default_header
    end

    def self.default_header=(arg)
      @@default_header = arg
    end

    def get_transactions(raw=false)
      begin
        trans_data = []
        File.foreach(@filename) do |line|
          trans_data << line.chomp.split(",")
        end
      rescue Exception => e
        puts "Exception in get_transactions, #{e.message}"
      end
      return trans_data if raw
      result = Hash.new
      trans_data.shift
      trans_data.each do |arr|
        (result[arr[1].intern] ||= []) << [arr[0], *_yank_currency(arr[2])] 
      end
      result
    end

    protected

    def _validate_headers
      first_line = ""
      File.open('../data/sample_trans.csv', 'r') do |file|
        first_line = file.gets.chomp
      end
      unless first_line == @header
        raise "Error in TransReader::_validate_headers, invalid transaction log #{@filename}\n
              Headers should be: #{@header} but was #{first_line}"        
      end
    end

    def _yank_currency(amount)
      amt, currency = amount.split(" ")
      amt = amt.to_f
      currency = currency.intern
      return amt, currency
    end
  end
end

