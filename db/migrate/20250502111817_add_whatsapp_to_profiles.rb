class AddWhatsappToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :whatsapp, :string
  end
end
