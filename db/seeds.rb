# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Admin
admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

# Transportadora 1
first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

first_sc_user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: first_sc)

first_sc_first_vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: first_sc)
first_sc_second_vehicle = Vehicle.create!(id_plate: 'XYZ-5678', make: 'Fiat', model: 'Ducato', year: '2020', load_capacity: 1378, shipping_company: first_sc)

first_sc_order = Order.create!(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: 'VWJGX1FHUHENKC6', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 'approved', shipping_company: first_sc, vehicle: first_sc_first_vehicle)

first_sc_order_first_route_update = RouteUpdate.create!(date: '28/05/2022', time: '10:41', current_location: 'Avenida Alberto Byington, 1933, São Paulo - SP', order: first_sc_order)

first_sc_order_second_route_update = RouteUpdate.create!(date: '05/06/2022', time: '17:12', current_location: 'Rua Barão do Rio Branco, 922, Fortaleza - CE', order: first_sc_order)

VolumePrice.create!(initial_volume: 0, final_volume: 0.250, price: 0.75, shipping_company: first_sc)
VolumePrice.create!(initial_volume: 0.251, final_volume: 0.500, price: 1.40, shipping_company: first_sc)
VolumePrice.create!(initial_volume: 0.501, final_volume: 0.750, price: 1.90, shipping_company: first_sc)
VolumePrice.create!(initial_volume: 0.751, final_volume: 1.000, price: 2.50, shipping_company: first_sc)

WeightPrice.create!(initial_weight: 0, final_weight: 5.00, price: 0.350, shipping_company: first_sc)
WeightPrice.create!(initial_weight: 5.01, final_weight: 10.00, price: 0.80, shipping_company: first_sc)
WeightPrice.create!(initial_weight: 10.01, final_weight: 15.00, price: 1.55, shipping_company: first_sc)
WeightPrice.create!(initial_weight: 15.01, final_weight: 20.00, price: 2.10, shipping_company: first_sc)

DeliveryTime.create!(initial_distance: 0.0, final_distance: 100.0, weekdays: 2, shipping_company: first_sc)
DeliveryTime.create!(initial_distance: 100.1, final_distance: 300.0, weekdays: 5, shipping_company: first_sc)
DeliveryTime.create!(initial_distance: 300.1, final_distance: 500.0, weekdays: 8, shipping_company: first_sc)
DeliveryTime.create!(initial_distance: 500.1, final_distance: 800.0, weekdays: 14, shipping_company: first_sc)

# Arrange Transportadora 2
second_sc = ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

second_sc_user = User.create!(email: 'teste@embraen.com.br', password: 'embraen123', shipping_company: second_sc)

VolumePrice.create!(initial_volume: 0, final_volume: 0.650, price: 0.40, shipping_company: second_sc)
VolumePrice.create!(initial_volume: 0.651, final_volume: 1.050, price: 0.90, shipping_company: second_sc)
VolumePrice.create!(initial_volume: 1.051, final_volume: 1.610, price: 1.30, shipping_company: second_sc)
VolumePrice.create!(initial_volume: 1.611, final_volume: 1.880, price: 1.80, shipping_company: second_sc)

WeightPrice.create!(initial_weight: 0, final_weight: 7.00, price: 0.60, shipping_company: second_sc)
WeightPrice.create!(initial_weight: 7.01, final_weight: 14.00, price: 0.90, shipping_company: second_sc)
WeightPrice.create!(initial_weight: 14.01, final_weight: 21.00, price: 1.25, shipping_company: second_sc)
WeightPrice.create!(initial_weight: 21.01, final_weight: 28.00, price: 1.95, shipping_company: second_sc)

DeliveryTime.create!(initial_distance: 0.0, final_distance: 200.0, weekdays: 4, shipping_company: second_sc)
DeliveryTime.create!(initial_distance: 200.1, final_distance: 400.0, weekdays: 7, shipping_company: second_sc)
DeliveryTime.create!(initial_distance: 400.1, final_distance: 600.0, weekdays: 11, shipping_company: second_sc)
DeliveryTime.create!(initial_distance: 600.1, final_distance: 800.0, weekdays: 16, shipping_company: second_sc)


# Arrange Transportadora 3
third_sc = ShippingCompany.create!(corporate_name: 'Transportadora Route LTDA', brand_name: 'Route', registration_number: '12787399001072', email_domain: '@route.com.br', address: 'Rua Barão Do Rio Branco, 2027, Fortaleza - CE')

third_sc_user = User.create!(email: 'teste@route.com.br', password: 'route123', shipping_company: third_sc)

VolumePrice.create!(initial_volume: 0, final_volume: 0.500, price: 0.75, shipping_company: third_sc)
VolumePrice.create!(initial_volume: 0.501, final_volume: 1.000, price: 1.25, shipping_company: third_sc)
VolumePrice.create!(initial_volume: 1.001, final_volume: 1.500, price: 1.75, shipping_company: third_sc)
VolumePrice.create!(initial_volume: 1.500, final_volume: 2.000, price: 2.25, shipping_company: third_sc)

WeightPrice.create!(initial_weight: 0, final_weight: 9.00, price: 1.10, shipping_company: third_sc)
WeightPrice.create!(initial_weight: 9.01, final_weight: 18.00, price: 1.70, shipping_company: third_sc)
WeightPrice.create!(initial_weight: 18.01, final_weight: 27.00, price: 2.20, shipping_company: third_sc)
WeightPrice.create!(initial_weight: 27.01, final_weight: 36.00, price: 3.00, shipping_company: third_sc)

DeliveryTime.create!(initial_distance: 0, final_distance: 250.0, weekdays: 5, shipping_company: third_sc)
DeliveryTime.create!(initial_distance: 250.1, final_distance: 500.0, weekdays: 11, shipping_company: third_sc)
DeliveryTime.create!(initial_distance: 500.1, final_distance: 750.0, weekdays: 14, shipping_company: third_sc)
DeliveryTime.create!(initial_distance: 750.1, final_distance: 1000.0, weekdays: 19, shipping_company: third_sc)

# Arrange Transportadora 4
forth_sc = ShippingCompany.create!(corporate_name: 'Transportadora Tressi LTDA', brand_name: 'Tressi', registration_number: '00651266000102', email_domain: '@tressi.com.br', address: 'Avenida José João Muraro, 1514, Toledo - PR')

forth_sc_user = User.create!(email: 'teste@tressi.com.br', password: 'tressi123', shipping_company: forth_sc)

VolumePrice.create!(initial_volume: 0, final_volume: 0.800, price: 0.90, shipping_company: forth_sc)
VolumePrice.create!(initial_volume: 0.801, final_volume: 1.600, price: 1.70, shipping_company: forth_sc)
VolumePrice.create!(initial_volume: 1.601, final_volume: 2.400, price: 2.45, shipping_company: forth_sc)
VolumePrice.create!(initial_volume: 2.401, final_volume: 3.200, price: 3.10, shipping_company: forth_sc)

WeightPrice.create!(initial_weight: 0, final_weight: 10.00, price: 1.20, shipping_company: forth_sc)
WeightPrice.create!(initial_weight: 10.01, final_weight: 20.00, price: 1.70, shipping_company: forth_sc)
WeightPrice.create!(initial_weight: 20.01, final_weight: 30.00, price: 2.40, shipping_company: forth_sc)
WeightPrice.create!(initial_weight: 30.01, final_weight: 40.00, price: 3.00, shipping_company: forth_sc)

DeliveryTime.create!(initial_distance: 0, final_distance: 300.0, weekdays: 6, shipping_company: forth_sc)
DeliveryTime.create!(initial_distance: 300.1, final_distance: 600.0, weekdays: 10, shipping_company: forth_sc)
DeliveryTime.create!(initial_distance: 600.1, final_distance: 900.0, weekdays: 16, shipping_company: forth_sc)
DeliveryTime.create!(initial_distance: 900.1, final_distance: 1200.0, weekdays: 21, shipping_company: forth_sc)
