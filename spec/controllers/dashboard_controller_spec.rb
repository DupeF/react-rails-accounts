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

      it 'renders only his balances and the groups he is a member of' do
        user_balance = create(:balance, user: user)
        create(:balance, user: user2)
        user_group = create(:group, users: [user, user2])
        create(:group, users: [user2])
        sign_in user
        get :show
        expect(response).to be_success
        expect(assigns(:balances)).to match_array [user_balance]
        expect(assigns(:groups)).to match_array [user_group]
      end
    end
  end

end
