import 'package:avenue/view/bottom_view/avenue_account.dart';
import 'package:avenue/view/bottom_view/avenue_favorite.dart';
import 'package:avenue/view/bottom_view/avenue_library.dart';
import 'package:avenue/view/bottom_view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomView extends StatefulWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  int currentIndex = 0;
  List<Widget> items = [
    const Home(),
    const avenueLibrary(),
    const avenueFavorite(),
    const avenueAccount()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapPage,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_rounded),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
        body: items[currentIndex],
      ),
    );
  }

  void onTapPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
