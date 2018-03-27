# OtterRadio

**OtterRadio** is a radio station that is boadcast from the California State University, Monterey Bay.

## User Stories

The following **required** functionality is completed:

- [ ] User can create an account 
- [ ] User can login as guest
- [ ] User can play and stop the otter radio
- [ ] User can post a message
- [ ] User can see messages posted by other users

The following **Optional** features are implemented:

- [ ] User can see the schedule of the audio live stream
- [ ] User can log in and log out of his or her account
- [ ] User can listen to the radio when the phone screen is turned off
- [ ] User can view the live stream of the otter radio
- [ ] User can request a song
- [ ] User can sign in as a radio talk host user
- [ ] Radio talk host users can see the requests from users


## Considerations
- What is your product pitch?
   * Student's at CSUMB, Califorina State University of Monterey Bay, has to use a computer to access the radio station and must call in to request a song. With Otter Radio users can get access the radio content from their device and request a song or shoutout with a click of a button.  
- Who are the key stakeholders for this app?
   * Our app is will give a more efficient way to listen, view, and request songs for CSUMB Radio station.  
- What are the core flows? 
    * The key functionality of our app is going to be searching, filtering, and displaying recipes.  For now, the user will be able to see   two screens. The first screen will display a list of recipes along with a search bar on top. As for the second screen, it will be       displayed once the user has picked a recipe from the first screen.  Also, the second screen will have a detail view showing the steps   needed to complete the meal.

- What will your final demo look like? 
    * For first time users, they will take a small survey asking them what types of food do they like. Once they complete the survey, users   will be shown a list of recommended foods based on the survey they took. On the screen listing recipes, users will have the ability to   search through the different recipes. Finally, the user will have the ability to see a detail view of the recipe selected; show the     necessary steps needed to complete the meal.
- What mobile features do you leverage?
   * The application feature that we leverage is searchability.  
- What are your technical concerns?
   * Currently, we do not have any technical concerns.  

## Audio Information
- Audio Endpoints: [ottermedia](http://icecast.csumb.edu:8000/ottermedia) 
- Live stream Endpoint: [ottermedia](http://media.csumb.edu/www/player/encoder.php?en=3&f=1)
- Model Classes:
  * AudioStream 
    - audioUrl
  * Messages
    - id
    - message
    - createdAt


## Database Schema 
<img src="http://i68.tinypic.com/2hrikxw.jpg">


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
