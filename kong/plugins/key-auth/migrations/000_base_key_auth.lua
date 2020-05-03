return {
  postgres = {
    up = [[
      CREATE TABLE IF NOT EXISTS "keyauth_credentials" (
        "id"           UUID                         PRIMARY KEY,
        "created_at"   TIMESTAMP WITHOUT TIME ZONE  DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC'),
        "consumer_id"  UUID                         REFERENCES "consumers" ("id") ON DELETE CASCADE,
        "key"          TEXT                         UNIQUE
      );

      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "keyauth_consumer_idx" ON "keyauth_credentials" ("consumer_id");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;
    ]],
  },

  cassandra = {
    up = [[
      CREATE TABLE IF NOT EXISTS keyauth_credentials(
        id          uuid PRIMARY KEY,
        created_at  timestamp,
        consumer_id uuid,
        key         text
      );
      CREATE INDEX IF NOT EXISTS ON keyauth_credentials(key);
      CREATE INDEX IF NOT EXISTS ON keyauth_credentials(consumer_id);
    ]],
  },

  mysql = {
    up = [[
      CREATE TABLE `keyauth_credentials` (
      `id` varchar(50) PRIMARY KEY,
      `created_at` timestamp NOT NULL,
      `consumer_id` varchar(50),
      `key` text ,
      FOREIGN KEY (`consumer_id`) REFERENCES `consumers`(`id`) ON DELETE CASCADE
      ) ENGINE=INNODB DEFAULT CHARSET=utf8;

      -- ----------------------------
      -- Indexes structure for table keyauth_credentials
      -- ----------------------------
      CREATE INDEX keyauth_credentials_consumer_id_idx ON keyauth_credentials  (`consumer_id`);

      -- ----------------------------
      -- Uniques structure for table keyauth_credentials
      -- ----------------------------
      ALTER TABLE keyauth_credentials ADD CONSTRAINT keyauth_credentials_key_key UNIQUE (`key`(50));

      -- ----------------------------
      -- Foreign Keys structure for table keyauth_credentials
      -- ----------------------------
      ALTER TABLE keyauth_credentials ADD CONSTRAINT keyauth_credentials_consumer_id_fkey FOREIGN KEY (`consumer_id`) REFERENCES consumers (`id`) ON DELETE CASCADE;
    ]]
  },
}
