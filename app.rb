require 'sinatra'
require 'etc'  
path =  Etc.getpwuid.dir 
pow_path = File.join(path,'.pow')

get '/' do
  @apps = []
  @apps =  Dir.entries(pow_path).select {|entry| File.directory? File.join(pow_path,entry) and !(entry =='.' || entry == '..'|| entry == 'smack') }
  @apps.collect! { |app| app = {:name => app, :title => app.capitalize }}
  erb :index
end

get '/restart/:app' do |app|
  app_path = File.join(pow_path,app,'tmp')
  FileUtils.mkdir_p(File.join(pow_path,app,'tmp'))
  %x{touch #{app_path}} 
  redirect '/'
end