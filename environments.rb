configure :development do
  set :database, 'sqlite3:dev.db'
  set :show_exceptions, true
end

configure :production do
  ActiveRecord::Base.establish_connection(
    :adapter  => 'postgresql',
    :host     => ENV['RDS_HOSTNAME'],
    :username => ENV['RDS_USERNAME'],
    :password => ENV['RDS_PASSWORD'],
    :database => ENV['RDS_DB_NAME'],
    :encoding => 'utf8'
  )
end
