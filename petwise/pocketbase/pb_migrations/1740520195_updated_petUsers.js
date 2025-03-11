/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("gblycbgah7tq78e")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "lwhfrhjh",
    "name": "pets",
    "type": "relation",
    "required": false,
    "presentable": true,
    "unique": false,
    "options": {
      "collectionId": "n2uco3xdetxn1ov",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("gblycbgah7tq78e")

  // remove
  collection.schema.removeField("lwhfrhjh")

  return dao.saveCollection(collection)
})
