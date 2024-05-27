# rankgroupassignment

A new Flutter project.

## Intro

We want to write a system that allows our admins to submit credit card numbers for validation.

## Requirements 

Build a Flutter mobile application that can do the following:
- Allow the user to submit credit card details. Details should include: Card Number, Card Type, CVV, Issuing Country (DONE)
- Ability to infer Card Type from Credit Card number would be beneficial. (DONE)
- Check the specified country to make sure it doesn’t exist in a list of banned countries. (DONE)
- Make the list of banned countries configurable. (DONE)
- If the card is valid – store it in local storage. (DONE)
- Display all the credit cards that have been captured during the session. (DONE)
- Don’t capture the same card twice. (DONE)
- Please also add the ability to scan a credit card (examples attached), and pre-populate the card number and infer the cart type. (NOT DONE)
- Authorization is not necessary for the purposes of this test. (OK)

## Guidelines

You are welcome to use 3rd party packages, but we are trying to gauge your skill. Please try to keep the amount of packages to the absolutely necessary.

Add your application to a git repository and send that to us. Don’t hesitate to reach out to us if you have questions. Good luck and have fun!

## Libraries Used

Please search https://pub.dev/ for the corrresponding libraries to better understand implementation reasoning:
- cupertino_icons: ^1.0.6
- equatable: ^2.0.5
- provider: ^6.1.2
- shared_preferences: ^2.2.3

# Important Notes
- I had an agreed time limit to implement assignment for Sat 25 May to Sun 26 May, i was able to start evening of 24 May. I underestinmated the effort required to implement this project to my satisfaction. 
- I have limited the use of libraries where possible. 
- I created the app by using Iphone 15 (iOS 17.4), i have not tested on Android.

# Notes to Reviewer: 
- Files in app folder contains settings for whole app. 
- Files in model also consists of enums and lists, i dont want to create folders for single files. 
- I anticipated this project to be on one page, but changed my approach towards the end realising the blocking does better on a second page. Which is why i did not implement BLoC, but is also why i did add Provider.  
- Files in screen folders are for their corresponding self describing purposes. 
- Files in services are for services, please excuse adding a state file. This project is small so didnt want to create folders for single files. 
- I have updated README with Assignment details and notes. 
- I used the following for Luhn's Algorithm https://medium.com/@durgeshparekh381/securing-transactions-validating-credit-card-numbers-decoded-techtalk-2bad15c2089e as a guideline for Card Number validation. 
- I ran out of time before i could implement: textTheme-from-ThemeData, string-conversion, UI and styling and testing. 



Please feel free reaching out to ian.inch@gmail.com for any questions. 