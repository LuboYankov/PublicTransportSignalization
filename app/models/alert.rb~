class Alert < MailForm::Base
  attribute :first_name,      :validate => true
  attribute :last_name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :time
  attribute :bus_line
  attribute :comment
	
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Complaints",
      :to => "publictransportcomplain@gmail.com",
      :from => %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end
