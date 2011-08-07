require "spec_helper"

describe GroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs/10/groups").should route_to("groups#index", :id => "10")
    end

    it "routes to #new" do
      get("/orgs/10/groups/new").should route_to("groups#new", :id => "10")
    end

    it "routes to #show" do
      get("/orgs/10/groups/1").should route_to("groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/10/groups/1/edit").should route_to("groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/orgs/10/groups").should route_to("groups#create", :id => "10")
    end

    it "routes to #update" do
      put("/orgs/10/groups/1").should route_to("groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/10/groups/1").should route_to("groups#destroy", :id => "1")
    end

  end
end
