RSpec.describe RecordsController do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'jane.doe@test.com') }
  let(:group) { create(:group, users: [user, user2])}
  let(:record) { create(:record, group: group, payer: user, users: [user, user2])}

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
            group_id: group.id,
            payer_id: user2.id,
            user_ids: [user.id, user2.id]
        }
        post :create, record: record_params
        expect(response).to be_success
        expect(Record.count).to be 1
        record = Record.first
        expect(record.date).to eq record_params[:date].to_date
        expect(record.users.count).to eq 2
        expect(response.body).to eq record.to_json
      end
    end
  end

  describe 'PUT #update' do
    it 'updates a record given the right args' do
      sign_in user
      record_params = {
          title: 'new title',
          amount: 100,
          date: '20/10/1993',
          payer_id: user2.id,
          user_ids: [user2.id]
      }
      put :update, id: record.id, record: record_params
      expect(response).to be_success
      expect(Record.count).to be 1
      record = Record.first
      expect(record.date).to eq record_params[:date].to_date
      expect(record.payer_id).to eq user2.id
      expect(record.users.count).to eq 1
      expect(response.body).to eq record.to_json
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy a record' do
      sign_in user
      delete :destroy, id: record.id
      expect(response).to be_success
      expect(Record.count).to be 0
      expect(response.body).to be_empty
    end
  end


end