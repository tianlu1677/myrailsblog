# require 'spec_helper'

# describe User do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


# 针对 :name 和 :email 属性的测试

require 'spec_helper'

describe "User"  do

	before do
	 @user = User.new(
	 				  name: "Example name",
	 				  email: "Example@email.com",
	 				  password: "foobar",
	 				  password_confirmation: "foobar"
	 				  )
	end
	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should respond_to(:password_digest) }
	it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "when name is not presence " do 
		before {@user.name = " "}

		it { should_not be_valid}
	end

	describe "when name is to long " do 
		before { @user.name = "a"* 55}
		it { should_not be_valid }
	end

	describe "when email is not presence" do
		before {@user.name = " "}
		it {should_not be_valid }

	end

	describe "when email format is invalid " do
		 it "should be invalid " do 
		 	addresses = %w[user@foo,com user_at_foo.org 
		 		example.user@foo. foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_address|
            	@user.email = invalid_address
            	expect(@user).not_to be_valid
            end

		 end 
	end

	describe "when email format is valid " do 
		it "should be valid " do
			addresses = %w[ user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn ]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end 
	end 

	#---
	describe "when email address is already taken"  do
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
	    end 

		it { should_not be_valid }
	end

    #写一个验证密码存在性的测试
    describe "a when password is not present" do
		before do
			@user = User.new(name: "example name ", email: "XXX@qq.com", 
				            password: " ",password_confirmation: " ")			
		end    	
		it { should_not be_valid}
    end
    #还要确保密码和密码确认的值是相同的
    describe "when password doesn't match confirmation" do
    	before {@user.password_confirmation = "mismatch"}
    	it { should_not be_valid }
    	
    end

    #后测试密码是否正确：
    describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user)  { User.find_by(email: @user.email) }

		describe "with valid password " do

			it { should eq found_user.authenticate(@user.password)}
		    		
		end

		describe "with invalid password" do
			let(:user_for_invalid_password)  { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify {  expect(user_for_invalid_password).to be_false }
		    		
		end    	
    end

    #编写一个密码长度测试，大于 6 个字符才能通过
    describe "with a password that's too short " do
    	before { @user.password = @user.password_confirmation = "a"* 5}
		it { should be_invalid}    	
    end

    #记忆权标的第一个测试
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }

    #测试合法的（非空）记忆权标值
    describe "remember token " do
    	before { @user.save}
    	its (:remember_token ) {should_not be_blank}
    	
    end


end