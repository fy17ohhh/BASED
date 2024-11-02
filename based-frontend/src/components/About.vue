<template>
  <div class="about-container">
    <section class="about-section">
      <h2>ABOUT THE PROJECT</h2>
      <p>
        The aim of the project is to develop a web-based application that can
        detect and assess the bias in speech data. As speech data is
        increasingly used in various fields including Speech To Text(STT), and
        Automatic Speech Recognition(ASR), it is crucial to gain a comprehensive
        understanding of the data. Since models tend to favor the most common
        answers in their training data, analyzing data bias will provide
        valuable insights for developers.
      </p>
      <p>
        Depending on the nature of the data and the types of bias examined,
        approaches including metadata analysis and machine learning
        methodologies, will be implemented. The project focuses on uncovering
        potential bias related to factors such as gender, age, language,
        geographic region, accent, and emotion. BASED will automate the entire
        process, incorporating various bias detection tools developed in the
        initial stages and employing diverse visualization techniques to present
        the results.
      </p>
    </section>

    <section class="about-section">
      <h2>ABOUT ME</h2>
      <p>
        Currently a final year undergraduate student at National University of
        Singapore, with a primary major in data science and analytics and a
        second major in computer science.
      </p>
      <p>
        Feel free to reach out to me via email or connect with me on GitHub and
        LinkedIn. I am always open to discussing new ideas and opportunities.
      </p>
      <div class="contact-info">
        <div class="email-info">
          <a href="mailto:feiyang.shang@u.nus.edu">
            <font-awesome-icon
              icon="fa-regular fa-envelope"
              color="#001a72"
              size="lg"
            />
          </a>
          <div class="email">feiyang.shang@u.nus.edu</div>
        </div>
        <div class="social-icons">
          <a href="https://github.com/fy17ohhh">
            <font-awesome-icon icon="fa-brands fa-github" color="#001a72" />
          </a>
          <a href="https://www.linkedin.com/in/feiyang-shang/">
            <font-awesome-icon icon="fa-brands fa-linkedin" color="#001a72" />
          </a>
        </div>
      </div>
    </section>

    <section class="about-section">
      <h2>ACKNOWLEDGEMENT</h2>
      <p>
        I would like to express my gratitude to my supervisor, Professor Markus
        Kirchberg, for his guidance and support throughout the project. I would
        also like to thank my families and friends for their encouragement and
        motivation.
      </p>
      <p>
        I've learned a lot from this project and I am grateful for the
        opportunity to work on such an interesting and challenging project to
        conclude my undergraduate study experience.
      </p>
    </section>
  </div>
</template>

<script setup></script>

<style scoped>
.about-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  color: #6f7cb2;
  text-align: left;
}

.about-section {
  margin-top: 20px;
  margin-bottom: 60px;
}

h2 {
  font-family: "Roboto-Bold";
  font-size: 30px;
  color: #2c3e50;
  margin-bottom: 20px;
}

p {
  font-size: 18px;
  line-height: 1.5;
  color: #6f7cb2;
  margin-bottom: 20px;
}

.contact-info {
  font-family: "Roboto-Bold";
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
  margin-bottom: 20px;
}

.email-info {
  display: flex;
  align-items: center;
}

.email {
  font-size: 16px;
  color: #001a72;
  text-decoration: none;
  margin-left: 20px;
  text-align: center;
}

.social-icons {
  display: flex;
  gap: 15px;
}

.social-icons a {
  font-size: 24px;
  color: #001a72;
}
</style>
