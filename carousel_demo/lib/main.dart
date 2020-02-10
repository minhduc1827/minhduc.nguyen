import 'package:carousel_demo/repos/endpoint.dart';
import 'package:carousel_demo/repos/implement/user_repo_impl.dart';
import 'package:carousel_demo/repos/remote/remote_provider.dart';
import 'package:carousel_demo/screens/carousel_screen.dart';
import 'package:carousel_demo/screens/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RemoteProvider _remoteProvider;
  @override
  void initState() {
    super.initState();
    _remoteProvider = RemoteProvider(baseUrl: Endpoint.baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<UserNotifier>(
        create: (_) =>
            UserNotifier(UserRepoImpl(remoteProvider: _remoteProvider)),
        child: CarouselScreen(),
      ),
    );
  }
}
