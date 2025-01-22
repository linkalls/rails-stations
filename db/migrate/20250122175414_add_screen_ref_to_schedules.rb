class AddScreenRefToSchedules < ActiveRecord::Migration[7.1]
  def up
    # スクリーン1を作成
    screen1 = Screen.create!(name: 'スクリーン1')
    screen2 = Screen.create!(name: 'スクリーン2')
    screen3 = Screen.create!(name: 'スクリーン3')

    # 外部キーを追加（null許可）
    add_reference :schedules, :screen, foreign_key: true

    # 既存のスケジュールをスクリーン1に割り当て
    Schedule.update_all(screen_id: screen1.id)

    # null制約を追加
    change_column_null :schedules, :screen_id, false
  end

  def down
    remove_reference :schedules, :screen
  end
end
