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
    parse_json(response.to_str) unless response.code == 200
    
    user_list = []
    parse_json(response.to_str).each do |user|
      user_list << User.new(user)
    end
    return user_list
  end

  def self.create_user(user)
    response = @endpoint['users/.json'].post user.to_json
    parse_json(response.to_str) unless response.code == 200
    User.new(JSON.parse(response.to_str, symbolize_names: true))
  end

  def self.activate_user(code)
    response = @endpoint['users/activate/.json'].put({ :activation_code => code }.to_json)
    parse_json(response.to_str) unless response.code == 200
    User.new(JSON.parse(response.to_str, symbolize_names: true))
  end

  def self.delete_user(id)
    response = @endpoint["users/#{id}.json"].delete
    parse_json(response.to_str) unless response.code == 200
    return true
  end

  
  protected

  def self.parse_json(json)
    JSON.parse(json, symbolize_names: true)
  end

end
