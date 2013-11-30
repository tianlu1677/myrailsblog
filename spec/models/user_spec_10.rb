require "spec_helper"

describe User do
	before do 
		@user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it {should respond_to(:admin)}
	it { should respond_to(:microposts)}

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

      		its(:feed) { should include(newer_micropost) }
      		its(:feed) { should include(older_micropost) }
      		its(:feed) { should_not include(unfollowed_post) }
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