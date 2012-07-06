require 'spec_helper'

describe "StaticPages" do

	let (:base_title) { "Ruby on Rails Tutorial Sample App" }
	
	describe "Home page" do

		it "should have the content 'Sample App'" do
			visit root_path
			page.should have_selector('h1', :text => 'Sample App')
		end

		it "should have the base title" do
			visit root_path
			page.should have_selector('title',:text => "#{base_title}")
		end		

		it "should not have a custom page title" do
			visit root_path
			page.should_not have_selector('title',:text => "| Home")
		end		
	end

	describe "Help page" do

		it "should have the content 'Help'" do
			#visit '/static_pages/help'
			visit help_path
			page.should have_selector('h1', :text => 'Help')
		end

		it "should have the right title" do
			#visit '/static_pages/help'
			visit help_path
			page.should have_selector('title',:text => "#{base_title} | Help")
		end		

	end
  	
	describe "About Us" do

		it "should have the content 'About Us'" do
			#visit '/static_pages/about'
			visit about_path
			page.should have_selector('h1', :text => 'About Us')
		end

		it "should have the right title" do
			#visit '/static_pages/about'
			visit about_path
			page.should have_selector('title',:text => "#{base_title} | About Us")
		end		

	end

	describe "Contact page" do

		it "should have the content 'Contact'" do
			visit contact_path
			page.should have_selector('h1', :text => 'Contact')
		end

		it "should have the right title" do
			visit contact_path
			page.should have_selector('title',:text => "#{base_title} | Contact")
		end		

	end

end
