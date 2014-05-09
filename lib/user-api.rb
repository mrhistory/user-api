require 'user-api/version'
require 'user-api/user'
require 'rest-client'
require 'json'

module UserAPI

  def self.set_endpoint(host, username, password)
    @endpoint = RestClient::Resource.new(host, username, password)
  end

  def self.get_users
    response = @endpoint['users/.json'].get
    user_list = []
    parse_json(response.to_str).each do |user|
      user_list << User.new(user)
    end
    return user_list
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.create_user(user)
    response = @endpoint['users/.json'].post user.to_json
    User.new(parse_json(response.to_str))
  rescue => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.get_user(id)
    response = @endpoint["users/#{id}.json"].get
    User.new(parse_json(response.to_str))
  rescue => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.activate_user(code)
    response = @endpoint['users/activate/.json'].put( { :activation_code => code }.to_json)
    User.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.login_user(email, password, remember_me = false)
    response = @endpoint['users/login/.json'].put( { :email => email,
                                                      :password => password,
                                                      :remember_me => remember_me }.to_json)
    User.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.logout_user(id)
    response = @endpoint['users/logout/.json'].put( { :id => id }.to_json)
    true
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.update_user(user)
    response = @endpoint["users/#{user.id}.json"].put user.to_json
    User.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.delete_user(id)
    response = @endpoint["users/#{id}.json"].delete
    true
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.logged_in?(id)
    response = @endpoint["users/logged_in/#{id}.json"].get
    parse_json(response.to_str)[:logged_in]
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.remember_me(token)
    response = @endpoint["users/remember_me/#{token}.json"].get
    User.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.get_reset_token(email)
    response = @endpoint['users/reset_password/.json'].post( { :email => email }.to_json)
    parse_json(response.to_str)[:reset_token]
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end

  def self.reset_password(token, password, password_confirmation)
    response = @endpoint['users/reset_password/.json'].put( { :reset_token => token,
                                                              :password => password,
                                                              :password_confirmation => password_confirmation
                                                            }.to_json)
    User.new(parse_json(response.to_str))
  rescue Exception => e
    raise Exception, e.response if e.responds_to? response
    raise Exception, e.message
  end 

  
  protected

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end

end
