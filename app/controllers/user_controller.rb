class UserController < ApplicationController

  @@user_service = $api.buildUserService
  @@session_service = $api.buildSessionService  	

  def signin
  end

  def create
    begin
    	@@user_service.create_user(params['user_name'], params['password'], params['email'])
    	user = @@user_service.authenticate(params['user_name'], params['password'])  
      if user
        user_session = @@session_service.get_session(user.userName);
        session[:user_id] = user_session.sessionId 
        session[:user_name] = user.userName
      end
      redirect_to home_index_path, notice: 'Thank you!, You are registered successfully.'
    rescue Exception => e
      redirect_to home_index_path, notice: "#{e.message}"
    end  
  end

  def signup
  end

  def authenticate
    begin
      user = @@user_service.authenticate(params['user_name'], params['password'])  
      if user
        user_session = @@session_service.get_session(user.userName);
        session[:user_id] = user_session.sessionId 
        session[:user_name] = user.userName
      end
      redirect_to home_index_path, notice: 'Authentication Successful.'
    rescue Exception => e
      redirect_to home_index_path, notice: "#{e.message}"
    end
  end

  def logout
    response = @@session_service.invalidate(session[:user_id]);
    session[:user_id] = nil
    redirect_to home_index_path, notice: 'You are logout successfully'
  end
end
