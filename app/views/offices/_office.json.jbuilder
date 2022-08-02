json.extract! office, :id, :name_office, :identification_number_office, :location, :office_description, :hours_available, :square_meter, :campus_identification, :duty_manager_id, :building_id, :created_at, :updated_at
json.url office_url(office, format: :json)

json.building do
    json.name_building office.building.name_building
end

json.duty_manager do
    json.name_duty_manager office.duty_manager.name_duty_manager
end
