/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "37n4ix9oc280cbv",
    "created": "2025-02-25 21:34:04.817Z",
    "updated": "2025-02-25 21:34:04.817Z",
    "name": "vetUsers",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "ws7xqkjn",
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
        "id": "rswsuhla",
        "name": "vetRole",
        "type": "select",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSelect": 1,
          "values": [
            "doctor",
            "administrator"
          ]
        }
      },
      {
        "system": false,
        "id": "mlmhwqu8",
        "name": "bio",
        "type": "text",
        "required": false,
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
        "id": "snjtmwzp",
        "name": "licenseNumber",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [
      "CREATE UNIQUE INDEX `idx_4Ahxfzr` ON `vetUsers` (`user`)"
    ],
    "listRule": "id = @request.auth.id",
    "viewRule": "id = @request.auth.id",
    "createRule": "user.userType != \"vetUser\"",
    "updateRule": "id = @request.auth.id",
    "deleteRule": "id = @request.auth.id",
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("37n4ix9oc280cbv");

  return dao.deleteCollection(collection);
})
