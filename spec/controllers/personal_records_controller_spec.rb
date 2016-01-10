RSpec.describe PersonalRecordsController do
  let(:user) { create(:user) }
  let(:balance) { create(:balance, user: user)}

  describe 'POST #create' do
    context 'No user logged in' do
      it 'redirects him to login page' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'A user is logged in' do
      it 'creates a record given the right args' do
        sign_in user
        record_params = {
            title: 'title',
            amount: 10,
            date: '20/10/1993',
            personal_balance_id: balance.id
        }
        post :create, personal_record: record_params
        expect(response).to be_success
        expect(PersonalRecord.count).to be 1
        record = PersonalRecord.first
        expect(record.date).to eq record_params[:date].to_date
        expect(response.body).to eq record.to_json
      end
    end
  end

  describe 'PUT #update' do
    let(:record) { create(:personal_record, personal_balance: balance)}

    it 'updates a record given the right args' do
      sign_in user
      record_params = {
          title: 'new title',
          amount: 100,
          date: '20/10/1993',
      }
      put :update, id: record.id, personal_record: record_params
      expect(response).to be_success
      expect(PersonalRecord.count).to be 1
      record = PersonalRecord.first
      expect(record.date).to eq record_params[:date].to_date
      expect(response.body).to eq record.to_json
    end
  end

  describe 'DELETE #destroy' do
    let(:record) { create(:personal_record, personal_balance: balance) }

    it 'destroy a record' do
      sign_in user
      delete :destroy, id: record.id
      expect(response).to be_success
      expect(PersonalRecord.count).to be 0
      expect(response.body).to eq record.to_json
    end
  end


end