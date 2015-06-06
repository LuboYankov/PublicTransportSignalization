require 'json'

def read_mail_data 
	data = File.read(Rails.root.to_s + "/app/controllers/buslines/mails.json")
end

def get_mail(company)
	data = JSON.parse(read_mail_data)
	company_data = data["mails"]["Companies"]["#{company}"]["contact"]["mail"]
end