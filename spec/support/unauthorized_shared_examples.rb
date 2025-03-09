RSpec.shared_examples 'unauthorized access' do |http_method, action, params = {}|
  before { send(http_method, action, params: params) }

  it 'redirects to login' do
    expect(response).to redirect_to(new_session_path)
  end

  it 'does not render the template' do
    expect(response).not_to render_template(action)
  end

  it 'does not create a discipline' do
    expect(flash[:notice]).to be_nil
  end
end
