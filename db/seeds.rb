# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# SEED INTERNAL POSITIONS
internal_positions = [
  "SUPERADMIN", "VISITANTE"
]

#CREATE INTERNALS POSITIONS
internal_positions.each do |name|
  InternalPosition.create(name: name) unless InternalPosition.exists?(name: name)
end
#PERMISOS
Permission.create(subject_class: "all", action: "manage", name:"manage") unless Permission.exists?(subject_class: "all", action: "manage", name:"manage")
Permission.create(subject_class: "Search", action: "index", name: "index") unless Permission.exists?(subject_class: "Search", action: "index", name: "index")
InternalPositionPermission.assign_permission("SUPERADMIN","all","manage")
InternalPositionPermission.assign_permission("VISITANTE","Welcome","index")
InternalPositionPermission.assign_permission("VISITANTE","Profile","change_user_profile")
