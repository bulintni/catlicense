import 'package:catlicense/firebase_options.dart';
import 'package:catlicense/provider/CatViewModel.dart';
import 'package:catlicense/screen/FormScreen.dart';
import 'package:catlicense/screen/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<FirebaseApp> initializeFirebase() async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // ใช้ options จาก firebase_options.dart
  );
}

void main() async {
  // เริ่มต้น Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: FirebaseInitializer(),
    );
  }
}

class FirebaseInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error initializing Firebase: ${snapshot.error}'),
            ),
          );
        } else {
          return MyHomePage(title: 'Flutter Demo Home Page');
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final CatViewModel catViewModel = CatViewModel();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png'), // ใส่โลโก้ตรงนี้
          ),
          title: const Text(
            "CatApps",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue[200],
        ),
        body: TabBarView(
            children: [Home(viewModel: widget.catViewModel), Formscreen()]),
        bottomNavigationBar: const TabBar(tabs: [
          Tab(
            text: "แมวของฉัน",
          ),
          Tab(text: "ติดต่อเรา")
        ]),
      ),
    );
  }
}
