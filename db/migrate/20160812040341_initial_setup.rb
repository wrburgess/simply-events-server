class InitialSetup < ActiveRecord::Migration[5.0]
  def change
    create_table :events, id: :uuid, force: true do |t|
      t.string     :name
      t.string     :description
      t.timestamps null: false
    end

    create_table :users, id: :uuid, force: true do |t|
      t.string     :email
      t.string     :first_name
      t.string     :last_name
      t.timestamps null: false
    end
  end
end
