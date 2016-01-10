RSpec.describe PersonalBalancesController do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'No user logged in' do
      it 'redirects him to login page' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'A user is logged in' do
      it 'creates a balance given the right args' do
        sign_in user
        post :create, personal_balance: {name: 'Balance Name'}
        expect(response).to be_success
        expect(PersonalBalance.count).to eq 1
        balance = PersonalBalance.first
        expect(balance.name).to eq 'Balance Name'
        expect(balance.user).to eq user
        expect(response.body).to eq balance.to_json
      end
    end
  end

  describe 'GET #show' do
    let(:balance) { create(:balance, user: user)}

    context 'HTML request' do
      it 'assigns everything needed to display a balance' do
        sign_in user
        # Records are sorted by date (descending order)
        records = [40, 10, -20].map do |i|
          create(:personal_record, personal_balance: balance, amount: i, date: Date.today + i.days)
        end
        get :show, id: balance.id
        expect(response).to be_success
        expect(assigns(:balance)).to eq balance
        expect(assigns(:records)).to eq records
        expect(assigns(:total_pages)).to eq 1
        expect(assigns(:total_credits)).to eq 50
        expect(assigns(:total_debits)).to eq -20
      end
    end

    context 'Ajax request' do
      it 'renders what is needed' do
        sign_in user
        # Records are sorted by date (descending order)
        records = [40, 10, -20].map do |i|
          create(:personal_record, personal_balance: balance, amount: i, date: Date.today + i.days)
        end
        xhr :get, :show, id: balance.id
        expect(response).to be_success
        result = {
            records: records,
            total_pages: 1
        }
        expect(response.body).to eq result.to_json
      end
    end
  end
end