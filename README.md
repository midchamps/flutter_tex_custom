# flutter_tex
[![GitHub stars](https://img.shields.io/github/stars/Shahxad-Akram/flutter_tex?style=social)](https://github.com/Shahxad-Akram/flutter_tex/stargazers) [![pub package](https://img.shields.io/pub/v/flutter_tex.svg)](https://pub.dev/packages/flutter_tex)

<img src="https://raw.githubusercontent.com/Shahxad-Akram/flutter_tex/master/example/assets/flutter_tex_banner.png" alt=""/>

# Contents
- [flutter\_tex](#flutter_tex)
- [Contents](#contents)
- [About](#about)
- [How it works?](#how-it-works)
- [Web Demo](#web-demo)
- [Application Demo](#application-demo)
- [Demo Video](#demo-video)
- [Screenshots](#screenshots)
- [How to setup?](#how-to-setup)
    - [Android](#android)
    - [iOS](#ios)
    - [Web](#web)
    - [MacOS](#macos)
- [How to use?](#how-to-use)
    - [TeXWidget](#texwidget)
    - [TeX2SVG](#tex2svg)
    - [TeXView](#texview)
- [More Examples](#more-examples)
- [MathJax Configurations for `TeXView`](#mathjax-configurations-for-texview)
- [API Usage (TeXView)](#api-usage-texview)
- [API Changes](#api-changes)
- [Limitations](#limitations)

# About
A self-contained Flutter package leveraging [MathJax](https://github.com/mathjax/MathJax) to deliver robust, fully offline rendering of mathematical and chemical notation. It parses multiple formats, including **LaTeX**, **TeX**, and **MathML**, making it a universal solution for in-app scientific and mathematical visualization.

**Primary use cases include, but are not limited to:**

- General Mathematics and Statistics
- Physics and Chemistry Equations
- Signal Processing Expressions
- In addition to its mathematical capabilities, the package is a powerful tool for displaying rich content, offering complete HTML and JavaScript support.


# How it works?
Flutter TeX brings the power of the [MathJax](https://github.com/mathjax/MathJax) rendering engine to Flutter applications. As a direct port of this essential JavaScript library, it enables the display of a wide range of equations and expressions from formats like LaTeX, TeX, and MathML.

The rendering itself is handled within a [webview_flutter_plus](https://pub.dartlang.org/packages/webview_flutter_plus) widget, allowing for a robust and faithful presentation of the original MathJax output.

We extend our sincere credit to the original [MathJax](https://github.com/mathjax/MathJax) developers, whose work is the foundation of this package.


# Web Demo
- ## [https://flutter-tex.web.app](https://flutter-tex.web.app)


# Application Demo
<a href='https://play.google.com/store/apps/details?id=com.shahxad.flutter_tex_example&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a>

# Demo Video
- ## [Click to Watch Demo on Youtube](https://www.youtube.com/watch?v=YiNbVEXV_NM)

# Screenshots
 |                        Fonts Sample                         |                         Quiz Sample                         |                        TeX Document                         |
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
  flutter_tex: ^5.0.9
``` 

**2:** You can install packages from the command line:

```bash
$ flutter packages get
```

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.


**3:** Now you need to put the following implementations in `Android`, `iOS`, `MacOS` and `Web` respectively.

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


### iOS
Add following lines in `<project-directory>/ios/Runner/Info.plist`

```xml
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
For Web support modify `<project-directory>/web/index.html` like this.

```html
<head>
    ...
    ...
  <script src="assets/packages/flutter_tex/core/flutter_tex.js"></script>
  <script src="assets/packages/flutter_tex/core/mathjax_core.js"></script>
</head>
```

### MacOS
By default, macOS apps running in a sandboxed environment (which is the standard for Flutter apps) are not allowed to make network requests. You need to explicitly grant your application the capability to access the internet. In your Flutter project, navigate to the `macos/Runner/` directory and add the following key-value pair to `DebugProfile.entitlements` and `Release.entitlements`.

```xml
<key>com.apple.security.network.client</key>
  <true/>
```

# How to use?

In your Dart code, you can use like:

```dart
import 'package:flutter_tex/flutter_tex.dart'; 
```

Make sure to setup `TeXRederingServer` before rendering TeX:

```dart
main() async {
  await TeXRenderingServer.start();
  runApp(...);
}
```

Now you can use `TeXView`,`TeXWidget` or `TeX2SVG` as a widgets:

### TeXWidget
A simple but powerful widget based on `TeX2SVG`. See [TeXWidget Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_widget_example.dart) for more details:

```dart
TeXWidget(math: r"When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$$")
```


### TeX2SVG
A high-performance, pure Flutter solution for displaying mathematical notations. It accurately parses TeX expressions and renders them as resolution-independent SVGs via the [flutter_svg](https://pub.dev/packages/flutter_svg) library.

- **Pure Flutter**: Ensures seamless integration and optimal performance within your Flutter project.
- **High-Quality Output**: Renders TeX as SVG for sharp, scalable graphics on any screen size.
- **Full Render Control**: Provides a comprehensive API for fine-tuning the appearance and behavior of rendered equations.


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
    home: TeX2SVGExample(),
  ));
}

class TeX2SVGExample extends StatefulWidget {
  const TeX2SVGExample({super.key});

  @override
  State<TeX2SVGExample> createState() => _TeX2SVGExampleState();
}

class _TeX2SVGExampleState extends State<TeX2SVGExample> {
  double fontSize = 18.0;
  TextStyle baseStyle = TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeX2SVG Example"),
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
                      const TextSpan(text: 'When '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeX2SVG(
                          teXInputType: TeXInputType.teX,
                          math: r"a \ne 0",
                        ),
                      ),
                      const TextSpan(text: ', there are two solutions to'),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TeX2SVG(
                          math: r"ax^2 + bx + c = 0",
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
                TeX2SVG(
                  math: r"""x = {-b \pm \sqrt{b^2-4ac} \over 2a}""",
                  formulaWidgetBuilder: (context, svg) {
                    double displayFontSize = fontSize * 3;
                    return SvgPicture.string(
                      svg,
                      height: displayFontSize,
                      width: displayFontSize,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

### TeXView
This is an advanced widget based on [webview_flutter_plus](https://pub.dartlang.org/packages/webview_flutter_plus), engineered for a rich user experience. It excels at rendering complex mathematical equations and offers a flexible environment for dynamic content through its support for:

- **Inline HTML:** Directly embed and render HTML content.
- **JavaScript:** Execute custom scripts for interactive elements.
- **Markdown:** Display text with Markdown formatting.


```dart
TeXView(
    child: TeXViewColumn(children: [
      TeXViewInkWell(
        id: "id_0",
        child: TeXViewColumn(children: [
          TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
              style: TeXViewStyle(textAlign: TeXViewTextAlign.center)),
          TeXViewContainer(
            child: TeXViewImage.network(
                'https://raw.githubusercontent.com/Shahxad-Akram/flutter_tex/master/example/assets/flutter_tex_banner.png'),
            style: TeXViewStyle(
              margin: TeXViewMargin.all(10),
              borderRadius: TeXViewBorderRadius.all(20),
            ),
          ),
          TeXViewDocument(r"""<p>                                
                       When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
              style: TeXViewStyle.fromCSS(
                  'padding: 15px; color: white; background: green'))
        ]),
      )
    ]),
    style: TeXViewStyle(
      elevation: 10,
      borderRadius: TeXViewBorderRadius.all(25),
      border: TeXViewBorder.all(TeXViewBorderDecoration(
          borderColor: Colors.blue,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 5)),
      backgroundColor: Colors.white,
    ),
   );
```

# More Examples

- ### [TeXWidget Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_widget_example.dart)

- ### [TeX2SVG Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex2svg_example.dart)

- ### [TeXView Document Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_document_example.dart)

- ### [TeXView Markdown Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_markdown_example.dart)

- ### [TeXView Quiz Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_quiz_example.dart)

- ### [TeXView Custom Fonts Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_fonts_example.dart)

- ### [TeXView Image and Video Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_image_video_example.dart)

- ### [TeXView InkWell Example](https://github.com/Shahxad-Akram/flutter_tex/blob/master/example/lib/tex_view_ink_well_example.dart)


# MathJax Configurations for `TeXView`

To apply a custom MathJax configuration, create a file named `mathjax_config.js` in the root of your project's `assets` directory.

For example, your project structure should look like this:

```text
your_flutter_app/
├── assets/
│   └── mathjax_config.js
├── lib/
...
```
and make sure to add this into `pubspec.yaml` like:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/mathjax_config.js
```

An example `mathjax_config.js` file:

```js
window.MathJax = {
    tex: {
        inlineMath: [['$', '$'], ['\\(', '\\)']],
        displayMath: [['$$', '$$'], ['\\[', '\\]']],
    },
    svg: {
        fontCache: 'global'
    }
};
```

For more info please refer to the [MathJax Docs](https://docs.mathjax.org/en/latest/basic/mathjax.html)

# API Usage (TeXView)
- `children` A list of `TeXViewWidget`
- `heightOffset` Height offset to be added to the rendered height.

- **`TeXViewWidget`s**
    - `TeXViewDocument` Holds TeX data by using a raw string e.g. `r"""$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br> """` You can also put HTML and Javascript code in it.
    - `TeXViewMarkdown` Holds markdown data.
    - `TeXViewContainer` Holds a single `TeXViewWidget` with styling.
    - `TeXViewImage` renders image from assets or network.
    - `TeXViewColumn` holds a list of `TeXViewWidget` vertically.
    - `TeXViewInkWell` for listening tap events..
    - `TeXViewDetails` like html `<details>`.


- `TeXViewStyle()` You can style each and everything using `TeXViewStyle()` or by using custom `CSS` code by `TeXViewStyle.fromCSS()` where you can pass hard coded String containing CSS code. For more information please check the example.
    

- `loadingWidgetBuilder` Shows a loading widget before rendering completes.

- `onRenderFinished` Callback with the rendered page height, when TEX rendering finishes.

For more please see the [Example](https://github.com/Shahxad-Akram/flutter_tex/tree/master/example).

# API Changes
* Please see [CHANGELOG.md](https://github.com/Shahxad-Akram/flutter_tex/blob/master/CHANGELOG.md).

# Limitations
To ensure your app remains fast and responsive, it is important to understand the performance implications of `TeXView`. As this widget utilizes [webview_flutter_plus](https://pub.dartlang.org/packages/webview_flutter_plus), each `TeXView` effectively embeds a web browser.

Therefore, we advise against using multiple `TeXView` instances on a single page. For layouts requiring multiple TeX elements, please use the `TeXViewWidget` as a container. This approach is optimized for performance and is the preferred method for building complex views.

For practical examples, browse the [example folder](https://github.com/Shahxad-Akram/flutter_tex/tree/master/example). If you run into problems, you can [report an issue](https://github.com/Shahxad-Akram/flutter_tex/issues/new).
