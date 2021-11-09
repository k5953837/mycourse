class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :subject
      t.float :price
      t.integer :currency, default: 0
      t.integer :category, default: 0
      t.integer :status, default: 1
      t.text :url
      t.text :description
      t.integer :duration

      t.timestamps
    end
  end
end
