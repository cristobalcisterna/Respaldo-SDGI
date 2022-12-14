namespace 'permissions' do
  desc "Loading all models and their related controller methods inpermissions table."
  task(:permissions => :environment) do
    puts "CARGANDO PERMISOS Y ACCIONES"
    arr = []
    #load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ #namescoped controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/ && entry!="admin"
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr.each do |controller|
      #only that controller which represents a model
      if controller.permission
        #create a universal permission for that model. eg "manage User" will allow all actions on User model.
        write_permission(controller.permission, "manage", 'manage') #add permission to do CRUD for every model.
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/ #add_user, add_user_info, Add_user, add_User
            name, cancan_action = eval_cancan_action(method)
            write_permission(controller.permission, cancan_action, name)
          end
        end
      end
    end
    puts "FINALIZADO PERMISSIONS"
  end

  #EJEMPLO PARA AÑADIR PERMISOS A UN CARGO EN ESPECIFICO
  # desc "Agregar Cargo Analista de la subdirección de I+D FING y persmisos asociados"
  # task analysts: :environment do
  #   nombre_internal = "ANALISTA I+D FING"
  #   Unit.ingenieria.each do |dpto|
  #     FUNCIÓN QUE AÑADE LOS PERMISOS A LA TABLA INTERMEDIA
  #     InternalPositionPermission.assign_permission(nombre_internal,"Validation","index", dpto.name)
  #   end
  # end

end

#this method returns the cancan action for the action passed.
def eval_cancan_action(action)
  name = action.to_s
  cancan_action = action.to_s
  return name, cancan_action
end

#check if the permission is present else add a new one.
def write_permission(model, cancan_action, name)
  permission = Permission.where(subject_class: model, action: cancan_action).first
  unless permission
    permission = Permission.new
    permission.name = name
    permission.subject_class = model
    permission.action = cancan_action
    permission.save
  end
end