import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rankgroupassignment/app/theme.dart';
import 'package:rankgroupassignment/screen/splash_section_screen.dart';
import 'package:rankgroupassignment/services/card_form_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CardFormState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      home: const SplashSectionScreen(),
    );
  }
}

//TODO Notes: 
// - I had an agreed time limit to implement assignment for Sat 25 May to Sun 26 May, i was able to start evening of 24 May. I underestinmated the effort required to implement this project to my satisfaction. 
// - I have limited the use of libraries where possible. 
// - I created the app by using Iphone 15 (iOS 17.4), i have not tested on Android.

//TODO: Notes to Reviewer: 
// - Files in app folder contains settings for whole app. 
// - Files in model also consists of enums and lists, i dont want to create folders for single files. 
// - I did not implement BLoC, but later on i used Provider. 
// - Files in screen folders are for their corresponding self describing purposes. 
// - Files in services are for services, please excuse adding a state file. This project is small so didnt want to create folders for single files. 
// - I have updated README with Assignment details.
// - I used the following for Luhn's Algorithm https://medium.com/@durgeshparekh381/securing-transactions-validating-credit-card-numbers-decoded-techtalk-2bad15c2089e to validate Account Numbers. 
// -- I ran out of time before i could implement: 
// --- textTheme from ThemeData, 
// --- Strings converting all strings
// --- Lots of UI and Styling 

// Please feel free reaching out to ian.inch@gmail.com for any questions. 