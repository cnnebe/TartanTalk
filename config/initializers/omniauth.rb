OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1064681876810-105go7ljj42ap4igv30oai2bs5iahcha.apps.googleusercontent.com', 'JR69bdN77z7cImJSPK4SpVip', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end