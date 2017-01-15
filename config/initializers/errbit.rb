Airbrake.configure do |config|
  config.api_key= 'ff20dd158a9d0013df0350beeafc288a'
  config.host ='errbit.software-hut.org.uk'
  config.port = 443
  config.secure =config.port==443
end
