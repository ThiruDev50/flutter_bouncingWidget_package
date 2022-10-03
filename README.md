
<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Want to animate your widgets (like containers, cards etc...) bouncing In and out while clicking? Here is the package for that.

## Features

This package contains a widget, where you need to wrap your own widgets ( like container, cards ect...) to animate them
bounce in and out while clicking.

![bouncing-widget-eg2](https://user-images.githubusercontent.com/97810531/193555209-fa99cca7-d607-4f20-8059-fe5cd9ad0c4d.gif)



## Getting started
As the first step we need to add this package in pubspec.yaml file or run the following command flutter pub add tdk_bouncingwidget 


## Usage
Just wrap your widget inside BouncingWidgetInOut widget as shown below and we are done!!

```dart
BouncingWidgetInOut(
    onPressed: () {},
    bouncingType: BouncingType.bounceInAndOut,
    child : Container(
        height: 60,
        width: 200,
        child: const Text('click to bounce')
    ))
```
There is one optional parameter called "bouncingType" which specifies the bouncing type of the widget. That is "Bouncing In only" or "Bouncing out Only" or both "Bouncing In and Out". By **default bouncingType is "bounceInOnly"**.

**bounceInOnly** => Widget will **shrink and grow** based on scale factor value.

**bounceOutOnly** => Widget will **grow and shrink** based on scale factor value.

**bounceInAndOut** => Widget will **shrink and grow** first and then it will **grow and shrink** based on the scale factor value.

You can even customize the bouncing animation by **giving duration** how much time your widgets needs to animate and
how large and small your widget should grow/shrink by giving **scale factor value**.

## Additional information

Feel free to raise an issue if anything breaking, I will try to fix that ASAP. Github link mentioned above. Thanks!
