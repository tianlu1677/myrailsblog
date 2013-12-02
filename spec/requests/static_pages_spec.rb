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

#let (:base_title)  {"<% provide(:title, 'About Us') %>"}

# change " expect(page).to  have_content('first app')" to
# expect(page).to have_title(" #{base_title}| Home")

# #new
#  require "spec_helper"

#  describe "Static pages" do
	
#  	describe "Home pages" do

#  		it "should have the content 'first app'" do
#  			visit '/static_pages/home'
#  			expect(page).to  have_content('first app')
#  		end

#  		it "should have the right title " do
#  		visit '/static_pages/home'
#  		expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
#  		end
#  	end	

#  	describe "Help pages" do

#  		it "should have the content 'help' " do
#  			visit '/static_pages/help'
#  			expect(page).to  have_content('help')
#  		end

#  		it "should have the right title " do
#  		visit '/static_pages/help'
#  		expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
#  	end
#  	end

#  	describe "about pages" do

#  		it "should have about " do
#  			visit '/static_pages/about'
#  			expect(page).to have_content('about')
#  		end

#  		it "should have the right title " do
#  		visit '/static_pages/about'
#  		expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
#  		end
#  	end



# end

require 'spec_helper'

describe "Static pages" do

  #jian hua 
  before { visit root_path }
  

  describe "Home page" do
    subject {page}

    before { visit root_path }
    it { should have_content('Welcome') }
    it { should have_title(full_title(''))}
    it { should_not have_title('| Home')}

    # it "should have the content 'Sample App'" do
    #   # visit root_path
    #   expect(page).to have_content('Welcome')
    # end

    # it "should have the base title" do
    #   # visit root_path
    #   expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    # end

    # it "should not have a custom page title" do
    #   # visit  root_path
    #   expect(page).not_to have_title('| Home')
    # end
  end
  describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      
   describe "Contact page" do

    it "should have the content 'Contact'" do
       visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
       visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end

   	
end