require 'sqlite3'

loc_db = SQLite3::Database.new 'word_locations.sqlite'
wc_db = SQLite3::Database.new 'word_count.sqlite'

wc_db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS WordCount(
    ID INT,
    Word TEXT,
    WC INT
  );
SQL

wcs = loc_db.execute('select word, count(word) as cnt from Words group by word order by cnt desc')

wc_db.transaction do
wcs.each_with_index do |wc, i|
  wc_db.execute('insert into WordCount(ID, Word, WC) values (?, ?, ?)', i + 1, wc[0], wc[1])
end
end
