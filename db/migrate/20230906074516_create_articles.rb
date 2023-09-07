# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :public_status

      t.timestamps
    end
  end
end
