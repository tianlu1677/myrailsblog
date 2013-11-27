require 'spec_helper'

describe "User" do

	before do
	 @user = User.new(
	 				  name: "Example name",
	 				  email: "Example@email.com",
	 				  password: "foobar",
	 				  password_confirmation: "foobar"
	 				  )
	end
	subject { @user }

	it { should respond_to(:authenticate)  }
	it { should respond_to (:admin)  }

	it {  should be_valid  }
	it {  should_not be_admin }

	describe "with admin attribute set to 'true'" do

		before do
			@user.save!
			@user.toggle!(:admin)
		end 
	 	
	 end 
	
end