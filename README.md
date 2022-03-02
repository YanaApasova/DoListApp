# DoListApp

App was written using XCode 13.2.1 and Swift 5.5 version.
 Tested on iPhone 11 pro max, physical device

The aim was to create easy and functional to do list app, using CoreData.

1) main screen


<img src="https://user-images.githubusercontent.com/98092825/156225250-fc995ed9-8d46-431a-802d-553b5807d3cc.PNG" width="200" height="400">

The main screen is represented by UITableView with headerView. The headerView contains today lable and current date.
When the tableView is empty there is a placeholder.
Also at the bottom of the screen there is an add round button.

The tasks are added from another vc and are implemented accordind to category, each category has its own picture.
User aslo required to choose date and add task text.


<img src="https://user-images.githubusercontent.com/98092825/156227804-74002b48-2f46-4bc0-8a50-e65de2ee5b5b.PNG" width="200" height="400">



<img src="https://user-images.githubusercontent.com/98092825/156228392-d88d0f1a-9cfa-4c8f-9eab-29ac42a35936.PNG" width="200" height="400">


2) create new task screen 

When button is tapped, user can create new task in the new VC and save it. When saving is succesful, proper window occurs.After that yser is redirected to the main screen. It also can be done using CANCEL button.

Keyboard doesn't overlapping textfield, when tapped.


<img src="https://user-images.githubusercontent.com/98092825/156229077-83d7f2ce-2f5c-44a6-b5a2-e4ec47fa49d3.PNG" width="200" height="400">
<img src="https://user-images.githubusercontent.com/98092825/156229554-02204d1b-54d1-44a7-a7d5-39b54f11b2a8.PNG" width="200" height="400">
<img src="https://user-images.githubusercontent.com/98092825/156229751-cebc895d-af56-4d59-a256-408bc4b56f1d.PNG" width="200" height="400">

Deleting items is done by left swipe with a proper confiration window

<img src="https://user-images.githubusercontent.com/98092825/156230160-c31038e0-0781-4af5-8c2b-ff1b518d7e21.PNG" width="200" height="400">

<img src="https://user-images.githubusercontent.com/98092825/156230382-9b932d6e-a931-4d40-824f-c94a085c1bfa.jpeg" width="200" height="400">


Upcoming changes: bug fixes, search bar on the top of the main screen, animation integration (Lottie pod)


