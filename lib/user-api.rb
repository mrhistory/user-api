require 'user-api/version'
require 'user-api/user'
require 'rest-client'
require 'json'

module UserAPI

  @endpoint = RestClient::Resource.new('https://user-service-dev.herokuapp.com', 'web_service_user', 'catbrowncowjumps')

  def self.create_user(user)
    response = @endpoint['users/.json'].post user.to_json
    if response.code == 200
      User.new(JSON.parse(response.to_str, symbolize_names: true))
    else
      JSON.parse(response.to_str, symbolize_names: true)
    end
  end

  def self.delete_user(id)
    response = @endpoint["users/#{id}.json"].delete
    if response.code == 200
      true
    else
      JSON.parse(response.to_str, symbolize_names: true)
    end
  end
end
