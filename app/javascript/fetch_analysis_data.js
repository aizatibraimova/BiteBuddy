document.addEventListener('turbo:load', function() {
  const timeFrameSelect = document.getElementById('time_frame_select');
  
  if (timeFrameSelect) {
    timeFrameSelect.addEventListener('change', function() {
      const timeFrame = this.value;
      const childId = this.dataset.childId;

      fetch(`/children/${childId}/analyses/fetch_meals_and_allergies?time_frame=${timeFrame}`, {
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        const findingsField = document.querySelector('input[name="analysis[findings]"]');
        const recommendationsField = document.querySelector('textarea[name="analysis[recommendations]"]');
        const mealIdField = document.querySelector('input[name="analysis[meal_id]"]');
        const dateField = document.querySelector('input[name="analysis[date]"]');
        const allergyIdField = document.querySelector('input[name="analysis[allergy_id]"]');
        const dataDiv = document.getElementById('meals_and_allergies_data');

        let mealsContent = '<h3>Meals</h3>';
        data.meals.forEach(meal => {
          mealsContent += `<p>Food: ${meal.food_name} - Date: ${meal.date} - Notes: ${meal.notes}</p>`;
          mealIdField.value = meal.id; 
          dateField.value = meal.date;
        });

        let allergiesContent = '<h3>Allergies</h3>';
        data.allergies.forEach(allergy => {
          allergiesContent += `<p>Reaction: ${allergy.description} - Date: ${allergy.detected_date} - Notes: ${allergy.notes}</p>`;
          allergyIdField.value = allergy.id;
        });

        let analysisContent = `<h3>Analysis</h3><p>Findings: ${data.findings}</p><p>Recommendations: ${data.recommendations}</p>`;

        findingsField.value = data.findings;
        recommendationsField.value = data.recommendations;
        dataDiv.innerHTML = mealsContent + allergiesContent + analysisContent;
      });
    });
  }
});
