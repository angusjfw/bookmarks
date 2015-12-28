module SessionHelpers
  def sign_up(
    name: 'Joe B', 
    email: 'joe.bloggs@gmail.com', 
    password: 'jo3ble0bl3',
    password_confirmation: 'jo3ble0bl3'
  )
    visit '/users/new'
    fill_in 'name', with: name
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email: 'joe.bloggs@gmail.com', password: 'jo3ble0bl3')
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end
end
  
