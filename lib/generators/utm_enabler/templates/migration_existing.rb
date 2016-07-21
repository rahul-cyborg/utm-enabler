class CreateCampaignData < ActiveRecord::Migration
  def change
    create_table :campaign_data do |t|
      t.belongs_to :user, index: true
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign
      t.string :channel

      t.timestamps null: false
    end
  end
end
