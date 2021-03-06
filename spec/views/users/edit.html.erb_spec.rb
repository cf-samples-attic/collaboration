require 'spec_helper'

describe "users/edit.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "Monica",
      :last_name => "Wilkinson",
      :username => "ciberch",
      :password => 'sasasasa',
      :confirm_password => 'sasasasa',
      :email => 'monica@vmware.com'
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_username", :name => "user[username]"
    end
  end
end
