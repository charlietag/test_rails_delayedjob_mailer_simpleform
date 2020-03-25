namespace :show_my_name do
  desc "Display hostname"
  task display: :environment do
    puts "URL for action mailer: " + Rails.application.config.action_mailer.default_url_options[:host]
    puts "HOSTNAME: "+ %x{hostname}
  end

end
