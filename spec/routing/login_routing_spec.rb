require 'spec_helper'

describe "login routing" do
  it "routes GET /login/new to login#new" do
    { get: "/login/new" }.should route_to(
      controller: "login",
      action: "new"
    )
  end
end
