require 'spec_helper'

describe UserAPI do
  before(:all) do
    UserAPI.set_endpoint('https://user-service-dev.herokuapp.com', 'web_service_user', 'catbrowncowjumps')
  end

  before(:each) do
    @user1 = UserAPI::User.new({
    organizations: [1],
    email: 'test1@fake.com',
    password: 'fakePW',
    password_confirmation: 'fakePW',
    first_name: 'Test',
    last_name: 'User1',
    address1: '123 Main St.',
    city: 'New York',
    state: 'NY',
    zipcode: '10007',
    phone_number: '1234567890'
  })

  @user2 = UserAPI::User.new({
    organizations: [1],
    email: 'test2@fake.com',
    password: 'fakePW',
    password_confirmation: 'fakePW',
    first_name: 'Test',
    last_name: 'User2',
    address1: '123 Main St.',
    city: 'New York',
    state: 'NY',
    zipcode: '10007',
    phone_number: '1234567890'
  })
  end

  it 'should create a new User and delete it' do
    response = UserAPI.create_user(@user1)
    response.email.should eq(@user1.email)
    delete_resp = UserAPI.delete_user(response.id)
    delete_resp.should eq(true)
  end

  it 'should create 2 users, get the list of users, and delete the users' do
    UserAPI.create_user(@user1)
    UserAPI.create_user(@user2)
    list = UserAPI.get_users
    list[0].email.should eq(@user1.email)
    list[1].email.should eq(@user2.email)
    UserAPI.delete_user(list[0].id)
    UserAPI.delete_user(list[1].id)
  end

  it 'should create a user, activate the user, and delete the user' do
    user = UserAPI.create_user(@user1)
    response = UserAPI.activate_user(user.activation_code)
    response.activated_at.nil?.should eq(false)
    UserAPI.delete_user(user.id)
  end

  # it 'should create a user, activate the user, login the user, logout the user, and delete the user' do
  #   user = UserAPI.create_user(@user1)
  #   activated_user = UserAPI.activate_user(user.activation_code)
  #   response = UserAPI.login_user(@user1.email, @user1.password)
  #   response.email.should eq(user.email)
  #   response = UserAPI.logout_user()
  #   UserAPI.delete_user(user.id)
  # end
end