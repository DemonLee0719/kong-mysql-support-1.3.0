return {
  postgres = {
    up = [[
      CREATE TABLE IF NOT EXISTS "hmacauth_credentials" (
        "id"           UUID                         PRIMARY KEY,
        "created_at"   TIMESTAMP WITHOUT TIME ZONE  DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC'),
        "consumer_id"  UUID                         REFERENCES "consumers" ("id") ON DELETE CASCADE,
        "username"     TEXT                         UNIQUE,
        "secret"       TEXT
      );

      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "hmacauth_credentials_consumer_id" ON "hmacauth_credentials" ("consumer_id");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;
    ]],
  },

  cassandra = {
    up = [[
      CREATE TABLE IF NOT EXISTS hmacauth_credentials(
        id          uuid PRIMARY KEY,
        created_at  timestamp,
        consumer_id uuid,
        username    text,
        secret      text
      );
      CREATE INDEX IF NOT EXISTS ON hmacauth_credentials(username);
      CREATE INDEX IF NOT EXISTS ON hmacauth_credentials(consumer_id);
    ]],
  },

  mysql = {
    up = [[
      CREATE TABLE `hmacauth_credentials` (
      `id` varchar(50) PRIMARY KEY,
      `created_at` timestamp NOT NULL,
      `consumer_id` varchar(50),
      `username` text ,
      `secret` text,
      FOREIGN KEY (`consumer_id`) REFERENCES `consumers`(`id`) ON DELETE CASCADE
      ) ENGINE=INNODB DEFAULT CHARSET=utf8;

      -- ----------------------------
      -- Indexes structure for table hmacauth_credentials
      -- ----------------------------
      CREATE INDEX hmacauth_credentials_consumer_id_idx ON hmacauth_credentials  (`consumer_id`);

      -- ----------------------------
      -- Uniques structure for table hmacauth_credentials
      -- ----------------------------
      ALTER TABLE hmacauth_credentials ADD CONSTRAINT hmacauth_credentials_username_key UNIQUE (`username`(50));

      -- ----------------------------
      -- Foreign Keys structure for table hmacauth_credentials
      -- ----------------------------
      ALTER TABLE hmacauth_credentials ADD CONSTRAINT hmacauth_credentials_consumer_id_fkey FOREIGN KEY (`consumer_id`) REFERENCES consumers (`id`) ON DELETE CASCADE;
    ]],
  },
}
