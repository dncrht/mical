module LoginHelper
  def log_in(user)
    post sessions_path, params: { user: { email: user&.email, password: 'admin' } }

    expect(response.status).to eq (user.present? ? 302 : 200)
  end
end
