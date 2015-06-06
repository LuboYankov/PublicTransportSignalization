class AlertController < ApplicationController
	def index
		@alert = Alert.new
	end
	
	def create
		@alert = Alert.new(params[:alert])
		@alert.request = request
		if @alert.deliver
		  flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
		else
		  flash.now[:error] = 'Cannot send message.'
		  render :index
		end
  	end
end
