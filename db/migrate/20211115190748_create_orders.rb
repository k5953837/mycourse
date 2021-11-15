class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :expired_at
      t.string :subject
      t.integer :category, default: 0
      t.jsonb :snapshot, null: false, default: {}
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :orders, :category
    add_index :orders, :subject
  end
end
