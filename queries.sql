-- Query 1:
-- Requireemnt: Retrieve booking information along with Customer name and Vehicle name.

select b.booking_id, u.name as customer_name, v.name as vehicle_name, start_date, end_date, b.status  from users as u
inner join bookings as b on b.user_id = u.user_id
inner join vehicles as  v on v.vehicle_id = b.vehicle_id;



-- Query 2:
-- Requirement: Find all vehicles that have never been booked.

select * from vehicles
where not exists (
  select vehicle_id from bookings
  where vehicle_id = vehicles.vehicle_id
);


-- Query 3:
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).

select * from vehicles
where status = 'available' and type = 'car';


-- Query 4:
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

select v.name as vehicle_name, count(*) as total_bookings from bookings as b
inner join vehicles as v on v.vehicle_id = b.vehicle_id
group by vehicle_name
having count(*) > 2;

