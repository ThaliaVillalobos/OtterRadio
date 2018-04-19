# OtterRadio

**OtterRadio** is a radio station that is broadcasted from the California State University, Monterey Bay.

## User Stories

The following **required** functionality is completed:

- [X] User can create an account 
- [x] User can login as guest
- [X] User can play and stop the otter radio
- [X] User can post a message
- [X] User can see messages posted by other users

The following **Optional** features are implemented:

- [ ] User can see the schedule of the audio live stream
- [x] User can log in and log out of his or her account
- [x] User can listen to the radio when the phone screen is turned off
- [X] User can view the live stream of the otter radio
- [x] User can request a song
- [x] User can sign in as a radio talk host user
- [x] Radio talk host users can see the requests from users


## Considerations
- What is your product pitch?
   * Student's at CSUMB, Califorina State University of Monterey Bay, has to use a computer to access the radio station and must call in to request a song. With Otter Radio users can get access the radio content from their device and live chat with a click of a button.  
- Who are the key stakeholders for this app?
   * Our app is will give listeners a more efficient way to tune in, view, and live chat for CSUMB Radio station.  
- What are the core flows? 
    * The key functionality of our app is going to be able to listen to CSUMB radio station and watch a live feed of the radio station wherever users go.Also users will be able to live chat with others when listening to CSUMB radio station. 
- What will your final demo look like? 
    * Users can choose to either sign in or to sign in as a guest and then users can start listening to CSUMB radio station. There will be two tabs one for radio and the other tab is for the live feed. For users who log in as a guest the only features they have access to is to listen in and view the live stream of CSUMB radio station.     
- What mobile features do you leverage?
   * The application feature that we leverage is gives CSUMB radio an simple to connect with its listerns.  
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

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/UrxlHMH.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Part 2:
<img src='https://i.imgur.com/6BZoROK.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />



GIF created with [LiceCap](http://www.cockos.com/licecap/).

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
