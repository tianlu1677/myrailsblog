# require 'spec_helper'

# describe "AuthenticationPages" do
#   describe "GET /authentication_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get authentication_pages_index_path
#       response.status.should be(200)
#     end
#   end
# end


require 'spec_helper'

describe "Authentication" do

	subject {page}
	 describe "signin page" do

	 	before { visit signin_path }

	 	
	 
        #登录失败时的测试

        describe "with invalid information" do
            before { click_button "Sign in" }

            it { should have_title('Sign in') }
            it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        end

        #登录失败时的合理测试
        describe "after visiting another page" do
        	before { click_link "Home" }
        	it { should_not have_selector('div.alert.alert-error') }
      	end
	 	
	 	describe "with valid info " do
	 		let (:user)  {FactoryGirl.create(:user) }
			before  do
				fill_in "Email",  with: user.email.upcase
				fill_in "Password", with: user.password
				click_button  "Sign in"
			end 		

			it { should have_title(user.name)}
			it { should have_link('Profile', href: user_path(user))}
			it { should have_link('Sign out', href: signout_path)  }
			it { should_not have_link('Sign in', href: signin_path)}

			describe "followed by signout" do
            before { click_link "Sign out" }
            it { should have_link('Sign in') }
        end

        #添加检测“设置”链接的测试
        describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before { sign_in user }

        it { should have_title(user.name) }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Settings',    href: edit_user_path(user)) }
        it { should have_link('Sign out',    href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }   
        end
	    
    end
	describe "for non-signed-in users" do
		let(:user)  { FactoryGirl.create(:user) }

		describe "in the User controller" do

			describe "visiting the edit page" do
				before { visit edit_user_path(user) }
				it {  should have_title('Sign in')}
				
			end
			describe " Submitting to the update action" do
				before { patch user_path(user) }
				specify {expect(response).to  redirect_to(signin_path) }
				
			end
			
		end
		describe "when attempting to visit a protected page" do
	        before do
	          visit edit_user_path(user)
	          fill_in "Email",    with: user.email
	          fill_in "Password", with: user.password
	          click_button "Sign in"
	        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        
        end
		
	end

	describe "as wrong user" do
		let(:user) { FactoryGirl.create(:user) }
		let(:wrong_user)  {FactoryGirl.create(:user,email: "Wrong@example.com")}
		before{ sign_in user, no_capybara: true }

		describe "submitting a GET request to the Users#edit action" do
			before { get edit_user_path(wrong_user)  }
			specify { expect(response.body).not_to match(full_title('Edit user'))}
			specify  {expect(response).to  redirect_to(root_url) }
			end

			describe "Submitting a Patch request to the Users#update action " do
				before {  patch user_path(wrong_user) }
				specify { expect(response).to  redirect_to(root_url) }
					 	
			end		 
		 end 		
	end

	describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

   end


	
	
end