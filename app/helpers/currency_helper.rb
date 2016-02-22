require 'nokogiri'
require 'date'


module CurrencyHelper

class ExchangeRate

#initializer to parse source xml file
def initialize(source_file)
    xml_file = File.read(source_file)
    @doc = Nokogiri::XML.parse(xml_file)
end

#get euro reference rate
def getEur(time,currency)
    search='//*[@time="%s"]/*[@currency="%s"]' % [time,currency]
    elems=@doc.xpath(search)
    rate=elems[0]==nil ? 0: elems[0].attr('rate')  
end

#calculate base-counter rate at given date
#If currency not present, returns NaN
def at(date,base,counter)
    time=date.strftime("%Y-%m-%d")
    getBase=base=="EUR" ? 1: getEur(time,base)
    getCounter=counter=="EUR" ? 1: getEur(time,counter)
    result=getBase==0 || getCounter==0 ? Float::NAN : (getCounter.to_f)/(getBase.to_f)
end
 
end   
end
