class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.text :body
      t.integer :user_id
      t.string :edit_summary

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
