ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'db/movies.sqlite3'
)
