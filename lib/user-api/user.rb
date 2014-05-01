module UserAPI

  class User
    attr_accessor :organizations,
                  :email,
                  :members,
                  :permissions,
                  :first_name,
                  :last_name,
                  :address1,
                  :address2,
                  :city,
                  :state,
                  :zipcode,
                  :phone_number

    attr_reader :remember_me_token,
                :logged_in,
                :active,
                :activation_code,
                :activated_at,
                :reset_token,
                :id

    def initialize(params)
      @organizations = params['organizations']
      @email = params['email']
      @members = params['members']
      @permissions = params['permissions']
      @first_name = params['first_name']
      @last_name = params['last_name']
      @address1 = params['address1']
      @address2 = params['address2']
      @city = params['city']
      @state = params['state']
      @zipcode = params['zipcode']
      @phone_number = params['phone_number']
      @remember_me_token = params['remember_me_token']
      @logged_in = params['logged_in']
      @active = params['active']
      @activation_code = params['activation_code']
      @activated_at = params['activated_at']
      @reset_token = params['reset_token']
      @id = params['id']
    end

    def to_json
      {
        :organizations => @organizations,
        :email => @email,
        :members => @members,
        :permissions => @permissions,
        :first_name => @first_name,
        :last_name => @last_name,
        :address1 => @address1,
        :address2 => @address2,
        :city => @city,
        :state => @state,
        :zipcode => @zipcode,
        :phone_number => @phone_number
      }.to_json
    end
  end

end