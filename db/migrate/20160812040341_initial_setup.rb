class InitialSetup < ActiveRecord::Migration[5.0]
  def change
    create_table :events, id: :uuid, force: true do |t|
      t.string     :name
      t.string     :description
      t.timestamps null: false
    end
  end
end
