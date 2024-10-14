drop database if exists web_shop;

create database web_shop;

use web_shop;

create table web_shop.product (
id int not null auto_increment,
product_name varchar(255) not null,
price decimal(10,2) not null,
description varchar(255) not null,
image_path varchar(255) null default 'default.jpg',
primary key (id)
);

INSERT INTO web_shop.product (product_name, price, description, image_path) VALUES
("Echo Dot (3rd Gen)", 39.99, "Our most popular smart speaker with improved sound. Ask Alexa for music, news, and more.", "echo_dot_3rd_gen.jpg"),
("Fire HD 8 Tablet", 89.99, "Enjoy apps, games, and videos on our most popular tablet with longer battery life.", "fire_hd_8_tablet.jpg"),
("Apple Watch Series 6", 399.00, "Measure blood oxygen, take ECG, and track fitness with the new Apple Watch.", "apple_watch_series_6.jpg"),
("Samsung Galaxy S21 5G", 799.99, "Experience 5G power with a pro-grade camera and all-day battery.", "samsung_galaxy_s21.jpg"),
("Kindle Paperwhite Signature", 239.97, "The best Kindle yet with a larger display, adjustable warm light, and wireless charging.", "kindle_paperwhite_signature.jpg"),
("Sony WH-1000XM4 Headphones", 349.99, "Industry-leading noise canceling headphones with improved sound and 30 hours of battery.", "default.jpg"),
("Nintendo Switch", 299.99, "Play games anytime, anywhere with the ultimate on-the-go gaming console.", "default.jpg"),
("Bose QuietComfort Earbuds", 279.00, "Best noise cancelling earbuds with unmatched comfort and 18 hours of battery.", "default.jpg"),
("Apple AirPods Pro", 249.00, "Active noise cancellation and transparency mode for immersive sound.", "default.jpg"),
("Google Pixelbook Go", 649.00, "Lightweight Chromebook with a 13.3'' touchscreen and up to 12 hours of battery.", "default.jpg");
create table web_shop.product_property (
id int not null auto_increment,
product_id int not null,
property_key varchar(255) not null,
property_value varchar(255) not null,
primary key (id),
foreign key (product_id) references product(id)
);

INSERT INTO web_shop.product_property (product_id, property_key, property_value) VALUES
(1, 'brand', 'Amazon'),
(1, 'color', 'Charcoal'),
(2, 'brand', 'Amazon'),
(2, 'screen_size', '8'''),
(3, 'brand', 'Apple'),
(3, 'size', '44mm'),
(4, 'brand', 'Samsung'),
(4, 'storage', '128GB'),
(5, 'brand', 'Amazon'),
(5, 'waterproof', 'Yes'),
(6, 'brand', 'Sony'),
(6, 'battery_life', '30 hours'),
(7, 'brand', 'Nintendo'),
(7, 'type', 'Hybrid'),
(8, 'brand', 'Bose'),
(8, 'noise_canceling', 'Yes'),
(9, 'brand', 'Apple'),
(9, 'wireless_charging', 'Yes'),
(10, 'brand', 'Google'),
(10, 'os', 'Chrome OS');

create table web_shop.address (
id int not null auto_increment,
first_name varchar(255) not null,
last_name varchar(255) not null,
street varchar(255) not null,
city varchar(255) not null,
country varchar(255) not null,
postal_code int not null,
primary key (id)
);

INSERT INTO web_shop.address (first_name, last_name, street, city, country, postal_code)
VALUES 
('Max', 'Mustermann', 'Mariahilfer Straße 1', 'Wien', 'Austria', 1010),
('Erika', 'Musterfrau', 'Hauptplatz 1', 'Graz', 'Austria', 8010),
('Hans', 'Mustermann', 'Landstraße 1', 'Linz', 'Austria', 4010),
('Franz', 'Muster', 'Alter Markt 1', 'Salzburg', 'Austria', 5010),
('Maria', 'Musterfrau', 'Maria-Theresien-Straße 1', 'Innsbruck', 'Austria', 6010),
('Johann', 'Muster', 'Viktor-Frankl-Platz 1', 'Klagenfurt', 'Austria', 9010),
('Barbara', 'Musterfrau', 'Schottenring 1', 'Wien', 'Austria', 1010),
('Karl', 'Muster', 'Herrengasse 1', 'Graz', 'Austria', 8010),
('Helene', 'Musterfrau', 'Taubenmarkt 1', 'Linz', 'Austria', 4010),
('Stefan', 'Muster', 'Rudolfskai 1', 'Salzburg', 'Austria', 5010);


create table web_shop.customer (
id int not null auto_increment,
email varchar(255) not null,
phone_number varchar(255) not null,
billing_address int not null,
primary key (id),
foreign key (billing_address) references web_shop.address(id)
);

INSERT INTO web_shop.customer (email, phone_number, billing_address)
VALUES 
('max.mustermann@example.com', '+43 1 1234567', 1),
('erika.musterfrau@example.com', '+43 664 1234567', 2),
('hans.mustermann@example.com', '+43 732 1234567', 3),
('franz.muster@example.com', '+43 662 1234567', 4),
('maria.musterfrau@example.com', '+43 512 1234567', 5),
('johann.muster@example.com', '+43 463 1234567', 6),
('barbara.musterfrau@example.com', '+43 1 1234567', 7),
('karl.muster@example.com', '+43 316 1234567', 8),
('helene.musterfrau@example.com', '+43 732 1234567', 9),
('stefan.muster@example.com', '+43 662 1234567', 10);

create table web_shop.shipment (
id int not null auto_increment,
shipping_address int not null,
customer_id int not null,
shipment_date timestamp default CURRENT_TIMESTAMP,
primary key (id),
foreign key (shipping_address) references address(id),
foreign key (customer_id) references customer(id)
);

insert into shipment (shipping_address, customer_id)
values
(1, 1),
(2, 2),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

select * from shipment;

create table shipment_product (
id int not null auto_increment,
shipment_id int not null,
product_id int not null,
quantity int not null,
primary key (id),
foreign key (shipment_id) references shipment(id),
foreign key (product_id) references product(id)
);

insert into shipment_product (shipment_id, product_id, quantity)
values
(1, 1, 1),
(1, 2, 3),
(2, 1, 2),
(2, 4, 1),
(3, 5, 6),
(4, 9, 10),
(5, 8, 4),
(6, 6, 6);

select * from shiproduct_idpment_product;

create table account (
id int not null auto_increment,
account_password varchar(255) not null,
customer_id int not null,
primary key (id),
foreign key (customer_id) references customer(id)
);

select *, coalesce(sum(shipment_product.quantity), 0) from product
left join shipment_product on shipment_product.product_id = product.id
group by product.id
order by sum(shipment_product.quantity) asc;

select * from product
join shipment_product on shipment_product.product_id = product.id;

select * from product_statistic_result;