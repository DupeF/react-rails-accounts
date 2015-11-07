class AddNameToBalances < ActiveRecord::Migration
  def change
    add_column :personal_balances, :name, :string, null: false, default: ''
  end
end
