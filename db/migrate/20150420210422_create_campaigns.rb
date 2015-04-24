class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.integer :goal
      t.text :description
      t.datetime :ends_on

      t.timestamps null: false
    end
  end
end
