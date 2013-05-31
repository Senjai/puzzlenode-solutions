#!/usr/bin/ruby
# encoding: UTF-8
# Never parsed xml before. So this should be interesting.
# I never want to see rexml again after this...
require 'rexml/document'

module Trade
  class Parser
    include REXML

    def self.get_conversions(file)
      file = File.new("../data/sample_rates.xml")
      doc = Document.new file

      froms = XPath.match(doc, "//rate/from").map {|e| e.text}
      twos = XPath.match(doc, "//rate/to").map {|e| e.text}
      conversions = XPath.match(doc, "//rate/conversion").map {|e| e.text}

      arr = []
      (0..froms.size-1).each do |i|
        arr << [froms[i], twos[i], conversions[i]]
      end
      arr
      #I don't know how beter to organize this data..
    end
  end
end