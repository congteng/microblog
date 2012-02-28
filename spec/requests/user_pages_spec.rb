require 'spec_helper'

describe "User Pages" do
  subject{page}

  
  describe "signup page" do
    before{ visit signup_path}
    it {should have_selector "h1", text: "Sign up"}
    it {should have_selector "title", text: full_title("Sign up")}
  end


  describe "profile page" do
    let(:user){FactoryGirl.create(:user)}
  	before{visit user_path(user)}

  	it{should have_selector('h1', text: user.name)}
  	it{should have_selector('title', text: user.name)}
  end

  describe "sign up" do

    before{ visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect{click_button "Sign up"}.not_to change(User, :count)
      end
    end

    describe "with valid information" do

      before do

        fill_in "Name",         with: "Marshall"
        fill_in "Email",        with: "congteng45@gmail.com"
        fill_in "Password",     with: "123123"
        fill_in "Confirmation", with: "123123"

      end

      it "should create a user" do
        expect{click_button "Sign up"}.to change(User, :count).by(1)
      end
    end

  end
end
