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
("Echo Dot (3rd Gen) - Smart speaker with Alexa - Charcoal", 39.99, "Our most popular smart speaker - Now with improved sound and a new design. Ask Alexa for music, news, information, and more.", "echo_dot_3rd_gen.jpg"),
("All-new Fire HD 8 tablet, 8'' HD display, 32 GB, designed for portable entertainment", 89.99, "Enjoy your favorite apps, games, and videos on our most popular tablet - Now with longer battery life and faster performance.", "fire_hd_8_tablet.jpg"),
("Apple Watch Series 6 GPS, 44mm", 399.00, "The future of health is on your wrist - Measure your blood oxygen level, take an ECG, and track your fitness with the new Apple Watch Series 6.", "apple_watch_series_6.jpg"),
("Samsung Galaxy S21 5G Factory Unlocked Android Cell Phone, 128GB, Phantom Gray", 799.99, "Experience the power of 5G with the new Samsung Galaxy S21 - Featuring a pro-grade camera, all-day battery, and a bold new design.", "samsung_galaxy_s21.jpg"),
("Kindle Paperwhite Signature Edition Essentials Bundle", 239.97, "The best Kindle Paperwhite yet - Now with a larger 6.8'' display, adjustable warm light, and wireless charging.", "kindle_paperwhite_signature.jpg"),
("Sony WH-1000XM4 Wireless Industry Leading Noise Canceling Overhead Headphones", 349.99, "The world's best noise canceling headphones - Now with improved sound quality, voice assistant compatibility, and up to 30 hours of battery life.", "default.jpg"),
("Nintendo Switch with Neon Blue and Neon Red Joy-Con", 299.99, "Play your favorite games anytime, anywhere - The Nintendo Switch is the ultimate gaming console for on-the-go fun.", "default.jpg"),
("Bose QuietComfort Earbuds - True Wireless Bluetooth Noise Cancelling Earphones", 279.00, "The world's best noise cancelling earbuds - Featuring unmatched comfort, sound quality, and up to 18 hours of battery life.", "default.jpg"),
("Apple AirPods Pro", 249.00, "Active noise cancellation for immersive sound - Transparency mode for hearing and connecting with the world around you.", "default.jpg"),
("Google Pixelbook Go - Lightweight Chrome Laptop", 649.00, "The lightweight Chromebook that's easy to take anywhere - Featuring a 13.3'' touchscreen, up to 12 hours of battery life, and fast charging.", "default.jpg");

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

create table account (
id int not null auto_increment,
account_password varchar(255) not null,
customer_id int not null,
primary key (id),
foreign key (customer_id) references customer(id)
);

select *, sum(shipment_product.quantity) from product
join shipment_product on shipment_product.product_id = product.id
group by product.id
order by sum(shipment_product.quantity) asc
limit 5;

select * from product
join shipment_product on shipment_product.product_id = product.id;

