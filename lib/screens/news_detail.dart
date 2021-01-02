import 'package:flutter/material.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:share/share.dart';

class NewsDetail extends StatefulWidget {
  final linkUrl;
  final linkTitle;
  const NewsDetail({Key key, this.linkUrl, this.linkTitle}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  _NewsDetailState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.linkTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                  '${widget.linkTitle} \n\n${widget.linkUrl} \n\n${UITextHelper.shared}',
                  subject: widget.linkTitle,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: widget.linkUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
