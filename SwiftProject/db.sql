CREATE TABLE IF NOT EXISTS "statuses" ("statusid" INTEGER PRIMARY KEY  NOT NULL ,"status" TEXT NOT NULL ,"userid" INTEGER NOT NULL ,"time" TEXT NOT NULL  DEFAULT (datetime('now','localtime')) )
