import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../common/util/utils.dart';

// #enddocregion platform_imports
class StripeWebViewScreen extends StatefulWidget {
  const StripeWebViewScreen({Key? key, required this.data}) : super(key: key);
  final Map data;
  @override
  State<StripeWebViewScreen> createState() => _PaymentScerenState();
}

class _PaymentScerenState extends State<StripeWebViewScreen> {
  String currentUrl = '';
  late final WebViewController _controller;

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: ((request) {
            debugPrint('Page request: ${request.url}');

            if (request.url
                    .contains('https://famooshed.com/admin/public/login') ||
                request.url.contains('stripesuccess')) {
              currentUrl = request.url;
              setState(() {});
              getResponse(request.url);

              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          }),
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      );
    controller.loadRequest(
      Uri.parse('${widget.data['url']}'),
      // headers: Utils.getAuthHeader(),
    );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);

      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            !(currentUrl.contains('https://famooshed.com/admin/public/login') ||
                    currentUrl.contains('stripesuccess'))
                ? WebViewWidget(
                    controller: _controller,
                  )
                : Container(
                    color: Colors.white,
                  ),
      ),
    );
  }

  Future<void> getResponse(String url) async {
    try {
      // MyProfileController myProfileController = Get.find<MyProfileController>();
      // myProfileController.isLoading.value = true;
      // await myProfileController.getProfile();

      Get.back();
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => SignInPage(),
      //     ),
      //     (route) => false);
    } catch (e) {
      Utils.showSnackbar(e.toString());
    }
  }
}
