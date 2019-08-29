# Flutter Local Notifications Plugin

[![pub package](https://img.shields.io/pub/v/flutter_local_notifications.svg)](https://pub.dartlang.org/packages/flutter_local_notifications)
[![Build Status](https://api.cirrus-ci.com/github/MaikuB/flutter_local_notifications.svg)](https://cirrus-ci.com/github/MaikuB/flutter_local_notifications/master)
[![Codemagic build status](https://api.codemagic.io/apps/5d679aeb589eba1ae9a6a273/5d679aeb589eba1ae9a6a272/status_badge.svg)](https://codemagic.io/apps/5d679aeb589eba1ae9a6a273/5d679aeb589eba1ae9a6a272/latest_build)

Internship application used to manage your payment deadline & history. 

## Supported Platforms
* Android API 16+ (4.1+, the minimum version supported by Flutter). Uses the NotificationCompat APIs so it can be run older Android devices
* iOS 8.0+ (the minimum version supported by Flutter). Supports the old and new iOS notification APIs (the User Notifications Framework introduced in iOS 10 but will use the UILocalNotification APIs for devices predating iOS 10)

## Features

* LocalSotrage
* Display basic notifications
* Scheduling when notifications should appear
* Periodically show a notification (interval based)
* Schedule a notification to be shown daily at a specified time
* Retrieve a list of pending notification requests that have been scheduled to be shown in the future
* Cancelling/removing notification by swipping it side ways or selecting the notification it self
* Specify if you want a silent or loud notification
* Ability to handle when a user has tapped on a notification, when the app is the foreground, background or terminated
* Determine if an app was launched due to tapping on a notification

## Packages & dependencies

* SqfLite
* path_provider
* shared_preferences
* rxdart
* clippy_flutter
* intl
* flare_flutter


## Project aim & duration

* This project took a 3 weeks duration to establish and clean up.
