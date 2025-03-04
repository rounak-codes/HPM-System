<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="homeNavbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Hospital Management</title>
  <style>
    * {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-color: #f4f7fc;
      color: #2c3e50;
      display: flex;
      flex-direction: column;
      align-items: center;
      min-height: 100vh;
      position: relative;
      text-align: center;
    }

    body::before {
      content: "";
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url("images/Hospital.jpg");
      background-size: cover;
      background-position: center;
      z-index: -1;
      opacity: 0.6;
      filter: blur(3px);
    }

    h1 {
      font-size: 3rem;
      color: #1f618d;
      margin: 20px 0;
      text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
    }

    h2 {
      font-size: 2rem;
      color: #34495e;
      margin-bottom: 20px; /* Add margin below What We Do heading */
    }

	/* Slideshow Styles */
	.slideshow {
	  width: 60%;
	  max-width: 600px;
	  height: 400px;
	  margin: 30px auto;
	  position: relative;
	  overflow: hidden;
	  border-radius: 15px;
	  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
	}
	
	.slideshow img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	  position: absolute;
	  left: 0;
	  top: 0;
	  opacity: 0;
	  transition: opacity 1s ease;
	}

    .slideshow img.active {
      opacity: 1;
    }

    /* Login Section */
    .loginOpt {
      width: 60%;
      background-color: rgba(255, 255, 255, 0.9);
      padding: 20px;
      margin-top: 20px;
      margin-bottom: 20px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      text-align: center; /* Center-align login text */
    }

    .loginOpt h3 {
      color: #1f618d;
      margin-bottom: 15px;
      font-size: 1.4rem;
    }

    .loginOpt p {
      margin: 10px 0;
      font-size: 1.1rem;
      font-weight: 600;
      color: #34495e;
    }

    .loginOpt a {
      text-decoration: none;
    }

    .loginOpt button {
      background-color: #1abc9c;
      color: #fff;
      padding: 10px 20px;
      border: none;
      cursor: pointer;
      font-size: 1rem;
      font-weight: 600;
      border-radius: 8px;
      margin: 5px;
      transition: background-color 0.3s ease, transform 0.2s ease;
      display: inline-block;
    }

    .loginOpt button:hover {
      background-color: #16a085;
      transform: translateY(-3px);
    }

    /* Placeholder Content */
    .hospitalText {
      width: 60%;
      margin-top: 20px;
      font-size: 1.1rem;
      color: #34495e;
      line-height: 1.8;
    }

    @media (max-width: 768px) {
      .slideshow, .loginOpt, .hospitalText {
        width: 90%;
      }

      .slideshow {
        height: 250px;
      }
    }
  </style>
</head>
<body>
  <h1>Welcome to our Hospital Portal</h1>
  <h2>What We Do</h2>
  <div class="hospitalText">
    <p>
      Our hospital is committed to providing exceptional care and advanced medical services. 
      Equipped with state-of-the-art facilities and a dedicated team of medical professionals, 
      we ensure that our patients receive comprehensive and compassionate treatment. 
      Your health is our top priority.
    </p>
  </div>

  <!-- Slideshow -->
  <div class="slideshow">
    <img src="images/Hospital2.jpg" alt="Doctors" class="active" />
    <img src="images/DocPatient2.jpg" alt="Doctors and Patient" />
    <img src="images/DoctorsTeam.jpg" alt="Doctors Team" />
    <img src="images/DocPatient3.jpg" alt="Doctors and Patient" />
    <img src="images/DocPatient4.jpeg" alt="Doctors and Patient" />
    <img src="images/DoctorsTeam2.jpg" alt="Doctors Team" />
  </div>

  <!-- Login Options -->
  <div class="loginOpt">
    <h3>Login Options</h3>
    <p>Are you a patient? <a href="patientLogin.jsp"><button>Login Here</button></a></p>
    <p>Are you a doctor? <a href="doctorLogin.jsp"><button>Login Here</button></a></p>
    <p>Are you an administrator? <a href="adminLogin.jsp"><button>Login Here</button></a></p>
  </div>

  <!-- Slideshow Script -->
  <script>
    let currentIndex = 0;
    const slides = document.querySelectorAll('.slideshow img');

    function showSlide(index) {
      slides.forEach((slide, i) => {
        slide.classList.remove('active');
        if (i === index) {
          slide.classList.add('active');
        }
      });
    }

    function nextSlide() {
      currentIndex = (currentIndex + 1) % slides.length;
      showSlide(currentIndex);
    }

    setInterval(nextSlide, 3000);
  </script>
</body>
</html>
