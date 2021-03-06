require 'spec_helper'

describe "StaticPages" do

	let (:base_title) { "Ruby on Rails Tutorial Sample App" }
	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_selector('title', text: full_title(page_title)) }
	end
	
	describe "Home page" do
		before(:each) { visit root_path }
		let(:heading) { 'Sample App' }
		let(:page_title) { '' }
		
		it_should_behave_like "all static pages"
		it { should_not have_selector 'title', text: '| Home' }	

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
        		sign_in user
        		visit root_path
        	end

			describe "sidebar with no microposts" do
        		it { should have_content(user.microposts.count) }
        		it { should have_content("micropost") }
            end

			describe "sidebar with 1 micropost" do

				let(:user) { FactoryGirl.create(:user) }
				before do 
					FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
					sign_in user
        			visit root_path
    			end

        		it { should have_content(user.microposts.count) }
        		it { should have_content("1 micropost") }
            end

        	describe "with 2 or more microposts" do

        		let(:user) { FactoryGirl.create(:user) }
	        	before do
	        		FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
	        		FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
	        		sign_in user
		        	visit root_path
	        	end

				describe "sidebar should pluralize properly" do
	        		it { should have_content(user.microposts.count) }
	        		it { should have_content("2 microposts") }
	            end

	        	it "should render the user's feed" do
	        		user.feed.each do |item|
	        			page.should have_selector("li##{item.id}", text: item.content)
	        		end
	        	end

	        	describe "follower/following counts" do
	        		let(:other_user) { FactoryGirl.create(:user) }
	        		before do
	        			other_user.follow!(user)
	        			visit root_path
	        		end

	        		it { should have_link("0 following", href: following_user_path(user)) }
	        		it { should have_link("1 followers", href: followers_user_path(user)) }
	        	end
	        end
        end
	end

	describe "Help page" do
		before(:each) {visit help_path}
		let(:heading) { 'Help' }
		let(:page_title) { 'Help' }
		it_should_behave_like "all static pages"
	end
  	
	describe "About Us" do
		before(:each) {visit about_path}
		let(:heading) { 'About Us' }
		let(:page_title) { 'About Us' }
		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before(:each) {visit contact_path}
		let(:heading) { 'Contact' }
		let(:page_title) { 'Contact' }
		it_should_behave_like "all static pages"
	end

    #test links
	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		page.should have_selector 'title', text: full_title('About Us')
		click_link "Help"
		page.should have_selector 'title', text: full_title('Help')
		click_link "Contact"
		page.should have_selector 'title', text: full_title('Contact')
		click_link "Home"
		click_link "Sign up now!"
		page.should have_selector 'title', text: full_title('Sign up')
		click_link "sample app"
		page.should have_selector 'title', text: full_title('')
	end
end
