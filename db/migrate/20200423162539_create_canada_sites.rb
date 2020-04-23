class CreateCanadaSites < ActiveRecord::Migration[6.0]
  def change
    create_table :canada_sites do |t|
      t.string :name
      t.string :code
      t.string :province
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
