require 'spec_helper'

describe ApplicationController do
  describe "#logged_in?" do
    it "should return true if logged in" do
      login_as_election_worker
      subject.logged_in?.should be_true
    end

    it "should return false if not logged in" do
      logout
      subject.logged_in?.should be_false
    end
  end

  describe "#redirect_to_login" do
    it "should redirect_to login_url" do
      subject.should_receive(:redirect_to).with(new_login_url)
      subject.redirect_to_login
    end

    it "should set session[:pre_auth_url]" do
      subject.stub(:redirect_to)
      subject.redirect_to_login
      session[:pre_auth_url].should == request.fullpath
    end
  end
end
