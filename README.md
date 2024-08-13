# BiteBuddy

BiteBuddy is a platform designed to help caregivers log their child's meals and reactions to monitor and identify potential food allergies. The platform provides tools for tracking, analyzing, and managing allergies to ensure the safety and well-being of infants and toddlers.

## Project Overview

BiteBuddy is built to assist parents and caregivers in monitoring their children's dietary habits, especially during the early years when food allergies are most likely to develop. The application logs meals, tracks allergic reactions, and uses AI-driven analysis to identify potential food-related allergens.

### Features

- **Meal Logging:** Caregivers can log meals and associated reactions.
- **Allergy Tracking:** Track and monitor potential food allergies.
- **AI-Driven Analysis:** Analyze patterns between food intake and allergic reactions.

## Technologies Used

- **Ruby on Rails:** Back-end framework for web development.
- **Bootstrap:** Front-end framework for responsive design.
- **Faker:** Gem for generating sample data.
- **Devise:** Authentication solution for Rails.
- **OpenAI:** Used for AI-driven analysis of food and allergy data.

## Installation

To set up BiteBuddy on your local machine, follow these steps:

1. **Clone the repository:**
    ```bash
    git clone https://github.com/aizatibraimova/BiteBuddy.git
    ```

2. **Navigate to the project directory:**
    ```bash
    cd BiteBuddy
    ```

3. **Install dependencies:**
    ```bash
    bundle install
    ```

4. **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

5. **Seed the database with sample data:**
    ```bash
    rails db:seed
    ```

6. **Run the application:**
    ```bash
    rails server
    ```

7. **Open your browser and navigate to:**
    ```bash
    http://localhost:3000
    ```

## Usage

Once the application is running, you can use BiteBuddy to manage and track your child's meals and allergies.

### Key Sections:

- **Navigation:** Use the navigation bar to access different sections like Meals, Allergies, and Analyses.
- **Logging Meals:** Log meals, including the type of food, quantity, and time.
- **Tracking Allergies:** Enter and monitor allergic reactions, including symptoms and severity.
- **Viewing Analyses:** Get AI-driven analysis of logged meals and allergic reactions to identify patterns.

## Database

The database schema includes tables for `Users`, `Children`, `Foods`, `Meals`, and `Allergies`. Each table is connected through appropriate associations, ensuring the integrity and relationships of the data.

### Key Tables:

- **Users:** Stores user credentials and profiles.
- **Children:** Information about the children being monitored.
- **Foods:** Catalog of foods consumed by the children.
- **Meals:** Logs of meals including the food, quantity, and time.
- **Allergies:** Records of allergic reactions with symptoms and severity.

## Seeding the Database

To populate your local database with sample data, run:

```bash
rails db:seed
```

### Contributing
1. Fork the repository 
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a Pull Request.
