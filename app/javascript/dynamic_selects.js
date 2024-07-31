document.addEventListener('turbo:load', function() {
  const timeFrameSelect = document.getElementById('time_frame_select');
  
  if (timeFrameSelect) {
    timeFrameSelect.addEventListener('change', function() {
      const timeFrame = this.value;
      const childId = this.dataset.childId;

      fetch(`/children/${childId}/fetch_meals_and_allergies?time_frame=${timeFrame}`, {
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        const dataDiv = document.getElementById('meals_and_allergies_data');

        let mealsContent = '<h3>Meals</h3>';
        data.meals.forEach(meal => {
          mealsContent += `<p>Food: ${meal.food_name} - Date: ${meal.date}</p>`;
        });

        let allergiesContent = '<h3>Allergies</h3>';
        data.allergies.forEach(allergy => {
          allergiesContent += `<p>Reaction: ${allergy.description} - Date: ${allergy.detected_date}</p>`;
        });

        dataDiv.innerHTML = mealsContent + allergiesContent;
      });
    });
  }
});
