require 'spec_helper'

describe Acl do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    @org = Org.create! :display_name => 'VMWare', :creator => @user
    @project = @org.default_project
    @app = App.create! :display_name => 'Optimus', :creator => @user, :project => @project, :url => "optimus.cloudfoundry.com"
    @owned_resource = @app.owned_resources.first

    @org2 = Org.create! :display_name => 'DELL', :creator => @user
    @project2 = @org2.default_project

    @acl = @project.acls.build :owned_resource => @owned_resource, :entity => @user
    @acl.save!
  end

  it "can be instantiated" do
    @acl.should be_an_instance_of(Acl)
  end

  it "gets saved" do
    @acl.reload.id.should_not be_nil
  end

  it "defaults to no permissions" do
    @acl.read?.should be_false
    @acl.update?.should be_false
    @acl.create?.should be_false
    @acl.delete?.should be_false
  end

  it "can toggle permissions" do
    @acl.update!
    @acl.update?.should be_true
    @acl.read! false
    @acl.read?.should be_false
    @acl.update?.should be_true
    @acl.update! false
    @acl.update?.should be_false
  end

   it "can toggle permissions" do
    @acl.update_bit = true
    @acl.update?.should be_true
    @acl.read_bit = false
    @acl.read?.should be_false
    @acl.update?.should be_true
    @acl.update_bit = false
    @acl.update?.should be_false
   end

    context "on save" do

      it "errors on distinct projects" do
        @acl = @project2.acls.build :owned_resource => @owned_resource, :entity => @user
        @acl.valid?.should be_false
      end

      it "no errors on same projects" do
        @acl = @project.acls.build :owned_resource => @owned_resource, :entity => @user
        @acl.valid?.should be_true
      end
    end
end
