class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string  :title,  null: false
      t.string  :author, null: false
      t.integer :status, null: false, default: 0   # 0=wishlist, 1=reading, 2=finished
      t.integer :rating                           # 0..5 (optional)
      t.text    :notes
      t.date    :started_on
      t.date    :finished_on

      t.timestamps
    end

    add_index :books, :status
    add_index :books, :rating
  end
end

