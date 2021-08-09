import 'package:app/history_page.dart';
import 'package:app/home_page.dart';
import 'package:app/login_page.dart';
import 'package:app/main.dart';
import 'package:app/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/User.dart';
import 'package:app/stats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*hey */
// ignore: must_be_immutable
enum WhyFarther { deconnexion, profil }

class HomePage extends StatefulWidget {
  //HomePage({Key? key, @required User}) : super(key: key);
  final User user;
  const HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  late User user1;
  late SharedPreferences pref;
  late WhyFarther _selection;

  @override
  HomePage get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      StatsPage(user: widget.user),
      AvisGoo(user: widget.user),
      HistoryPage(user: widget.user),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0.5),
              child: Image.asset(
                'assets/logo.png',
                height: 70,
                width: 150,
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        actionsIconTheme:
            IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 0.0),
              child: PopupMenuButton<WhyFarther>(
                onSelected: (WhyFarther result) {
                  setState(() {
                    _selection = result;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<WhyFarther>>[
                  PopupMenuItem<WhyFarther>(
                    value: WhyFarther.profil,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(user: widget.user)),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10.0)),
                          Text("Mon Profil")
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<WhyFarther>(
                    value: WhyFarther.deconnexion,
                    child: MaterialButton(
                      onPressed: () {
                        SharedPreferences.getInstance().then((value) {
                          value.setString("UID", "");
                          value.setBool("isLoggedIn", false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage(title: "")));
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10.0)),
                          Text("Se déconnecter")
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
      bottomNavigationBar: botNavBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      print(_selectedIndex);
      _selectedIndex = index;
    });
  }

  Widget botNavBar() {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart),
          label: 'Statistiques',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.send,
          ),
          label: 'AvisGoo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historique',
        ),
      ],
    );
  }
}
