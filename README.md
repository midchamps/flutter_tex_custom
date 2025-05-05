# flutter_tex
[![GitHub stars](https://img.shields.io/github/stars/Shahxad-Akram/flutter_tex?style=social)](https://github.com/Shahxad-Akram/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

<img src="https://raw.githubusercontent.com/Shahxad-Akram/flutter_tex/master/example/assets/flutter_tex_banner.png" alt=""/>

# Contents
- [flutter\_tex](#flutter_tex)
- [Contents](#contents)
- [About](#about)
- [How it works?](#how-it-works)
- [Demo Video](#demo-video)
- [Screenshots](#screenshots)
- [How to setup?](#how-to-setup)
    - [Android](#android)
    - [iOS](#ios)
    - [Web](#web)
- [How to use?](#how-to-use)
    - [TeXWidget Example](#texwidget-example)
    - [Full Example](#full-example)
      - [Full Example](#full-example-1)
- [Application Demo:](#application-demo)
- [Web Demo:](#web-demo)
- [Api Changes:](#api-changes)
- [Api Usage (TeXView):](#api-usage-texview)
- [ToDo](#todo)
- [Limitations:](#limitations)

# About
A Flutter Package, to render **fully offline** all types of equations and expressions based on **LaTeX** , **TeX** and **MathML**, most commonly used are as followings:

- **Mathematics / Maths Equations and expressions** (Algebra, Calculus, Geometry, Geometry etc...)

- **Physics Equations and expressions**

- **Signal Processing Equations and expressions**

- **Chemistry Equations and expressions**

- **Statistics / Stats Equations and expressions**

- It also includes full **HTML** with **JavaScript** support.

# How it works?

Flutter TeX is a port to a powerful JavaScript library [MathJax](https://github.com/mathjax/MathJax) which render the equations in [webview_flutter_plus](https://pub.dartlang.org/packages/webview_flutter_plus). All credits goes to [MathJax](https://github.com/mathjax/MathJax) developers.

# Demo Video

* [Click to Watch Demo on Youtube](https://www.youtube.com/watch?v=YiNbVEXV_NM)

# Screenshots
 |        Fonts Sample             Apr    TeX Document         |
 | :---------------------------------------------------------: | :---------------------------------------------------------: | :---------------------------------------------------------: |
 | <img src="https://i.postimg.cc/651PXKYC/screenshot-1.png"/> | <img src="https://i.postimg.cc/wjyGxrGZ/screenshot-2.png"/> | <img src="https://i.postimg.cc/k4cjhP26/screenshot-3.png"/> |

 |                        TeX Document                         |                        Image & Video                        |                           InkWell                           |
 | :---------------------------------------------------------: | :---------------------------------------------------------: | :---------------------------------------------------------: |
 | <img src="https://i.postimg.cc/d0GNryv9/screenshot-4.png"/> | <img src="https://i.postimg.cc/prLswcj0/screenshot-5.png"/> | <img src="https://i.postimg.cc/rwBYDJ6m/screenshot-6.png"/> |

# How to setup?

**Minmum flutter SDK requirement is 3.27.x**


**1:** Add flutter_tex latest  [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex) version under dependencies to your package's pubspec.yaml file.

```yaml
dependencies:
  flutter_tex: ^5.0.1
``` 

**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.


**3:** Now you need to put the following implementations in `Android`, `iOS`, and `Web` respectively.

### Android
Make sure to add this line `android:usesCleartextTraffic="true"` in your `<project-directory>/android/app/src/main/AndroidManifest.xml` under `application` like this.

```xml
<application
       ...
       ...
       android:usesCleartextTraffic="true">
</application>
```

It completely works offline, without internet connection, but these are required permissions to work properly:
Apr

```xml
    <uses-permission android:name="android.permission.INTERNET" />
```
and intents in queries block: 

```xml
<queries>
  ...
  ...
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>

    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="sms" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="tel" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="mailto" />
    </intent>
    <intent>
        <action android:name="android.support.customtabs.action.CustomTabsService" />
    </intent>
</queries>
```


It'll still work in debug mode without permissions, but it won't work in release application without mentioned permissions.

### iOS
Add following code in your `<project-directory>/ios/Runner/Info.plist`

```plist
<key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key> <true/>
  </dict>
<key>io.flutter.embedded_views_preview</key> <true/> 
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>https</string>
    <string>http</string>
    <string>tel</string>
    <string>mailto</string>
</array> 

```

### Web
For Web support you need to put `<script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>` in `<head>` tag of your `<project-directory>/web/index.html` like this.

```html
<head>
    ...
    ...
    <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
    <script src="assets/packages/flutter_tex/core/mathjax_lite_dom.js"></script>
</head>
```

# How to use?

In your Dart code, you can use like:

```dart
import 'package:flutter_tex/flutter_tex.dart'; 
```

Make sure to setup `TeXRederingServer` before rendering TeX:

```dart
main() async {

  if (!kIsWeb) {
    await TeXRenderingServer.start();
  }

  runApp(...);
}
```

Now you can use `TeXWidget` or `TeXView` as a widget:

### TeXWidget Example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

main() async {
  if (!kIsWeb) {
    await TeXRenderingServer.start();
  }
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TeXWidgetExample(),
  ));
}

class TeXWidgetExample extends StatefulWidget {
  const TeXWidgetExample({super.key});

  @override
  State<TeXWidgetExample> createState() => _TeXWidgetExampleState();
}

class _TeXWidgetExampleState extends State<TeXWidgetExample> {
  double fontSize = 18.0;
  TextStyle baseStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TeX Widget Example"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 4),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Quadratic Formula",
                    style: baseStyle.copyWith(
                      fontSize: fontSize * 1.5,
                      color: Colors.black,
                    )),
                RichText(
                  text: TextSpan(
                    style: baseStyle,
                    children: <InlineSpan>[
                      const TextSpan(text: 'When'),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeXWidget(
                          math: r"a \ne 0",
                          fontSize: fontSize,
                        ),
                      ),
                      const TextSpan(text: ', there are two solutions to'),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeXWidget(
                          math: r"ax^2 + bx + c = 0",
                          fontSize: fontSize,
                        ),
                      ),
                      const TextSpan(text: ' and they are:'),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                TeXWidget(
                    math: r"""x = {-b \pm \sqrt{b^2-4ac} \over 2a}""",
                    fontSize: fontSize * 3)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

### Full Example
#### [Full Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example)

# Application Demo:
<a href='https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

[Demo Source](https://github.com/Shahxad-Akram/flutter_tex/tree/master/example)

# Web Demo:
You can find web demo at [https://flutter-tex.web.app](https://flutter-tex.web.app)

# Api Changes:
* Please see [CHANGELOG.md](https://github.com/Shahxad-Akram/flutter_tex/blob/master/CHANGELOG.md).

# Api Usage (TeXView):
- `children:` A list of `TeXViewWidget`

- **`TeXViewWidget`**
    - `TeXViewDocument` Holds TeX data by using a raw string e.g. `r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """` You can also put HTML and Javascript code in it.
    - `TeXViewMarkdown` Holds markdown data.
    - `TeXViewContainer` Holds a single `TeXViewWidget` with styling.
    - `TeXViewImage` renders image from assets or network.
    - `TeXViewColumn` holds a list of `TeXViewWidget` vertically.
    - `TeXViewInkWell` for listening tap events. Its child and id is mandatory.
    - `TeXViewGroup` a group of `TeXViewGroupItem` usually used to create quiz layout.
    - `TeXViewDetails` like html `<details>`.


- `TeXViewStyle()` You can style each and everything using `TeXViewStyle()` or by using custom `CSS` code by `TeXViewStyle.fromCSS()` where you can pass hard coded String containing CSS code. For more information please check the example.
    

- `loadingWidgetBuilder:` Show a loading widget before rendering completes.

- `onRenderFinished:` Callback with the rendered page height, when TEX rendering finishes.

For more please see the [Example](https://github.com/Shahxad-Akram/flutter_tex/tree/master/example).

# ToDo
- MathJax configurations from Flutter.

# Limitations:
- Please avoid using too many `TeXView`s in a single page, because this is based on [webview_flutter_plus](https://pub.dartlang.org/packages/webview_flutter_plus) a complete web browser. Which may cause slowing down your app. I am trying to add all necessary widgets within `TeXView`, So please prefer to use `TeXViewWidget`. You can check [example folder](https://github.com/Shahxad-Akram/flutter_tex/tree/master/example) for details. If you find any problem you can [report an issue](https://github.com/Shahxad-Akram/flutter_tex/issues/new).
