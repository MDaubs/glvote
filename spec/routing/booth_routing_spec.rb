require 'spec_helper'

describe "booth routing" do
  it "routes GET / to home#index" do
    { get: "/" }.should route_to(
      controller: "home",
      action: "index"
    )
  end

  it "routes GET /booths/:id to booths#show" do
    { get: "/booths/27" }.should route_to(
      controller: "booths",
      action: "show",
      id: "27"
    )
  end

  it "routes PUT /booths/:id to booths#update" do
    { put: "/booths/27" }.should route_to(
      controller: "booths",
      action: "update",
      id: "27"
    )
  end

  it "routes POST /booths/:id/reset to booths#reset" do
    { post: "/booths/27/reset" }.should route_to(
      controller: "booths",
      action: "reset",
      id: "27"
    )
  end
end
