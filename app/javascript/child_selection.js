document.addEventListener('DOMContentLoaded', function() {
  const goToChildDetailsButton = document.getElementById('goToChildDetails');
  const childSelect = document.getElementById('childSelect');

  goToChildDetailsButton.addEventListener('click', function(event) {
    event.preventDefault();
    const selectedChildId = childSelect.value;
    if (selectedChildId) {
      fetch(`/select_child`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ child_id: selectedChildId })
      }).then(response => {
        if (response.ok) {
          window.location.href = `/children/${selectedChildId}/details`;
        } else {
          alert('Failed to select child.');
        }
      });
    }
  });
});
