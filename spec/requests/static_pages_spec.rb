# require 'spec_helper'

# describe "StaticPages" do
#   describe "GET /static_pages" do
#     it "works! (now write some real specs)" do
#       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#       get static_pages_index_path
#       response.status.should be(200)
#     end
#   end
# end


# #new
 require "spec_helper"

 describe "Static pages" do
	
 	describe "Home pages" do

 		it "should have the content 'first app'" do
 			visit '/static_pages/home'
 			expect(page).to  have_content('first app')
 		end

 		it "should have the right title " do
 		visit '/static_pages/home'
 		expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
 		end
 	end	

 	describe "Help pages" do

 		it "should have the content 'help' " do
 			visit '/static_pages/help'
 			expect(page).to  have_content('help')
 		end

 		it "should have the right title " do
 		visit '/static_pages/help'
 		expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
 	end
 	end

 	describe "about pages" do

 		it "should have about " do
 			visit '/static_pages/about'
 			expect(page).to have_content('about')
 		end

 		it "should have the right title " do
 		visit '/static_pages/about'
 		expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
 		end
 	end



end