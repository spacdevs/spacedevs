module Support
  def login_as(user)
    visit new_session_path
    fill_in 'Matricula', with: user.registration_code
    fill_in 'Senha', with: user.password
    click_button 'Entrar'
  end

  def sign_in(user)
    user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
      Current.session = session
      cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
    end
  end

  def logout(user)
    user.sessions&.destroy_all
    cookies.delete(:session_id)
  end
end
