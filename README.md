# rankgroupassignment

A new Flutter project.

## Intro

We want to write a system that allows our admins to submit credit card numbers for validation.

## Requirements 

Build a Flutter mobile application that can do the following:
- Allow the user to submit credit card details. Details should include: Card Number, Card Type, CVV, Issuing Country
- Ability to infer Card Type from Credit Card number would be beneficial.
- Check the specified country to make sure it doesn’t exist in a list of banned countries.
- Make the list of banned countries configurable.
- If the card is valid – store it in local storage.
- Display all the credit cards that have been captured during the session.
- Don’t capture the same card twice.
- Please also add the ability to scan a credit card (examples attached), and pre-populate the card number and infer the cart type.
- Authorization is not necessary for the purposes of this test.

## Guidelines

You are welcome to use 3rd party packages, but we are trying to gauge your skill. Please try to keep the amount of packages to the absolutely necessary.

Add your application to a git repository and send that to us. Don’t hesitate to reach out to us if you have questions. Good luck and have fun!

## Libraries Used

Please search https://pub.dev/ for the corrresponding libraries to better understand implementation reasoning:
- cupertino_icons: ^1.0.6
- equatable: ^2.0.5
- provider: ^6.1.2
- shared_preferences: ^2.2.3

