import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/loading_indicator.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final ValueNotifier<bool> _isLoadingNotifier;
  final _webViewKey = UniqueKey();

  @override
  void initState() {
    _isLoadingNotifier = ValueNotifier<bool>(true);
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: Stack(
        children: [
          WebView(
            key: _webViewKey,
            debuggingEnabled: false,
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_) {
              _isLoadingNotifier.value = false;
            },
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isLoadingNotifier,
            builder: (context, isLoading, _) {
              return isLoading ? const LoadingIndicator() : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
