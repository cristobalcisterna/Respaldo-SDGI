json.extract! duty_manager, :id, :name_duty_manager, :rut, :email, :unit_id, :created_at, :updated_at
json.url duty_manager_url(duty_manager, format: :json)

json.unit do
    json.name_unit duty_manager.unit.name_unit
end