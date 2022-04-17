import 'package:flutter/material.dart';
import 'package:my_firstapp/account.dart';
import 'package:my_firstapp/add.dart';
import 'package:my_firstapp/chat.dart';
import 'package:my_firstapp/home_screen.dart';
import 'package:my_firstapp/my_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();

Box box = await Hive.openBox('contact-list');
// Box box = await Hive.openBox('user-email');
// box.clear();
// box.put("name", "Mahyia");
// print(box.get("name"),);





   runApp(
      const MyApp(),
   );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(428, 926),
        builder: () => MaterialApp(
              home: BottomNavController(),
            ));
  }
}

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;

  final _pages = [
    HomeScreen(),
    MyAds(),
    Add(),
    Chat(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "My Ads"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
        selectedItemColor: Color(0xFF5364F4),
        unselectedItemColor: Color(0xFFC4C4C40),
      ),
      body: _pages[_currentIndex],
    );
  }
}
