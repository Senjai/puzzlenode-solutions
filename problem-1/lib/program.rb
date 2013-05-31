#!/usr/bin/ruby
# encoding: UTF-8

require_relative 'parser.rb'
require_relative 'translog.rb'

module Trade
  class Program
    def initialize(trans, rates)
      @trans = TransLog.new(trans).get_transactions
      @rates = Parser.get_conversions(rates)
    end

    def lookup_sku(sym)
      @trans[sym]
    end

    def get_total_val(sym, curr)
      total = 0.00
      sku = lookup_sku sym
      return nil if sku == nil

      sku.each do |store, price, currency|
        if currency == curr
          total += price
        else
          conversion = 0.0
          @rates.each do |from, to, rate|
            if from == curr and to = currency
              conversion = 1/rate
            elsif from == currency and to == curr
              conversion = rate
            else
              next
            end
          end
          fail "No conversion found" if conversion == 0.0
          total += price * conversion
        end
      end
      total         
    end
  end
end

test = Trade::Program.new('../data/sample_trans.csv', '../data/sample_rates.xml')
p test.get_total_val(:DM1182, :USD)