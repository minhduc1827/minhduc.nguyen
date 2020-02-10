import 'package:carousel_demo/common/base_state.dart';
import 'package:carousel_demo/repos/flt_exception.dart';
import 'package:carousel_demo/screens/user_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends BaseState<CarouselScreen> {
  UserBloc _userBloc;
  List<String> _imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<Widget> _buildImageWidgets() {
    List<Widget> widgets = [];
    for (String url in _imgList) {
      widgets.add(
        Container(
          child: Image.network(
            url,
            fit: BoxFit.cover,
            width: 100.0,
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    if (_userBloc == null) {
      _userBloc = providerOfBloc();
    }
    _getUser();
  }

  void _getUser() async {
    try {
      _userBloc.getUser();
    } on FltException catch (e) {
      print('Carousel get user exception=${e.message}');
    }
  }

  @override
  Widget buildChild(BuildContext context) {
    return PropertyChangeConsumer<UserBloc>(
      properties: [UserBlocProperties.serverError, UserBlocProperties.complete],
      builder: (context, bloc, property) {
        // ignore: unrelated_type_equality_checks
        if (property == UserBlocProperties.complete) {
          print('user bloc @userModel=${bloc.userModel}');
          return Container(
            child: CarouselSlider(
              items: _buildImageWidgets(),
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            ),
          );
        } else {
          return Container(
            child: CarouselSlider(
              items: _buildImageWidgets(),
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            ),
          );
        }
      },
    );
  }
}
