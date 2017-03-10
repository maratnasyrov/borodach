class AddTelegramChatIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :telegram_chat_id, :integer
  end
end
