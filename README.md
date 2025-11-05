## データベース設計

### `users` テーブル

| カラム名              | データ型   | 概要                        | オプション                  |
| -------------------- | -------- | ----------------------     | --------------------------- |
| `id`                 | `Integer`| 主キー                      | `null: false`, `PRIMARY KEY` |
| `email`              | `string` | ログインに使用するメールアドレス | `null: false`, `unique: true` |
| `encrypted_password` | `string` | 暗号化されたパスワード         | `null: false`               |
| `nickname`           | `string` | アプリ内で表示されるニックネーム | `null: false`               |

### Associations
`has_many :spot`
`has_many :group`
`has_many :group_member`
`has_many :candidate_spot`


### `spots` テーブル

| カラム名             | データ型 | 概要                   | オプション                  |
| -------------------- | -------- | ---------------------- | ------------------------- |
| `user_id`            | `integer`| 主キー                | `null: false`, `index: true`,`foreign_key:true`|     
| `name`               | `string` | スポットの正式名称      | `null: false`               |
| `description`        | `text`   | メモ                  | `null: true`                |
| `latitude`           | `decimal`| 緯度                  | `null: false`               |
| `longitude`          | `decimal`| 経度                  | `null: false`               |
| `photo_url`　　　     | `string` | 写真のURL             | `null: true`                 |
| `tags`.              | `text`   | 分類や特徴を示すタグ     | `null: true`                |

### Associations
`belongs_to :user`
`has_many :candidate_spot`
`has_many :group`


### `groups` テーブル

| カラム名             | データ型 | 概要                      | オプション                  |
| -------------------- | -------- | ---------------------- | --------------------------- |
| `name`               | `string` | グループの計画名          | `null: false`               |
| `host_id`            | `integer`| 主要な管理者となるユーザーID| `null: false`, `index: true`, `foreign_key: true`|
| `description`.       | `text`.  | 詳細情報                | `null: true`               |
| `status`             | `string` | グループの計画状態        | `null: false`               |

### Associations
`belongs_to :user`
`has_many :group_member`
`has_many :candidate_spot`
`has_many :spot`


### `group_members` テーブル

| カラム名             | データ型 | 概要                   | オプション                  |
| -------------------- | -------- | ---------------------- | --------------------------- |
| `group_id`           | `integer`| グループのID            | `null: false`, `index: true`, `foreign_key: true`|
| `user_id`            | `integer`| 参加ユーザーのID         | `null: false`, `index: true`, `foreign_key: true`|
| `role`               | `string` | グループ内での役割        | `null: false`               |
| `joined_at`          | `datetime`| 参加した日時            | `null: false`               |

### Associations
`belongs_to :user`
`belongs_to :group`


### `candidate_spots` テーブル

| カラム名             | データ型 | 概要                   | オプション                  |
| -------------------- | -------- | ---------------------- | --------------------------- |
| `group_id`           | `integer`| 候補地が属するグループID | `null: false`, `index: true`, `foreign_key: true`|
| `spot_id`            | `integer`| 候補地として提案された元のスポット| `null: false`, `index: true`, `foreign_key: true`|
| `added_by_user_id`   | `integer`| 提案したユーザー         | `null: false`, `index: true`, `foreign_key: { to_table: :users }`|
| `votes`.             | `text`   | 投票したユーザーの配列    | `null: true`               |
| `is_decided`         | `boolean`| 最終ルートとして決定されたかのフラグ| `null: false`, `default: false`|
| `decided_order`      | `integer`| 訪問順序               | `null: true`               |

### Associations
`belongs_to :group`
`belongs_to :spot`
`belongs_to :user`