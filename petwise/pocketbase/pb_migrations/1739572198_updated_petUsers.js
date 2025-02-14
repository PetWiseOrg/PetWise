/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("gblycbgah7tq78e")

  collection.createRule = "user.userType != \"vetUser\""

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("gblycbgah7tq78e")

  collection.createRule = "user.userType != \"\""

  return dao.saveCollection(collection)
})
