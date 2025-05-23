use visitor_pass;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    address TEXT,
    gender ENUM('Male', 'Female', 'Other'),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user'
);

-----------------------------------------------------------------------------------------------------------------------

CREATE TABLE super_admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

INSERT INTO super_admin (email, password) VALUES ('admin@123', 'admin123');

-------------------------------------------------------------------------------------------------------------------------

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(150) NOT NULL,
    adult_pass_price DECIMAL(10,2) NOT NULL,
    child_pass_price DECIMAL(10,2),
    description TEXT,
    timings TEXT,
    image_url VARCHAR(255),
    pincode VARCHAR(10)
);

INSERT INTO locations (location_name, adult_pass_price, child_pass_price, description, timings, image_url, pincode) VALUES
('Charminar', 20.00, 15.00, 'A historic monument and mosque located in the heart of Hyderabad, India. It is an iconic symbol of the city.', '9:00 am to 5:30 pm [Closed on Friday]', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUWu_9E_lnTJlrv7TfTo4edax94hy1giL5VA&s', '500002'),
('Golconda Fort', 25.00, 15.00, 'A grand fort that once served as the capital of medieval Golconda Sultanate, offering stunning views and historical architecture.', '8:00 am to 5:30 pm',  'https://a.travel-assets.com/findyours-php/viewfinder/images/res40/68000/68318-Golconda-Fort.jpg', '500008'),
('Chowmahalla Palace', 100.00, 40.00, 'A royal palace once home to the Nizams of Hyderabad, with beautiful courtyards, gardens, and exquisite antique furniture.', '10:00 am to 5:00 pm [Closed on Friday]', 'https://static.toiimg.com/photo/58458206.cms', '500002'),
('Birla Science Museum', 150.00, 150.00, 'A museum and science center that showcases a variety of exhibits related to science, technology, and astronomy.', '10:30 am to 8:00 pm', 'https://lh3.googleusercontent.com/ci/AL18g_SBg5GO6g_gEKIt0Qp21-jwi2lKh51PIhb3tfS5uA7fDbPekjMO4qIdc-Ym10pdIUN1N1MUsYw=s1200', '500034'),
('Salar Jung Museum', 20.00, 10.00, 'One of the three National Museums of India, housing an impressive collection of art, sculptures, and manuscripts.', '10:00 am to 5:00 pm [Closed on Friday]', 'https://upload.wikimedia.org/wikipedia/commons/a/ac/Salar_Jung_Museum%2C_Hyderabad%2C_India.jpg', '500001'),
('Nizam''s Museum', 100.00, 15.00, 'A museum dedicated to the Nizams of Hyderabad, featuring artifacts, costumes, and the famous Nizam’s jewels.', '10:00 am to 5:00 pm [Closed on Fridays]', 'https://hyderabadtourpackage.in/images/places-to-visit/nizam-s-museum-hyderabad-entryfee-timings-tour-package-header.jpg', '500002'),
('Ramoji Film City', 1150.00, 950.00, 'A film studio complex and theme park, known as one of the largest of its kind in the world, with exciting rides and sets for movies.', '9:00 am to 8:00 pm', 'https://hyderabadtourpackage.in/images/places-to-visit/ramoji-film-city-hyderabad-entryfee-timings-tour-package-header.jpg', '501512'),
('Purani Haveli', 80.00, 15.00, 'A historical palace that was once the residence of the Nizam of Hyderabad, now a museum showcasing the life and times of the Nizam.', ' 10:00 am to 5:00 pm [Closed on Friday]', 'https://www.indiatourismguide.in/wp-content/uploads/2017/11/Purani-Haveli.jpg', '500065'),
('Snow World', 650.00, 500.00, 'An indoor snow-themed amusement park, offering activities such as snowball fights, ice skating, and snow slides.', '11:00 am to 9:00 pm', 'https://hyderabadtourpackage.in/images/places-to-visit/snow-world-hyderabad-entryfee-timings-tour-package-header.jpg', '500062'),
('Shilparamam', 60.00, 20.00, 'An arts and crafts village showcasing the traditional culture and arts of India, with various cultural performances and handicrafts.', '10:30 am to 8:30 pm', 'https://telanganatourism.gov.in/assets/images/destinations/shopping/shilparamam/therecreationalarea.jpg', '500075'),
('Mount Opera', 425.00, 300.00, 'A popular amusement park located near the city, featuring thrilling rides, water park, and a variety of entertainment options.', '11:00 am to 6:00 pm [Mon - Fri] & 10:00 pm to 7:00 pm [Sat & Sun]', 'https://hyderabadtourpackage.in/images/places-to-visit/mount-opera-hyderabad-entryfee-timings-tour-package-header.jpg', '500030'),
('Ocean Park', 650.00, 500.00, 'A water park with numerous water slides, wave pools, and other aquatic attractions, perfect for a fun family day out.', '11:00 am to 7:30 pm', 'https://media.istockphoto.com/id/458092949/photo/ocean-park-hong-kong.jpg?s=612x612&w=0&k=20&c=fm-sFNW0-2myHCghc3LjiCaJ5GIlClcs7HgksWiyd8M=', '500062');

------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE bookings (
    bookings_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    number_of_adults INT NOT NULL,
    number_of_childs INT DEFAULT 0,
    total_price DECIMAL(10,2) NOT NULL,
    visit_date DATE NOT NULL,		-- local date time
    status ENUM('confirmed', 'pending', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

--------------------------------------------------------------------------------------------

CREATE TABLE managers (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);


INSERT INTO managers (name, email, password, location_id) VALUES
('Manager 1', 'manager1@location.com', '0000', 1),
('Manager 2', 'manager2@location.com', '0000', 2),
('Manager 3', 'manager3@location.com', '0000', 3),
('Manager 4', 'manager4@location.com', '0000', 4),
('Manager 5', 'manager5@location.com', '0000', 5),
('Manager 6', 'manager6@location.com', '0000', 6),
('Manager 7', 'manager7@location.com', '0000', 7),
('Manager 8', 'manager8@location.com', '0000', 8),
('Manager 9', 'manager9@location.com', '0000', 9),
('Manager 10', 'manager10@location.com', '0000', 10),
('Manager 11', 'manager11@location.com', '0000', 11),
('Manager 12', 'manager12@location.com', '0000', 12);

--------------------------------------------------------------------------------------------------

CREATE TABLE feedbacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    email VARCHAR(100) NOT NULL,
	location_id INT,
    description TEXT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

----------------------------------------------------------------------------------------------------


