class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.string :token
      t.string :type
      t.string :email
      t.decimal :amount
      t.boolean :payed
      t.boolean :refund, default: false
      t.references :note, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
