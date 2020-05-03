return {
  postgres = {
    up = [[
      CREATE TABLE IF NOT EXISTS "basicauth_credentials" (
        "id"           UUID                         PRIMARY KEY,
        "created_at"   TIMESTAMP WITHOUT TIME ZONE  DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC'),
        "consumer_id"  UUID                         REFERENCES "consumers" ("id") ON DELETE CASCADE,
        "username"     TEXT                         UNIQUE,
        "password"     TEXT
      );

      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "basicauth_consumer_id_idx" ON "basicauth_credentials" ("consumer_id");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;
    ]],
  },

  cassandra = {
    up = [[
      CREATE TABLE IF NOT EXISTS basicauth_credentials (
        id          uuid PRIMARY KEY,
        created_at  timestamp,
        consumer_id uuid,
        password    text,
        username    text
      );
      CREATE INDEX IF NOT EXISTS ON basicauth_credentials(username);
      CREATE INDEX IF NOT EXISTS ON basicauth_credentials(consumer_id);
    ]],
  },

  mysql = {
    up = [[
      CREATE TABLE `basicauth_credentials` (
      `id` varchar(50) PRIMARY KEY,
      `created_at` timestamp NOT NULL,
      `consumer_id` varchar(50),
      `username` text,
      `password` text,
      FOREIGN KEY (`consumer_id`) REFERENCES `consumers`(`id`) ON DELETE CASCADE
      ) ENGINE=INNODB DEFAULT CHARSET=utf8;

      -- ----------------------------
      -- Indexes structure for table basicauth_credentials
      -- ----------------------------
      CREATE INDEX basicauth_consumer_id_idx ON basicauth_credentials  (`consumer_id`);

      -- ----------------------------
      -- Uniques structure for table basicauth_credentials
      -- ----------------------------
      ALTER TABLE basicauth_credentials ADD CONSTRAINT basicauth_credentials_username_key UNIQUE (`username`(50));

      -- ----------------------------
      -- Foreign Keys structure for table basicauth_credentials
      -- ----------------------------
      ALTER TABLE basicauth_credentials ADD CONSTRAINT basicauth_credentials_consumer_id_fkey FOREIGN KEY (`consumer_id`) REFERENCES consumers (`id`) ON DELETE CASCADE;
    ]],
  },
}
