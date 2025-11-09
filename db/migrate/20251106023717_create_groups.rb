# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.text :description
      t.string :status, null: false

      t.timestamps
    end
  end
end