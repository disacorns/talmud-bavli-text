require 'sqlite3'
require 'find'
require 'pry'

# create a database of locations for each word in shas

db = SQLite3::Database.new 'word_locations.sqlite'
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS Words(
    Word TEXT,
    Book TEXT,
    WordCount INT
  );
SQL

t = Time.now
db.transaction do
Find.find('clean_txts') do |path|
  puts path
  puts Time.now - t
  next unless path.include?('.')
  book = path.split('/')[1..-1].join('/')
  words = File.read(path).tr('()<>{}[]:', ' ').split(' ')
  words.each_with_index do |word, i|
      db.execute("insert into Words (Word, Book, WordCount) values (?, ?, ?)", word, book, i)
    end
  end
  break
end

puts Time.now - t
