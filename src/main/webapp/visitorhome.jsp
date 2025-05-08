<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visitor Home Page</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/25/25694.png" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            color: #333;
        }

        /* Navbar Style (Copied from submitFeedback.jsp) */
        .navbar {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 25px 40px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            min-height: 80px;
            margin-bottom: 20px;
        }

        .navbar .left {
            font-size: 26px;
            font-weight: bold;
            color: white;
        }

        .navbar .right {
            display: flex;
            gap: 18px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            font-weight: 500;
            font-size: 18px;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .navbar .logout {
            background-color: #e74c3c;
            font-weight: bold;
        }

        .navbar .logout:hover {
            background-color: #c0392b;
        }

        .img-custom {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<!-- Custom Navbar (Matches submitFeedback.jsp style) -->
<div class="navbar">
    <div class="left">
        Visitors Entry Pass Management System
    </div>
    <div class="right">
        <a href="visitorhome.jsp">Home</a>
        <a href="locations">Book Pass</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="submitFeedback">Give Feedback</a>
        <a href="profile">Profile</a>
        <a href="LogoutServlet" class="logout">Logout</a>
    </div>
</div>

<!-- Header Section -->
<header class="bg-primary text-white text-center py-5">
    <h1>Explore Amazing Locations</h1>
    <p>Click on any image to view the location on the map.</p>
</header>

<!-- Locations Section -->
<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-3 g-4">

        <!-- Charminar -->
        <div class="col">
            <div class="card">
                <a href="https://www.google.com/maps?q=Charminar,Hyderabad" target="_blank">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUWu_9E_lnTJlrv7TfTo4edax94hy1giL5VA&s" class="card-img-top img-custom" alt="Charminar">
                </a>
                <div class="card-body">
                    <h5 class="card-title">Charminar</h5>
                    <p class="card-text">A historic mosque and landmark of Hyderabad, India.</p>
                </div>
            </div>
        </div>

        <!-- Golconda Fort -->
        <div class="col">
            <div class="card">
                <a href="https://www.google.com/maps?q=Golconda+Fort,Hyderabad" target="_blank">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ158o6mjArg9sFzRWsiZAVBgIs20TKD8QwGA&s" class="card-img-top img-custom" alt="Golconda Fort">
                </a>
                <div class="card-body">
                    <h5 class="card-title">Golconda Fort</h5>
                    <p class="card-text">A majestic fortress with rich history and architecture.</p>
                </div>
            </div>
        </div>

           <!-- Chowmahalla Palace -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Chowmahalla+Palace,Hyderabad" target="_blank">
                        <img src="https://static.toiimg.com/photo/58458206.cms" class="card-img-top img-custom" alt="Chowmahalla Palace">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Chowmahalla Palace</h5>
                        <p class="card-text">The seat of the Nizams of Hyderabad, showcasing royal grandeur.</p>
                    </div>
                </div>
            </div>

		<!-- Birla Science Museum -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Birla+Science+Museum,Hyderabad" target="_blank">
                        <img src="https://lh3.googleusercontent.com/ci/AL18g_SBg5GO6g_gEKIt0Qp21-jwi2lKh51PIhb3tfS5uA7fDbPekjMO4qIdc-Ym10pdIUN1N1MUsYw=s1200" class="card-img-top img-custom" alt="Birla Science Museum">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Birla Science Museum</h5>
                        <p class="card-text">A museum offering interactive science exhibits and a planetarium.</p>
                    </div>
                </div>
            </div>

            <!-- Salar Jung Museum -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Salar+Jung+Museum,Hyderabad" target="_blank">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/a/ac/Salar_Jung_Museum%2C_Hyderabad%2C_India.jpg" class="card-img-top img-custom" alt="Salar Jung Museum">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Salar Jung Museum</h5>
                        <p class="card-text">One of the largest art museums in India, housing a vast collection of artifacts.</p>
                    </div>
                </div>
            </div>

            <!-- Nizam's Museum -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Nizam%27s+Museum,Hyderabad" target="_blank">
                        <img src="https://hyderabadtourpackage.in/images/places-to-visit/nizam-s-museum-hyderabad-entryfee-timings-tour-package-header.jpg" class="card-img-top img-custom" alt="Nizam's Museum">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Nizam's Museum</h5>
                        <p class="card-text">A museum dedicated to the artifacts of the Nizams of Hyderabad.</p>
                    </div>
                </div>
            </div>

            <!-- Ramoji Film City -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Ramoji+Film+City,Hyderabad" target="_blank">
                        <img src="https://hyderabadtourpackage.in/images/places-to-visit/ramoji-film-city-hyderabad-entryfee-timings-tour-package-header.jpg" class="card-img-top img-custom" alt="Ramoji Film City">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Ramoji Film City</h5>
                        <p class="card-text">One of the largest film studio complexes in the world.</p>
                    </div>
                </div>
            </div>

            <!-- Purani Haveli -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Purani+Haveli,Hyderabad" target="_blank">
                        <img src="https://www.indiatourismguide.in/wp-content/uploads/2017/11/Purani-Haveli.jpg" class="card-img-top img-custom" alt="Purani Haveli">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Purani Haveli</h5>
                        <p class="card-text">A historical haveli known for its unique architecture.</p>
                    </div>
                </div>
            </div>

            <!-- Snow World -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Snow+World,Hyderabad" target="_blank">
                        <img src="https://hyderabadtourpackage.in/images/places-to-visit/snow-world-hyderabad-entryfee-timings-tour-package-header.jpg" class="card-img-top img-custom" alt="Snow World">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Snow World</h5>
                        <p class="card-text">An indoor snow theme park in Hyderabad offering chilly fun.</p>
                    </div>
                </div>
            </div>

            <!-- Shilparamam -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Shilparamam,Hyderabad" target="_blank">
                        <img src="https://telanganatourism.gov.in/assets/images/destinations/shopping/shilparamam/therecreationalarea.jpg" class="card-img-top img-custom" alt="Shilparamam">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Shilparamam</h5>
                        <p class="card-text">An arts and crafts village showcasing Indian culture and heritage.</p>
                    </div>
                </div>
            </div>

            <!-- Mount Opera -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Mount+Opera,Hyderabad" target="_blank">
                        <img src="https://hyderabadtourpackage.in/images/places-to-visit/mount-opera-hyderabad-entryfee-timings-tour-package-header.jpg" class="card-img-top img-custom" alt="Mount Opera">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Mount Opera</h5>
                        <p class="card-text">A theme park offering a variety of rides and entertainment.</p>
                    </div>
                </div>
            </div>

            <!-- Ocean Park -->
            <div class="col">
                <div class="card">
                    <a href="https://www.google.com/maps?q=Ocean+Park,Hyderabad" target="_blank">
                        <img src="https://media.istockphoto.com/id/458092949/photo/ocean-park-hong-kong.jpg?s=612x612&w=0&k=20&c=fm-sFNW0-2myHCghc3LjiCaJ5GIlClcs7HgksWiyd8M=" class="card-img-top img-custom" alt="Ocean Park">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Ocean Park</h5>
                        <p class="card-text">A water theme park with thrilling water rides and slides.</p>
                    </div>
                </div>
            </div>
		
		
		
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
