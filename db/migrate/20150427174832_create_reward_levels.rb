class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|
      t.references :campaign, index: true, foreign_key: true
      t.integer :amount
      t.text :description

      t.timestamps null: false
    end
  end
end
