/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "9j88q1ivx0iudjc",
    "created": "2024-11-19 21:30:51.958Z",
    "updated": "2024-11-19 21:30:51.958Z",
    "name": "friendships",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "8c8rpibv",
        "name": "requesterId",
        "type": "relation",
        "required": true,
        "presentable": false,
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
        "id": "yvfqge5k",
        "name": "addresseeId",
        "type": "relation",
        "required": true,
        "presentable": false,
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
        "id": "ygldp7xw",
        "name": "status",
        "type": "select",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSelect": 1,
          "values": [
            "pending",
            "accepted",
            "rejected",
            "blocked"
          ]
        }
      },
      {
        "system": false,
        "id": "gacispg2",
        "name": "blockedAt",
        "type": "date",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": "",
          "max": ""
        }
      }
    ],
    "indexes": [
      "CREATE UNIQUE INDEX `idx_JIXaxhB` ON `friendships` (\n  `requesterId`,\n  `addresseeId`\n)",
      "CREATE UNIQUE INDEX `idx_xYgnHEp` ON `friendships` (\n  `addresseeId`,\n  `requesterId`\n)"
    ],
    "listRule": "@request.auth.id != \"\"",
    "viewRule": "@request.auth.id = requesterId || @request.auth.id = addresseeId",
    "createRule": "@request.auth.id != \"\"",
    "updateRule": "@request.auth.id = requesterId || @request.auth.id = addresseeId",
    "deleteRule": "@request.auth.id = requesterId || @request.auth.id = addresseeId",
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("9j88q1ivx0iudjc");

  return dao.deleteCollection(collection);
})
