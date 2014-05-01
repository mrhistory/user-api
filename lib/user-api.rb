require 'user-api/version'
require 'user-api/user'
require 'rest-client'
require 'json'

module UserAPI
  def create_user(user)
    private_resource = RestClient::Resource.new('https://user_service_dev.herokuapp.com/users/.json',
                                                'web_service_user',
                                                'catbrowncowjumps')
    response = private_resource.post user.to_json
    if response.code == 200
      User.new(JSON.parse(response.to_str))
    else
      JSON.parse(response.to_str)
    end
  end

  def delete_user(id)
    private_resource = RestClient::Resource.new("https://user_service_dev.herokuapp.com/users/#{id}.json",
                                                'web_service_user',
                                                'catbrowncowjumps')
    response = private_resource.delete
    if response.code == 200
      true
    else
      JSON.parse(response.to_str)
    end
  end
end
