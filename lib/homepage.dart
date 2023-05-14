import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class MyHomePage extends StatelessWidget {
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _setupScrollListeners();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60.0,),
          _buildRowList(scrollController1),
          const SizedBox(height: 160.0), 
          _buildRowList(scrollController2),
        ],
      ),
    );
  }

  Widget _buildRowList(ScrollController scrollController) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 2, 
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 200.0, 
            height: 200.0,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
            ),
          );
        },
      ),
    );
  }

  void _setupScrollListeners() {
    scrollController1.addListener(_syncScrollPosition1To2);
    scrollController2.addListener(_syncScrollPosition2To1);
  }

  void _syncScrollPosition1To2() {
    if (_isScrolling(scrollController1)) {
      scrollController2.jumpTo(scrollController1.position.pixels);
    }
  }

  void _syncScrollPosition2To1() {
    if (_isScrolling(scrollController2)) {
      scrollController1.jumpTo(scrollController2.position.pixels);
    }
  }

  bool _isScrolling(ScrollController scrollController) {
    return scrollController.position.userScrollDirection != ScrollDirection.idle;
  }
}


