/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("37n4ix9oc280cbv")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ajuog1vg",
    "name": "preferences",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 2000000
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("37n4ix9oc280cbv")

  // remove
  collection.schema.removeField("ajuog1vg")

  return dao.saveCollection(collection)
})
