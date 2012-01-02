module ControllerSpecHelpers
  def redirect_to_login
    session[:pre_auth_url].should == request.fullpath
    redirect_to(new_login_url)
  end

  def login_as_election_worker
    session[:role] = 1
  end

  def logout
    session[:role] = nil
  end
end
