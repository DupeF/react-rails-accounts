RSpec.describe GroupsController do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'No user logged in' do
      it 'redirects him to login page' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'A user is logged in' do
      it 'creates a group given the right args' do
        sign_in user
        post :create, group: {name: 'Group Name'}
        expect(response).to be_success
        expect(Group.count).to eq 1
        group = Group.first
        expect(group.name).to eq 'Group Name'
        expect(group.users).to eq [user]
        expect(response.body).to eq group.to_json
      end
    end
  end

  describe 'GET #show' do
    let(:user2) { create(:user, email: 'jane.doe@test.com') }
    let(:group) { create(:group, users: [user, user2])}

    context 'HTML request' do
      it 'assigns everything needed to display a group' do
        sign_in user
        # Records are sorted by date (descending order)
        [40, 10, -20].each do |i|
          create(:record, group: group, amount: i, date: Date.today + i.days, payer: user, users: [user, user2])
        end
        records = Record.last(3)
        get :show, id: group.id
        expect(response).to be_success
        expect(assigns(:group)).to eq group
        expect(assigns(:users)).to eq [user, user2]
        expected_records = records.map { |r|
          {
              'id' => r.id,
              'title' => r.title,
              'date' => r.date,
              'amount' => r.amount,
              'created_at' => r.created_at,
              'updated_at' => r.updated_at,
              'group_id' => r.group_id,
              'payer_id' => user.id,
              'payer' => {'id' => user.id, 'email' => user.email},
              'users' => [{'id' => user.id, 'email' => user.email}, {'id' => user2.id, 'email' => user2.email}]
          }
        }
        expect(assigns(:records)).to eq expected_records
        expect(assigns(:total_pages)).to eq 1
      end
    end

    context 'Ajax request' do
      it 'renders what is needed' do
        sign_in user
        # Records are sorted by date (descending order)
        records = [40, 10, -20].map do |i|
          create(:record, group: group, amount: i, date: Date.today + i.days, payer: user, users: [user, user2])
        end
        xhr :get, :show, id: group.id
        expect(response).to be_success
        result = {
            records: records.map { |r|
              {
                  'id' => r.id,
                  'title' => r.title,
                  'date' => r.date,
                  'amount' => r.amount,
                  'created_at' => r.created_at,
                  'updated_at' => r.updated_at,
                  'group_id' => r.group_id,
                  'payer_id' => user.id,
                  'payer' => {'id' => user.id, 'email' => user.email},
                  'users' => [{'id' => user.id, 'email' => user.email}, {'id' => user2.id, 'email' => user2.email}]
              }
            },
            total_pages: 1
        }
        expect(response.body).to eq result.to_json
      end
    end
  end
end