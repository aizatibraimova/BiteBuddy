document.addEventListener('DOMContentLoaded', () => {
  const toggleSwitch = document.querySelector('#dark-mode-toggle');
  const darkModeIcon = document.querySelector('#dark-mode-icon');
  const currentTheme = localStorage.getItem('theme');

  if (currentTheme) {
    document.body.classList.add(currentTheme);
    if (currentTheme === 'dark-mode') {
      toggleSwitch.classList.replace('btn-outline-secondary', 'btn-outline-light');
      darkModeIcon.classList.replace('fa-moon', 'fa-sun');
    }
  }

  toggleSwitch.addEventListener('click', () => {
    if (document.body.classList.contains('dark-mode')) {
      document.body.classList.remove('dark-mode');
      toggleSwitch.classList.replace('btn-outline-light', 'btn-outline-secondary');
      darkModeIcon.classList.replace('fa-sun', 'fa-moon');
      localStorage.setItem('theme', 'light-mode');
    } else {
      document.body.classList.add('dark-mode');
      toggleSwitch.classList.replace('btn-outline-secondary', 'btn-outline-light');
      darkModeIcon.classList.replace('fa-moon', 'fa-sun');
      localStorage.setItem('theme', 'dark-mode');
    }
  });
});
