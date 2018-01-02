admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "admin12#$",
    roles: [ { role: "root", db: "admin" } ]
  }
)

db.getSiblingDB("admin").auth("admin", "admin12#$" )

db.getSiblingDB("corning").createUser(
  {
    "user" : "gwee",
    "pwd" : "gwee12#$",
    roles: [ { "role" : "readWrite", "db" : "corning" } ]
  }
)
