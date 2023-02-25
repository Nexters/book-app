import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
  NavigationDelegate(
  onProgress: (int progress) {
  // Update loading bar.
  },
  onPageStarted: (String url) {},
  onPageFinished: (String url) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {
if (request.url.startsWith("https://pieceofbook.com")) {

  return NavigationDecision.navigate;
} else {
 final externalUrl = Uri(
   scheme: "https",
   path: "docs.google.com/forms/d/e/1FAIpQLScJ9UWShpAGnG2uOdwe6VjHg41iU9RiSkI6MJz8U1fEBbIPFQ/viewform",
 );
  _launchURL(externalUrl);

  // return NavigationDecision.prevent;
  return NavigationDecision.prevent;
}

  },
  ),
  )
  ..loadRequest(Uri.parse('https://pieceofbook.com'));

  Future<bool> _goBack(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // return const WebView(
    //   initialUrl: "https://pieceofbook.com",
    // );
    return  Scaffold(
      body: SafeArea(
         child:WillPopScope(
           onWillPop: () => _goBack(context),
           child: WebViewWidget(
             controller: controller,
           ),
         )
      ),
    );
  }
}



_launchURL(Uri url) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
}