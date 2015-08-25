class CreatePlaylistStyles < ActiveRecord::Migration
  def change
    create_table :playlist_styles do |t|
      t.belongs_to :playlist, index: true, foreign_key: true
      t.string :background_color
      t.string :color
      t.string :font_family
      t.string :font_size

      t.timestamps null: false
    end
  end
end
