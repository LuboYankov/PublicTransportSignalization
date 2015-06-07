require_relative './buslines/parse_mails.rb'
require_relative './buslines/parse_lines.rb'

class AlertController < ApplicationController
	def index
		@alert = Alert.new
	end
	
	def create
		transport = params[:alert][:transport]
		if transport == "bus"
			line = params[:alert][:bus_line].to_s
			params[:alert][:trolley_line] = nil
			params[:alert][:tram_line] = nil
			params[:alert][:subway_line] = nil
			company = get_bus_company(line)
		elsif transport == "trolley"
			line = params[:alert][:trolley_line].to_s
			company = get_trolley_company(line)
			params[:alert][:bus_line] = nil
			params[:alert][:tram_line] = nil
			params[:alert][:subway_line] = nil
		elsif transport == "tram"
			line = params[:alert][:tram_line].to_s
			company = get_tram_company(line)
			params[:alert][:trolley_line] = nil
			params[:alert][:bus_line] = nil
			params[:alert][:subway_line] = nil
		else transport == "subway"
			line = params[:alert][:subway_line].to_s
			company = get_subway_company(line)
			params[:alert][:trolley_line] = nil
			params[:alert][:tram_line] = nil
			params[:alert][:bus_line] = nil
		end
		params[:alert][:company_mail] = get_mail(company)
		@alert = Alert.new(params[:alert])
		@alert.request = request
		if @alert.deliver
		  name = params[:alert][:first_name].to_s + " " + params[:alert][:last_name].to_s
		  email = params[:alert][:email].to_s
		  time = params[:alert][:time].to_s
		  bus_id = params[:alert][:bus_id].to_s
		  if params[:alert][:image]
		  	image = params[:alert][:image].original_filename
		  	path = File.join("app/assets/images", image)
		  	File.open(path, "wb") { |f| f.write(params[:alert][:image].read) }
		  end
		  comment = params[:alert][:comment].to_s
		  redirect_to :controller => 'posthandler', :name => name, :email => email, :time => time, :line => line, :bus_id => bus_id, :comment => comment, :company_mail => params[:alert][:company_mail], :image => image, :transport => transport
		else
		  flash.now[:error] = 'Cannot send message.'
		  render :index
		end
  	end
end
