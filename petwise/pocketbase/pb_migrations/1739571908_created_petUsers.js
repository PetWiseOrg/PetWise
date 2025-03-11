/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "gblycbgah7tq78e",
    "created": "2025-02-14 22:25:08.988Z",
    "updated": "2025-02-14 22:25:08.988Z",
    "name": "petUsers",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "goxkcqpk",
        "name": "user",
        "type": "relation",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "collectionId": "_pb_users_auth_",
          "cascadeDelete": true,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "rxs8kpva",
        "name": "homeAddress",
        "type": "text",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "xhti1z3i",
        "name": "preferences",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 2000000
        }
      }
    ],
    "indexes": [
      "CREATE UNIQUE INDEX `idx_tE9Apd4` ON `petUsers` (`user`)"
    ],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("gblycbgah7tq78e");

  return dao.deleteCollection(collection);
})
