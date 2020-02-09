import 'package:carousel_demo/repos/endpoint.dart';
import 'package:carousel_demo/repos/implement/user_repo_impl.dart';
import 'package:carousel_demo/repos/remote/remote_provider.dart';
import 'package:carousel_demo/screens/carousel_screen.dart';
import 'package:carousel_demo/screens/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
  UserRepo _userRepo;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserRepo userRepo = UserRepoImpl();
    Widget tree = MaterialApp(
      title: 'Carousel Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CarouselScreen(),
    );
    tree = PropertyChangeProvider(value: _checkAccountBloc, child: tree);
    return tree;
  }
}*/
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserBloc _userBloc;
  RemoteProvider _remoteProvider;

  @override
  void initState() {
    super.initState();
    _remoteProvider = RemoteProvider(baseUrl: Endpoint.baseUrl);
    _userBloc =
        UserBloc(userRepo: UserRepoImpl(remoteProvider: _remoteProvider));
  }

  @override
  Widget build(BuildContext context) {
    Widget tree = MaterialApp(
      title: 'Carousel Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CarouselScreen(),
    );
    tree = PropertyChangeProvider(value: _userBloc, child: tree);
    return tree;
  }
}
