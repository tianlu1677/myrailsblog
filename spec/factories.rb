  FactoryGirl.define do
     factory :user do
		sequence(:name) {|n|  "Person #{n}"}
		sequence(:email) {|n| "person#{n}@qq.com" }
		password "foobar"
		password_confirmation "foobar"
     end
      
      factory :admin do
 	        admin true
      end

      factory :micropost do 
        content "Lorem ipsum"
        user        
      end
  end
