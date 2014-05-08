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

  it 'should create a new user and delete it' do
    response = UserAPI.create_user(@user1)
    response.email.should eq(@user1.email)
    delete_resp = UserAPI.delete_user(response.id)
    delete_resp.should eq(true)
  end

  it 'should get a list of users' do
    UserAPI.create_user(@user1)
    UserAPI.create_user(@user2)
    list = UserAPI.get_users
    list[0].email.should eq(@user1.email)
    list[1].email.should eq(@user2.email)
    UserAPI.delete_user(list[0].id)
    UserAPI.delete_user(list[1].id)
  end

  it 'should get a user' do
    created_user = UserAPI.create_user(@user1)
    user = UserAPI.get_user(created_user.id)
    user.email.should eq(created_user.email)
    UserAPI.delete_user(user.id)
  end

  it 'should activate a user' do
    user = UserAPI.create_user(@user1)
    response = UserAPI.activate_user(user.activation_code)
    response.activated_at.nil?.should eq(false)
    UserAPI.delete_user(user.id)
  end

  it 'should update a user' do
    user = UserAPI.create_user(@user1)
    user.email = 'changed@fake.com'
    user.password = 'newPW'
    user.password_confirmation = 'newPW'
    response = UserAPI.update_user(user)
    response.email.should eq('changed@fake.com')
    UserAPI.delete_user(user.id)
  end

  it 'should login a user and logout the user' do
    user = UserAPI.create_user(@user1)
    activated_user = UserAPI.activate_user(user.activation_code)
    response = UserAPI.login_user(@user1.email, @user1.password)
    response.email.should eq(user.email)
    response = UserAPI.logout_user(user.id)
    response.should eq(true)
    UserAPI.delete_user(user.id)
  end

  it 'should verify a user is logged in' do
    user = UserAPI.create_user(@user1)
    UserAPI.activate_user(user.activation_code)
    response = UserAPI.logged_in?(user.id)
    response.should eq(true)
    UserAPI.delete_user(user.id)
  end

  it 'should get the user with the matching remember me token' do
    user = UserAPI.create_user(@user1)
    UserAPI.activate_user(user.activation_code)
    logged_in_user = UserAPI.login_user(@user1.email, @user1.password, true)
    response = UserAPI.remember_me(logged_in_user.remember_me_token)
    response.email.should eq(@user1.email)
    UserAPI.delete_user(user.id)
  end
end