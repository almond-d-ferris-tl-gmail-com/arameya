class ChangeColumnNullOffAdMemMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_null :ad_mem_messages, :am_mess_title, true
    change_column_null :ad_mem_messages, :am_mess_item, true
    change_column_null :ad_mem_messages, :am_mess_reply, true
    change_column_null :ad_mem_messages, :am_mess_speaker, true
  end
end
