# ios-decal-final-proj

# Roomies  
## Authors
- Aneesh Khera
- Sam Steady 

## Purpose
We are aiming to create an app that streamlines cooperative living in college, specifically through the organized distribution and management of household chores.

## Features
* Reminder functionality
* Punishment for users who do overdue chores 
* Chore cycle
* Track record of each user in a household

## Control Flow
* Startup screen - logo
* Input screen - if no user data, prompt to set up new user household, else: show entire household as tableview with user's chore on top
* Setting up household: input all users and possible chores/due dates and frequency
* Ability to edit chores, reassign, remove
* Ability to check off chores

## Implementation
### Model
* User.swift
* Chore.swift
* Household.swift

### View
* StartupScreenView
* CreateHouseHoldView
* UsersTableView
* IndividualUserProgressView
* ChoreEditView

### Controller
* StartupScreenViewController
* CreateHouseHoldViewController
* UsersTableViewController
* IndividualUserProgressViewController
* ChoreEditViewController
