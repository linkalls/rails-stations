# スクリーンの作成
screen1 = Screen.create!(name: 1)
screen2 = Screen.create!(name: 2)
screen3 = Screen.create!(name: 3)

# 映画の作成
movie1 = Movie.create!(
  name: 'スター・ウォーズ',
  description: '銀河の彼方で繰り広げられる壮大な物語',
  image_url: 'https://example.com/starwars.jpg',
  is_showing: true
)

movie2 = Movie.create!(
  name: 'ハリー・ポッター',
  description: '魔法学校で学ぶ少年の成長物語',
  image_url: 'https://example.com/harrypotter.jpg',
  is_showing: true
)

# スケジュールの作成（各映画を各スクリーンで上映）
[screen1, screen2, screen3].each do |screen|
  Schedule.create!(
    movie: movie1,
    screen: screen,
    start_time: '10:00',
    end_time: '12:30'
  )

  Schedule.create!(
    movie: movie2,
    screen: screen,
    start_time: '13:00',
    end_time: '15:30'
  )
end

# 座席の作成
rows = ('a'..'e').to_a
columns = (1..10).to_a

rows.each do |row|
  columns.each do |column|
    Sheet.create!(
      row: row,
      column: column
    )
  end
end
