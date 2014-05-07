require 'user-api/version'
require 'user-api/user'
require 'rest-client'
require 'json'

module UserAPI

  def self.set_endpoint(host, username, password)
    @endpoint = RestClient::Resource.new(host, username, password)
  end

  def self.get_users
    @response = @endpoint['users/.json'].get
    user_list = []
    parse_json(@response.to_str).each do |user|
      user_list << User.new(user)
    end
    return user_list
  rescue Exception => e
    raise Exception, e.response
  end

  def self.create_user(user)
    @response = @endpoint['users/.json'].post user.to_json
    User.new(parse_json(@response.to_str))
  rescue => e
    raise Exception, e.response
  end

  def self.activate_user(code)
    @response = @endpoint['users/activate/.json'].put( { :activation_code => code }.to_json)
    User.new(parse_json(@response.to_str))
  rescue Exception => e
    raise Exception, e.response
  end

  def self.login_user(username, password, remember_me = false)
    @response = @endpoint['users/login/.json'].put( { :username => username,
                                                      :password => password,
                                                      :remember_me => remember_me }.to_json)
    User.new(parse_json(@response.to_str))
  rescue Exception => e
    raise Exception, e.response
  end

  def self.logout_user(id)
    @response = @endpoint['users/logout/.json'].put( { :id => id }.to_json)
    true
  rescue Exception => e
    raise Exception, e.response
  end

  def self.delete_user(id)
    @response = @endpoint["users/#{id}.json"].delete
    true
  rescue Exception => e
    raise Exception, e.response
  end

  
  protected

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end

end
