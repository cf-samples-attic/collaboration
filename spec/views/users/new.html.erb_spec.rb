require 'spec_helper'

describe "users/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User,
      :first_name => "Monica",
      :last_name => "Wilkinson",
      :username => "ciberch",
      :password => 'sasasasa',
      :confirm_password => 'sasasasa',
      :email => 'monica@vmware.com'
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_username", :name => "user[username]"
    end
  end
end
