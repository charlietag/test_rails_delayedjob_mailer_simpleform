class BookMailer < ApplicationMailer
  default from: "#{Rails.application.credentials[Rails.env.to_sym][:email][:from]}",
          to: "#{Rails.application.credentials[Rails.env.to_sym][:email][:to]}"
  
  def book_email
    @book = params[:book]
    mail(subject: "New book added: #{@book.name}")
  end

end
