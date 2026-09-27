import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // root
  static final Color background = Colors.blue[50]!;

  // AppBar
  static final Color appBarBackground = Colors.white;
  static final Color appBarText = Colors.green[700]!;

  // NavBar
  static final Color navBarBackground = Colors.white; 
  static final Color navBarSelectItem = Colors.grey;
  static final Color navBarUnselectItem = Colors.grey[200]!;

  // Container

    // Event Activity
    static final Color activityBackground = Colors.white;
    static final Color activityTitle = Colors.blue;
    static final Color activityHeader = Colors.black;
    static final Color activityContent = Colors.black;

    // Upcoming Events
    static final Color eventsBackground = Colors.white;
    static final Color eventsTitle = Colors.red;
    static final Color eventsHeading = Colors.blue;
    static final Color eventsDescription = Colors.black;

  // Buttons

    // Register
    static final Color registerButtonBackground = Colors.green;
    static final Color registerButtonforeground = Colors.white;

    // Test Floating
    static final Color floatingButtonBackground = Colors.yellow;
    static final Color floatingButtonForeground = Colors.black;

}