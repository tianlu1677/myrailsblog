
require 'spec_helper'

describe "Micropost page" do

	subject { page }

	let(:user) {FactoryGirl.create(:user) }
	before { sign_in user }

	describe "micropost creation " do

		before { visit root_path }

		describe "with invalid info" do
			it "should not create a micropost " do
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end		

			describe "error messags" do
				before {click_button "Post"}
				it { should have_content( 'error')}
		
			end	
		end
		describe "with valid info" do
			before { fill_in 'micropost_content', with: "LOrem ipsum"}
			it "should create a micropost" do
				expect { click_button "Post" }.to change(Micropost, :count).by(1)
			end
		end		
	end
	
end