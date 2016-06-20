class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.belongs_to :user, index: true
      t.string :provider, index: true, null: false, default: ""
      t.string :uid, index: true, null: false, default: ""
      t.index [:provider, :uid], unique: true

      t.timestamps null: false
    end
  end
end
