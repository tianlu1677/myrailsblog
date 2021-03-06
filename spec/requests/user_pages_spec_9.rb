require 'spec_helper'

describe "User pages" do
  subject{ page }
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
  
    before do
      let(:user) {FactoryGirl.create(:user)}
      before do
        sign_in path
        visit edit_user_path(user)
      end

      describe "with valid info" do
        let(:new_name)  { "New Name" }
        let(:new_email)  { "nex@example.com"}
        before do
          fill_in "Name",   with: new_name
          fill_in "Email",  with: new_email
          fill_in "Password", with: user.password
          fill_in "Confirm Password", with:user.password
          fill_in "Save changes",    with:  user.password
          click_button  "Save changes"

        end

        it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success')}
        it { should have_link('Sign out', href: signout_path) }
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
        
      end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

  end


 describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end


  describe "delete links" do

    it { should_not have_link('delete')}

    describe "as a admim user" do
      let(:admin)  {  FactoryGirl.create(:admin)}
      before do
          sigin_in admin    
          visit users_path    
      end
      
        it { should have_link('delete', href:user_path(User.first) }
        it "should be able to delete another user" do
          expect do 
            click_link('delete', match: :first) 
            end.to change(User, :count).by(-1)           
          end
          it { should_not have_link('delete', href: user_path(admin))}
        end

    end
    
  end


end