import 'package:flutter/material.dart';

void main() => runApp(AlMurasilApp());

class AlMurasilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Al-Murasil Hajj - አል-ሙራሲል"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mosque, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text("እንኳን ደህና መጡ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Hac Rehberine Hoş Geldiniz", style: TextStyle(fontSize: 18)),
              Text("مرحباً بكم في دليل الحج", style: TextStyle(fontSize: 20, color: Colors.green)),
              Text("Welcome to Hajj Guide", style: TextStyle(fontSize: 16)),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {}, 
                child: Text("ዱዓዎችና ሀዲሶች / Hadisler", style: TextStyle(color: Colors.white))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
s