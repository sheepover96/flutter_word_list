const VERSION = 1;

const DB_INIT_QUERY = """
  CREATE TABLE tutorial (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    word TEXT NOT NULL,
    meaning TEXT
  )
""";
