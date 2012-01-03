require 'spec_helper'

describe "voter registration routing" do
  it "routes POST /voter_registrations to voter_registrations#create" do
    { post: "/voter_registrations" }.should route_to(
      controller: "voter_registrations",
      action: "create"
    )
  end
end
