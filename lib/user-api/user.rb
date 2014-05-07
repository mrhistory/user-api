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
                  :phone_number,
                  :password,
                  :password_confirmation

    attr_reader :remember_me_token,
                :logged_in,
                :active,
                :activation_code,
                :activated_at,
                :reset_token,
                :id

    def initialize(params)
      @organizations = params[:organizations] ||= nil
      @email = params[:email] ||= nil
      @members = params[:members] ||= nil
      @permissions = params[:permissions] ||= nil
      @first_name = params[:first_name] ||= nil
      @last_name = params[:last_name] ||= nil
      @address1 = params[:address1] ||= nil
      @address2 = params[:address2] ||= nil
      @city = params[:city] ||= nil
      @state = params[:state] ||= nil
      @zipcode = params[:zipcode] ||= nil
      @phone_number = params[:phone_number] ||= nil
      @remember_me_token = params[:remember_me_token] ||= nil
      @logged_in = params[:logged_in] ||= nil
      @active = params[:active] ||= nil
      @activation_code = params[:activation_code] ||= nil
      @activated_at = params[:activated_at] ||= nil
      @reset_token = params[:reset_token] ||= nil
      @id = params[:_id] ||= nil
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