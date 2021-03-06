require 'spec_helper'

describe "services/edit.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
    @service = assign(:service, stub_model(Service,
      :display_name => "MyString",
      :url => "MyString",
      :creator => @user,
      :project => @user.personal_org.default_project
    ))
  end

  it "renders the edit service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => services_path(@service), :method => "post" do
      assert_select "input#service_display_name", :name => "service[display_name]"
      assert_select "input#service_url", :name => "service[url]"
    end
  end
end
