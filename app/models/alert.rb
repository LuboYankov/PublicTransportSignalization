class Alert < MailForm::Base
  attribute :first_name,      :validate => true
  attribute :last_name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :company_mail, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :time
  attribute :bus_line
  attribute :trolley_line
  attribute :tram_line
  attribute :subway_line
  attribute :bus_id
  attribute :line
  attribute :image
  attribute :comment
  attribute :transport
	
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Complaints",
      :to => %(<#{company_mail}>),
      :from => %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end
