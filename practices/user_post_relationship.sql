                                 Table "public.user"
    Column    |            Type             | Collation | Nullable | Default
--------------+-----------------------------+-----------+----------+---------
 id           | bigint                      |           | not null |
 created_at   | timestamp without time zone |           |          |
 email        | character varying(255)      |           | not null |
 password     | character varying(255)      |           | not null |
 post_amounts | bigint                      |           |          | 0
 username     | character varying(255)      |           | not null |
Indexes:
    "user_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "post" CONSTRAINT "fk51aeb5le008k8klgnyfaalmn" FOREIGN KEY (user_id) REFERENCES "user"(id)


spring_test=# \d post
                              Table "public.post"
     Column      |            Type             | Collation | Nullable | Default
-----------------+-----------------------------+-----------+----------+---------
 id              | bigint                      |           | not null |
 comment_amounts | integer                     |           |          | 0
 confused_points | integer                     |           |          | 0
 content         | character varying(255)      |           |          |
 created_at      | timestamp without time zone |           |          |
 laugh_points    | integer                     |           |          | 0
 like_points     | integer                     |           |          | 0
 title           | character varying(255)      |           | not null |
 updated_at      | timestamp without time zone |           |          |
 user_id         | bigint                      |           |          |
 view_count      | integer                     |           |          | 0
 vote_points     | integer                     |           |          | 0
Indexes:
    "post_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "fk51aeb5le008k8klgnyfaalmn" FOREIGN KEY (user_id) REFERENCES "user"(id)