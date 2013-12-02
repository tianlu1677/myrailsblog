require "spec_helper"

describe User do
	before do 
		@user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it {should respond_to(:admin)}
	it { should respond_to(:microposts)}

	#11 zhang jie

	it {should respond_to(:relationships) }
	it { should respond_to(:followed_users) }
	it { should respond_to(:following?)}
	it { should respond_to(:follow!)}

	describe "following" do
		let(:other_user) { FactoryGirl.create(:user)}
		before do 
			@user.save
			@user.follow!(other_user)			
		end

		it { should be_following(other_user)}
		its(:followed_users) { should include(other_user) }

		describe "unfollowed" do
		before { @user.unfollow!(other_user)}

		it{ should_not be_following(other_user)}
		its(:followed_users) { should_not include(other_user)}
		end

		describe "followed user" do
			subject { other_user}
			its(:followers) { should include(@user)}			
		end
		
	end


	it { should respond_to(:relationships)}
	it { should respond_to(:followed_users)}
	it { should respond_to(:reverse_relationships)}
	it { should respond_to(:followers)}




	#-----------------------------------------------------------------



	describe "microposts associations" do

		before {@user.save}
		let!(:older_microposts) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)			
		end
		
		let!(:newer_micropost) do
			FactoryGirl.create(:micropost,user: @user, created_at: 1.hour.ago)
		end

		it "should have the right microposts in the right order" do
			expect(@user.microposts.to_a).to eq [newer_micropost,older_micropost]
			
		end


	    it "should destroy associated microposts" do
			microposts = @user.microposts.to_a
			@user.destroy

			expect(microposts).not_to be_empty
			microposts.each do |micropost|
			expect(Microposts.where(id: micropost.id)).to be_empty
			end
		end

		describe "status" do
      		let(:unfollowed_post) do
      			FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      		end
      		let(:followed_user) { FactoryGirl.create(:user) }

      		before do
        		@user.follow!(followed_user)
        		3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
      		end

      		its(:feed) { should include(newer_micropost) }
      		its(:feed) { should include(older_micropost) }
      		its(:feed) { should_not include(unfollowed_post) }
      		its(:feed) do
        		followed_user.microposts.each do |micropost|
          			should include(micropost)
        		end
      		end
    	end
		
	end

	describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end
	
end