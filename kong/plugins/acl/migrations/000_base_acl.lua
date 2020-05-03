return {
  postgres = {
    up = [[
      CREATE TABLE IF NOT EXISTS "acls" (
        "id"           UUID                         PRIMARY KEY,
        "created_at"   TIMESTAMP WITHOUT TIME ZONE  DEFAULT (CURRENT_TIMESTAMP(0) AT TIME ZONE 'UTC'),
        "consumer_id"  UUID                         REFERENCES "consumers" ("id") ON DELETE CASCADE,
        "group"        TEXT
      );

      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "acls_consumer_id" ON "acls" ("consumer_id");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;

      DO $$
      BEGIN
        CREATE INDEX IF NOT EXISTS "acls_group" ON "acls" ("group");
      EXCEPTION WHEN UNDEFINED_COLUMN THEN
        -- Do nothing, accept existing state
      END$$;
    ]],
  },

  cassandra = {
    up = [[
      CREATE TABLE IF NOT EXISTS acls(
        id          uuid PRIMARY KEY,
        created_at  timestamp,
        consumer_id uuid,
        group       text
      );
      CREATE INDEX IF NOT EXISTS ON acls(group);
      CREATE INDEX IF NOT EXISTS ON acls(consumer_id);
    ]],
  },

  mysql = {
    up = [[
      CREATE TABLE `acls` (
      `id` varchar(50) PRIMARY KEY,
      `created_at` timestamp NOT NULL,
      `consumer_id` varchar(50),
      `group` text ,
      `cache_key` text,
      FOREIGN KEY (`consumer_id`) REFERENCES `consumers`(`id`) ON DELETE CASCADE
      ) ENGINE=INNODB DEFAULT CHARSET=utf8;
      -- ----------------------------
      -- Indexes structure for table acls
      -- ----------------------------
      CREATE INDEX acls_consumer_id_idx ON acls  (`consumer_id`);
      CREATE INDEX acls_group_idx ON acls  (`group`(50));
      -- ----------------------------
      -- Uniques structure for table acls
      -- ----------------------------
      ALTER TABLE acls ADD CONSTRAINT acls_cache_key_key UNIQUE (`cache_key`(50));
      -- ----------------------------
      -- Foreign Keys structure for table acls
      -- ----------------------------
      ALTER TABLE acls ADD CONSTRAINT acls_consumer_id_fkey FOREIGN KEY (`consumer_id`) REFERENCES consumers (`id`) ON DELETE CASCADE;
    ]],
  },

}
