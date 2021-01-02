import 'package:flutter/material.dart';
import 'package:test_haber_proje/screens/news_detail.dart';
import 'package:test_haber_proje/screens/setting_screen.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';
import 'package:test_haber_proje/utilities/helper/ui_helper.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  NewsScreen() : super();

  final String title = 'RSS Feed Demo';
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String rssUrl = "https://www.aa.com.tr/tr/rss/default?cat=guncel";
  GlobalKey<RefreshIndicatorState> _refreshKey;
  TextEditingController _searchController;

  RssFeed _feed;

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _searchController = TextEditingController();
    _load();
  }

  _getRssFeed() async {
    try {
      final client = http.Client();
      final rssResponse = await client.get(rssUrl);
      return RssFeed.parse(rssResponse.body);
    } catch (e) {}
  }

  _load() async {
    _getRssFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        return;
      }
      _updateFeed(result);
    });
  }

  _updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _body(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: _buildTextField(),
      actions: <Widget>[
        _clearSearchActionButton(),
        _settingsActionButton(context),
      ],
    );
  }

  _buildTextField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: UITextHelper.search,
        border: InputBorder.none,
      ),
      onSubmitted: (String keyword) => {filterNews(keyword)},
    );
  }

  _clearSearchActionButton() {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () => {
        this.setState(
          () {
            _searchController.clear();
            _load();
            FocusScope.of(context).unfocus();
          },
        ),
      },
    );
  }

  _settingsActionButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
      onPressed: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingScreen(),
          ),
        ),
      },
    );
  }

  _list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: UIHelper.newsTitle(item.title),
          leading: UIHelper.newsThumbnail(item.imageUrl),
          trailing: UIHelper.newsRightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsDetail(
                linkUrl: item.link,
                linkTitle: item.title,
              ),
            ),
          ),
        );
      },
    );
  }

  _isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  _body() {
    return _isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: _list(),
            onRefresh: () => _load(),
          );
  }

  filterNews(String keyword) {
    List<RssItem> dummySearchList = List();
    dummySearchList.addAll(_feed.items);
    if (keyword.isNotEmpty) {
      List<RssItem> dummyListData = List();
      dummySearchList.forEach((items) {
        if (items.title.toLowerCase().contains(keyword.toLowerCase())) {
          dummyListData.add(items);
        }
      });
      setState(() {
        _feed.items.clear();
        _feed.items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _feed.items.clear();
        _load();
      });
    }
  }
}
