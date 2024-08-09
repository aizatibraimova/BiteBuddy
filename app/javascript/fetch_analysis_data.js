document.addEventListener("DOMContentLoaded", function() {
  const timeFrameSelect = document.getElementById("time_frame_select");

  if (timeFrameSelect) {
    timeFrameSelect.addEventListener("change", function() {
      const childId = timeFrameSelect.getAttribute("data-child-id");
      const timeFrame = timeFrameSelect.value;

      if (timeFrame) {
        fetch(`/children/${childId}/analyses/fetch_meals_and_allergies?start_date=${startDate}&end_date=${endDate}`)
          .then(response => response.json())
          .then(data => {
            const dataDiv = document.getElementById("meals_and_allergies_data");
            dataDiv.innerHTML = ""; // Clear previous data

            data.meals.forEach(meal => {
              const mealDiv = document.createElement("div");
              mealDiv.className = "meal";
              mealDiv.textContent = `Meal: ${meal.name}`;
              dataDiv.appendChild(mealDiv);
            });

            data.allergies.forEach(allergy => {
              const allergyDiv = document.createElement("div");
              allergyDiv.className = "allergy";
              allergyDiv.textContent = `Allergy: ${allergy.name}`;
              dataDiv.appendChild(allergyDiv);
            });

            document.getElementById("analysis_meal_id").value = data.selected_meal_id;
            document.getElementById("analysis_allergy_id").value = data.selected_allergy_id;
            document.getElementById("analysis_date").value = new Date().toISOString().split('T')[0];
          })
          .catch(error => console.error('Error fetching data:', error));
      }
    });
  }
});
