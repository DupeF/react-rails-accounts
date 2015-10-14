class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :group_memberships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :groups, index: true
      t.string :role
      t.timestamps null: false
    end

    add_reference :records, :group, index: true
  end
end
