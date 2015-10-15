class CreatePersonalBalances < ActiveRecord::Migration
  def change
    create_table :personal_balances do |t|
      t.belongs_to :user, index: true
      t.timestamps null: false
    end

    create_table :personal_records do |t|
      t.belongs_to :personal_balance, index: true
      t.string   "title"
      t.date     "date"
      t.float    "amount"
      t.timestamps null: false
    end
  end
end
