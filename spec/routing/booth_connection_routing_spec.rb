require 'spec_helper'

describe "booth connection routing" do
  it "routes POST /booths/:booth_id/connection to booth_connections#create" do
    { post: "/booths/12/connection" }.should route_to(
      controller: "booth_connections",
      action: "create",
      booth_id: "12"
    )
  end
end
