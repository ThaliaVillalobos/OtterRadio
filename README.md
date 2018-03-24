# OtterRadio

**OtterRadio** is a radio station that is boadcast from the California State University, Monterey Bay.

## User Stories

The following **required** functionality is completed:

- [ ] User can see the list of recipes
- [ ] User can search recipes based on specific ingredients
- [ ] User can search recipes based on name of dish
- [ ] User can tap a recipe for cooking instructions

The following **Optional** features are implemented:

- [ ] User can sign up to create a new account using Parse authentication
- [ ] User can log in and log out of his or her account
- [ ] The current signed in user is persisted across app restarts
- [ ] The user can see a video demostrating the cooking proccess
- [ ] The user can see a list of recomended recipes
- [ ] The user can save recipes to favorites
- [ ] The user can share recipes with other users
- [ ] The user can see a drink recipe section
- [ ] The user can filter recipes by time, difficulty, and steps

## Considerations
- What is your product pitch?
   * Have you even been so hungry but once you look in your fridge you can't think of anything to make. FeedMe will take in the ingredients you currently have and searches for recipes with those specfic ingredients. 
- Who are the key stakeholders for this app?
   * Our app is will help those who have a strict budget to follow who cannot waste any money. 
- What are the core flows? 
    * The key functionality of our app is going to be searching, filtering, and displaying recipes.  For now, the user will be able to see   two screens. The first screen will display a list of recipes along with a search bar on top. As for the second screen, it will be       displayed once the user has picked a recipe from the first screen.  Also, the second screen will have a detail view showing the steps   needed to complete the meal.

- What will your final demo look like? 
    * For first time users, they will take a small survey asking them what types of food do they like. Once they complete the survey, users   will be shown a list of recommended foods based on the survey they took. On the screen listing recipes, users will have the ability to   search through the different recipes. Finally, the user will have the ability to see a detail view of the recipe selected; show the     necessary steps needed to complete the meal.
- What mobile features do you leverage?
   * The application feature that we leverage is searchability.  
- What are your technical concerns?
   * Currently, we do not have any technical concerns.  

## API Information
- API Endpoints: [Marketplace](https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/{id}/analyzedInstructions) 
- Model Classes:
  * Recipe 
    - id
    - steps
    - name
    - igredients
    - equipment 
    - temperature
    - image
  * User
    - name
    - id

## Database Schema 
<img src="http://i66.tinypic.com/xlxuv6.png">


## License

    Copyright 2018 Mario Martinez, Sarah Villegas, Thalia Villalobos 

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
