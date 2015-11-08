RSpec.describe DashboardController do
  describe 'GET #show' do
    context 'No user logged in' do
      it 'redirects him to login page' do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Two users are registered' do
      let(:user) { create(:user) }
      let(:user2) { create(:user, email: 'jane.doe@test.com') }

      it 'renders only his balances' do
        user1_balances = create_list(:balance, 3, user: user)
        create_list(:balance, 2, user: user2)
        sign_in user
        get :show
        expect(response).to be_success
        expect(assigns(:balances)).to match_array user1_balances
      end
    end
  end
end
