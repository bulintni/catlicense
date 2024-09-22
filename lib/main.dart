import 'package:catlicense/provider/CatViewModel.dart';
import 'package:catlicense/screen/FormScreen.dart';
import 'package:catlicense/screen/Home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page' ),
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png'), // ใส่โลโก้ตรงนี้
          ),
          title: Text(
            "CatApps",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.blue[200],
        ),
        body: TabBarView(children: [Home(viewModel: widget.catViewModel), Formscreen()]),
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
