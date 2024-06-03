# MealSwap

<img src="https://github.com/Lwilliams002/iOS102-Group-Project/blob/update-gif-screenshots/mealswap-20240602.gif" width=300>



## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Sprint Progress](#Sprint-Progress)

## Overview

### Description

MealSwap is an app that allows users to post their extra food and view others' food, then potentially match and organize a swap. It's a social app that allows people who like to cook to interact with other people in their area, try new foods, and reduce food waste!

### App Evaluation

- **Category:** Social
- **Mobile:** Mobile first (for now)
- **Story:**  It helps users connect with their community, have new experiences, and reduce food waste
- **Market:** People who cook and want to connect with their community, who might care about reducing food waste and trying new foods
- **Habit:** Occasional - can be used whenever users have extra food, and want to try something new or connect with neighbors.
- **Scope:** Focused on users in a specific situation but aims to be fully-featured to solve this problem

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can register/sign in to an account
- [X] User can log out
- [X] User can create a new meal record (ingredients, title, photos,...)
- [ ] User can swipe through a feed of meals and "swipe right" to indicate they would want to swap for that meal
- [ ] If two users' meals are found to be a match, both are notified and those meals are marked as matched(swap pending)
- [X] User can see matched meals that haven't been swapped yet and confirm a swap with their desired meal


**Optional Nice-to-have Stories**

- [ ] Users who have matched on meals can chat/organize an exchange
- [ ] Users only see meals from other users in the same area
- [ ] Users can specify dietary requirements and meals are filtered to fit these
- [ ] Users can leave comments/ratings/likes on meals they've recieved (and these are displayed on a user's profile)
- [ ] User can edit profile info
- [ ] User can see the profile of the user whose meal they are looking at, and see the ratings of all their meals
- [ ] User can follow other another user
- [ ] User can see a dedicated feed view for users they follow

### 2. Screen Archetypes

- [X] [**Login Screen**]
* [Required Feature: User can register/sign in to an account]
* * Optional Feature: Users can specify dietary requirements and meals are filtered to fit these (when creating an account)
- [X] [**Create Meal Screen**]
* [Required Feature: User can create a new meal record (ingredients, title, photos,...)]
- [X] [**Meals Feed Screen**]
- [Required Feature: User can swipe through a feed of meals and "swipe right" to indicate they would want to swap for that meal]
- [Required Feature: If two users' meals are found to be a match, both are notified and those meals are marked as matched(swap pending)]
* Optional Feature: Users only see meals from other users in the same area
* Optional Feature: User can see a dedicated feed view for users they follow
- [ ] [**User Profile Screen**]
* Optional Feature: User can see the profile of the user whose meal they are looking at, and see the ratings of all their meals
* Optional Feature: User can follow other another user
- [X] [**Matched Meals Screen**]
- [Required Feature: User can see matched meals that haven't been swapped yet and confirm a swap with their desired meal]
* Optional Feature: Users who have matched on meals can chat/organize an exchange
* Users can leave comments/ratings/likes on meals they've recieved (and these are displayed on a user's profile)
- [X] [**Settings Screen**]
- [Required Feature: User can log out]
* Optional Feature: Users can specify dietary requirements and meals are filtered to fit these
* Optional Feature: User can edit profile info

### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [X] [First Tab - Meals Feed]
- [X] [Second Tab - Create Meal]
- [X] [Third Tab - Matched Meals]
- [X] [Fourth Tab - Settings]

**Flow Navigation** (Screen to Screen)

- [ ] [**Login Screen**]
  * Leads to [**Settings Screen**] if user just registered
  * Leads to [**Meals Feed**] if user logged in
- [ ] [**Settings Screen**]
  * Leads to [**Login Screen**] if user logs out
- [ ] [**Meals Feed**] or [**Matched Meals**]
  * Leads to [**User Profile Screen**] if user taps on user from a meal


## Wireframes

<img src="https://github.com/Lwilliams002/iOS102-Group-Project/blob/main/mealswap-wireframe.png">

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 


### Models

[Model Name, e.g., User]
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | unique id for the user post (default field)   |
| password | String | user's password for login authentication      |
| ...      | ...    | ...                          


### Networking

- [List of network requests by screen]
- [Example: `[GET] /users` - to retrieve user data]
- ...
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]


## Sprint Progress

### Sprint 1
<img src= "https://github.com/Lwilliams002/iOS102-Group-Project/blob/main/sprint-1-demo.gif" width=350>
https://www.loom.com/share/cb1ae4a45d144f07abbeac080bc8b18a?sid=56682de0-5ded-4944-a84f-3d49edf3f29

### Sprint 2
<img src="https://github.com/Lwilliams002/iOS102-Group-Project/blob/main/milestone2-demo.gif" width=350>
