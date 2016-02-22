class CurrencyController < ApplicationController
	include CurrencyHelper
	def hello
	end
	def show
		d=params[:x]
		date=Date.new(d['date(1i)'].to_i,d['date(2i)'].to_i,d['date(3i)'].to_i)
		base=params[:base]
		counter=params[:counter]
		amount=params[:amount].to_f
		file = Rails.root.join('app', 'assets', 'data.xml').to_s
		exr=ExchangeRate.new(file)
		answer=exr.at(date,base,counter)
		if answer.nan?
            render "show", :locals => {:answer=> 'Please pick a valid currency and a date in the last 90 days.' }
        else
		    render "show", :locals => {:answer=> answer*amount}
	    end
	end
end
