require_relative './buslines/parse_mails.rb'
require_relative './buslines/parse_lines.rb'

class AlertController < ApplicationController
	def index
		@alert = Alert.new
	end
	
	def create
		bus_line = params[:alert][:bus_line].to_s
		company = get_bus_company(bus_line)
		params[:alert][:company_mail] = get_mail(company)
		@alert = Alert.new(params[:alert])
		@alert.request = request
		if @alert.deliver
		  name = params[:alert][:first_name].to_s + " " + params[:alert][:last_name].to_s
		  email = params[:alert][:email].to_s
		  time = params[:alert][:time].to_s
		  comment = params[:alert][:comment].to_s
		  if params[:alert][:image] != nil
			  image = params[:alert][:image].original_filename
			  path = File.join("app/assets/images", image)
			  File.open(path, "wb") { |f| f.write(params[:alert][:image].read) }
		  end
		  redirect_to :controller => 'posthandler', :name => name, :email => email, :time => time, :bus_line => bus_line, :comment => comment, :company_mail => params[:alert][:company_mail], :image => image
		else
		  flash.now[:error] = 'Cannot send message.'
		  render :index
		end
  	end
end
