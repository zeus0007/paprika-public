import 'package:flutter/material.dart';

class AppBase extends StatelessWidget {
  AppBase(
      {@required this.needAppBar,
      @required this.body,
      this.title = '',
      this.hideBackButton = false,
      this.needNavigatonBar = false,
      this.currentIndex = 0,
      this.onTap});
  final bool needAppBar;
  final bool needNavigatonBar;
  final bool hideBackButton;
  final String title;
  final Widget body;
  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: needAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                title,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
              ),
              iconTheme: IconThemeData(size: 15.0),
              automaticallyImplyLeading: !hideBackButton,
            )
          : null,
      backgroundColor: Colors.white,
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: body),
      bottomNavigationBar: needNavigatonBar
          ? BottomNavigationBar(
              elevation: 1,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Color(0xFF8E8E93),
              selectedFontSize: 14,
              unselectedFontSize: 11,
              items: [
                buildBottomNavigationBarItem(icon: Icons.home),
                buildBottomNavigationBarItem(icon: Icons.leaderboard),
                buildBottomNavigationBarItem(icon: Icons.add_circle),
                buildBottomNavigationBarItem(icon: Icons.notifications),
                buildBottomNavigationBarItem(icon: Icons.person),
              ],
              currentIndex: currentIndex,
              onTap: onTap,
            )
          : null,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({IconData icon}) {
    return BottomNavigationBarItem(
      label: '',
      icon: Icon(
        icon,
      ),
    );
  }
}
