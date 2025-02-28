/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("37n4ix9oc280cbv")

  collection.createRule = "user.userType != \"petUser\""

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("37n4ix9oc280cbv")

  collection.createRule = "user.userType != \"vetUser\""

  return dao.saveCollection(collection)
})
