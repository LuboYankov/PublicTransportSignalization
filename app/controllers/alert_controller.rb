class AlertController < ApplicationController
	def index
		@alert = Alert.new
	end
	
	def create
		@alert = Alert.new(params[:alert])
		@alert.request = request
		if @alert.deliver
		  name = params[:alert][:first_name].to_s + " " + params[:alert][:last_name].to_s
		  email = params[:alert][:email].to_s
		  time = params[:alert][:time].to_s
		  bus_line = params[:alert][:bus_line].to_s
		  comment = params[:alert][:comment].to_s
		  redirect_to :controller => 'posthandler', :name => name, :email => email, :time => time, :bus_line => bus_line, :comment => comment 
		else
		  flash.now[:error] = 'Cannot send message.'
		  render :index
		end
  	end
end
