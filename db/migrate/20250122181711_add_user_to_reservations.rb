class AddUserToReservations < ActiveRecord::Migration[7.1]
  def change
    # emailとnameカラムを削除（既存のデータは失われます）
    remove_column :reservations, :email
    remove_column :reservations, :name

    # user_idを追加
    add_reference :reservations, :user, foreign_key: true
  end
end
