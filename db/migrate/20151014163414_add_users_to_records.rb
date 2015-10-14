class AddUsersToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :payer, index: true

    create_table :record_involvements do |t|
      t.belongs_to :user, index: true
      t.belongs_to :record, index: true
      t.float :amount
      t.timestamps null: false
    end

  end
end
