require 'pg'

def conn
  if ENV["RACK_ENV"] == "production"
    @db ||= PG.connect(
      dbname: ENV["POSTGRES_DB"],
      host: ENV["POSTGRES_HOST"],
      password: ENV["POSTGRES_PASS"],
      user: ENV["POSTGRES_USER"]
    )
  else
    PG.connect(dbname: "Favartist")
  end
end

conn.exec("DROP TABLE IF EXISTS Users")
conn.exec("DROP TABLE IF EXISTS Topics")
conn.exec("DROP TABLE IF EXISTS Comments")


conn.exec("CREATE TABLE users(
    id          SERIAL PRIMARY KEY,
    Username    VARCHAR,
    Password    VARCHAR,
    Email       VARCHAR
  )"
)

conn.exec("INSERT INTO users(Username, Password, Email) VALUES (
    'Christian95',
    'Password123',
    'blah@gmail.com'
  )"
)


conn.exec("CREATE TABLE topics(
    id          SERIAL PRIMARY KEY,
    title       VARCHAR,
    text        VARCHAR,
    user_id     VARCHAR,
    date        TIMESTAMP
      )"
)

conn.exec("INSERT INTO topics(Title, Text, User_id, Date) VALUES (
    'How do you feel about:',
    'Gold Panda?',
    '1',
    CURRENT_TIMESTAMP
  )"
)

conn.exec("CREATE TABLE comments(
    id          SERIAL PRIMARY KEY,
    text        VARCHAR,
    user_id     VARCHAR,
    topic_id    VARCHAR,
    date        TIMESTAMP
  )"
)

conn.exec("INSERT INTO comments(Text, User_id, Topic_id, Date) VALUES (
    '',
    '21',
    'post_31',
    CURRENT_TIMESTAMP
    )"
)

