require 'spec_helper'

describe UserAPI do
  before(:each) do
    @user = UserAPI::User.new({
    organizations: [1],
    email: 'test@fake.com',
    first_name: 'Test',
    last_name: 'User',
    address1: '123 Main St.',
    city: 'New York',
    state: 'NY',
    zipcode: '10007',
    phone_number: '1234567890'
  })
  end

  it 'should create a new User and delete it' do
    response = UserAPI.create_user(@user)
    response.email.should eq(@user.email)
    delete_resp = UserAPI.delete_user(response.id)
    delete_resp.should eq(true)
  end
end