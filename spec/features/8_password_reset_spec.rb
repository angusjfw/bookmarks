# As a user,
# So that I can still access my bookmarks if I forget my password,
# I'd like to be able to reset it securely.

feature 'password reset' do
  before do
    sign_up
    sign_out
    visit '/users/recover'
    fill_in 'email', with: User.first.email
  end

  scenario 'user told to check inbox regardless of email validity' do
    fill_in 'email', with: 'not_a_user@email'
    click_button 'Request token' 
    expect(page).to have_content "Thanks, Please check your inbox for the link."
  end

  scenario 'a reset token is generated on receipt of a valid recovery form' do
    expect{click_button 'Request token'}.to change{User.first.password_token}
  end

  scenario 'password reset token is invalid after one hour' do
    click_button 'Request token'
    Timecop.travel(60 * 60 * 60) do
      visit "/users/reset_password?token=#{User.first.password_token}"
      expect(page).to have_content "Your token is invalid"
    end 
  end
  
  scenario 'user with valid token is prompted to enter a new password' do
    click_button 'Request token'
    visit "/users/reset_password?token=#{User.first.password_token}"
    expect(page).to have_content "Please enter your new password"
  end

  scenario 'user with valid token can enter a new password' do
    click_button 'Request token'
    visit "/users/reset_password?token=#{User.first.password_token}"
    fill_in :password, with: "newpassword"
    fill_in :password_confirmation, with: "newpassword"
    click_button "Reset password"
    expect(page).to have_content("Sign In to Bookmark Manager")
  end

  scenario 'after resetting password, user can sign in with new password' do
    click_button 'Request token'
    visit "/users/reset_password?token=#{User.first.password_token}"
    fill_in :password, with: "newpassword"
    fill_in :password_confirmation, with: "newpassword"
    click_button "Reset password"
    sign_in(email: User.first.email, password: "newpassword")
    expect(page).to have_content "Welcome, #{User.first.name}"
  end

  scenario 'it lets you know if you\'re passwords don\'t match' do
    click_button 'Request token'
    visit "/users/reset_password?token=#{User.first.password_token}"
    fill_in :password, with: "newpassword"
    fill_in :password_confirmation, with: "wrongpassword"
    click_button "Reset password"
    expect(page).to have_content 'Password does not match the confirmation'
    expect(page).to have_content 'Please enter your new password'
  end
end 

