class Helpers
  
  def self.is_logged_in?(a_session)
    !!a_session[:user_id]
  end

  def self.current_user(a_session)
    User.find(a_session[:user_id])
  end

end