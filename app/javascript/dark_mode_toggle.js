// dark_mode_toggle.js

document.addEventListener('DOMContentLoaded', function() {
  const darkModeToggle = document.getElementById('dark-mode-toggle');
  const darkModeIcon = document.getElementById('dark-mode-icon');
  const body = document.body;

  // Initialize tooltips
  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });

  if (darkModeToggle) {
    darkModeToggle.addEventListener('click', function() {
      body.classList.toggle('dark-mode');
      body.classList.toggle('light-mode');

      const isDarkMode = body.classList.contains('dark-mode');
      darkModeIcon.classList.toggle('fa-moon', !isDarkMode);
      darkModeIcon.classList.toggle('fa-sun', isDarkMode);

      // Optionally, store the user's preference in the session or local storage
      if (isDarkMode) {
        sessionStorage.setItem('dark_mode', 'enabled');
      } else {
        sessionStorage.setItem('dark_mode', 'disabled');
      }
    });

    // Set the initial mode based on the stored preference
    const darkModeSetting = sessionStorage.getItem('dark_mode');
    if (darkModeSetting === 'enabled') {
      body.classList.add('dark-mode');
      body.classList.remove('light-mode');
      darkModeIcon.classList.remove('fa-moon');
      darkModeIcon.classList.add('fa-sun');
    } else {
      body.classList.add('light-mode');
      body.classList.remove('dark-mode');
      darkModeIcon.classList.remove('fa-sun');
      darkModeIcon.classList.add('fa-moon');
    }
  }
});
