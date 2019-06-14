class CreateFileUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :file_uploads do |t|
      t.string :name
      t.string :token
      t.string :csv_path
      t.string :file

      t.timestamps
    end

    add_index :file_uploads, :token
  end
end
