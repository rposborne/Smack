require 'sinatra'
require 'etc'  
  get '/' do
    path =  Etc.getpwuid.dir 
    pow_path = File.join(path,'.pow')
    @apps = []
    @apps =  Dir.entries(pow_path).select {|entry| File.directory? File.join(pow_path,entry) and !(entry =='.' || entry == '..'|| entry == 'smack') }
    @apps.collect! { |app| app = {:name => app, :title => app.capitalize }}
    erb :index
  end