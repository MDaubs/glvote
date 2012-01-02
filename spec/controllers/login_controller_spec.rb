require 'spec_helper'

describe LoginController do
  describe "GET new" do
    before do
      get :new
    end

    it { should render_template 'new' }
  end

  describe "POST create", "with valid credentials" do
    before do
      session[:pre_auth_url] = 'http://return.url'
      Rails.configuration.election_worker_password = '1234'
      post :create, login: { password: '1234' }
    end

    it { should redirect_to 'http://return.url' }
    it { should set_session(:role).to(1) }
  end

  describe "POST create", "with invalid credentials" do
    before do
      Rails.configuration.election_worker_password = '1234'
      post :create, login: { password: 'abcd' }
    end

    it { should render_template 'new' }
    it { should set_the_flash.now }
  end
end
