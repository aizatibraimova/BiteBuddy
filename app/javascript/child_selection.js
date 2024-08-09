document.addEventListener('DOMContentLoaded', function() {
  const goToChildDetailsButton = document.getElementById('goToChildDetails');
  const childSelect = document.getElementById('childSelect');

  goToChildDetailsButton.addEventListener('click', function(event) {
    event.preventDefault();
    const selectedChildId = childSelect.value;
    if (selectedChildId) {
      window.location.href = `/children/${selectedChildId}/details`;
    }
  });
});
