require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    it 'Creates user record' do
      expect{
      post users_path, params: { first_name: 'John', last_name: 'Doe', password: 'passw3rd', email: 'john@john.com' }
      }.to change {User.count}.by(1)
      expect(response).to have_http_status(200)
    end
  end
end
