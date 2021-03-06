require 'rails_helper'

RSpec.feature 'authentication_pages_spec' do
  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }
      it { should have_content('Sign in') }
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger') }
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in 'Email',    with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_title(user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'followed sign_out' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end

  describe 'visiting the user index' do # test action show
    before { visit users_path }
    it { should have_title('Sign in') }
  end
end
