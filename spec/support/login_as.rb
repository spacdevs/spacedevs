module Support
  def login_as(user)
    visit new_session_path
    fill_in 'Matricula', with: user.registration_code
    fill_in 'Senha', with: user.password
    click_button 'Entrar'
  end
end
