# As a user,
# So that I can start using the bookmark manager,
# I'd like to sign up.

feature 'user sign up' do
  let(:new_password) { 'jo3ble0bl3' }
  let(:new_user) { 'Joe B' }
  let(:new_email) { 'joe.bloggs@gmail.com' }

  before do
    visit '/users/new'
    fill_in 'name', with: new_user
    fill_in 'email', with: new_email
    fill_in 'password', with: new_password
  end
  
  scenario 'user names, emails and passwords are stored on signup' do
    fill_in 'password', with: new_password
    fill_in 'confirmation', with: new_password
    
    expect{click_button 'Sign Up'}.to change(User, :count).by 1
    expect(page).to have_content "Welcome, #{new_user}"
    expect(User.first.email).to eq new_email
  end

  scenario 'use enters different vaues for password and confirmation' do
    fill_in 'confirmation', with: :not_password

    expect{click_button 'Sign Up'}.to_not change(User, :count)
  end
end
