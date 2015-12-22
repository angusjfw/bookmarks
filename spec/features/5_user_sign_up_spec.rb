# As a user,
# So that I can start using the bookmark manager,
# I'd like to sign up.

feature 'user sign up' do
  scenario 'user names, emails and passwords are stored on signup' do
    new_user = 'Joe B'
    new_email = 'joe.bloggs@gmail.com'
    new_password = 'jo3ble0bl3'
    visit '/users/new'
    fill_in 'name', with: new_user
    fill_in 'email', with: new_email
    fill_in 'password', with: new_password
    
    expect{click_button'Sign Up'}.to change(User, :count).by 1
    expect(page).to have_content"Welcome, #{new_user}"
    expect(User.first.email).to eq new_email
  end
end
