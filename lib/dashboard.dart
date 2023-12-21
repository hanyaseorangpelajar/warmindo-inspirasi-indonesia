import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDisposed = false; // Add this variable

  @override
  void dispose() {
    isDisposed = true; // Set the flag when the widget is disposed
    super.dispose();
  }

  bool isShiftPagiExpanded = false;
  bool isShiftSoreExpanded = false;
  bool isTransactionButtonVisible = false;
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    // Initialize Firebase Auth
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!isDisposed) {
        // Check if the widget is still mounted
        if (user != null) {
          setState(() {
            userEmail = user.email!;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _handleLogout();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70.0,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Petugas Dapur",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail, // Display the user's email
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 5, 5)),
                onPressed: () {
                  _handleLogout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              _buildShiftTile("Shift Pagi", "00.00 - 12.00", Icons.sunny,
                  isShiftPagiExpanded),
              const SizedBox(height: 30),
              _buildShiftTile("Shift Sore", "12.00 - 24.00", Icons.cloud,
                  isShiftSoreExpanded),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 92, 211, 84)),
                onPressed: _canAccessButtonBePressed(),
                child: Text(
                  "Masuk",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              if (isTransactionButtonVisible)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 41, 12, 185)), // Customize the color as needed
                  onPressed: () {
                    // Add logic for the transaction button press
                    Navigator.pushNamed(context, '/order_list');
                  },
                  child: Text(
                    "Transaksi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 235, 5, 5)),
                onPressed: () {
                  setState(() {
                    isShiftPagiExpanded = false;
                    isShiftSoreExpanded = false;
                    isTransactionButtonVisible =
                        false; // Hide transaction button when exiting
                  });
                },
                child: Text(
                  "Keluar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShiftTile(
      String title, String subtitle, IconData icon, bool isExpanded) {
    return InkWell(
      onTap: () {
        setState(() {
          // mengatur state ketika title nya shift pagi dan shift sore tidak aktif maka data di shift sore tidak tampil,
          if (title == "Shift Pagi" && !isShiftSoreExpanded) {
            isShiftSoreExpanded = false;
          } else if (title == "Shift Sore" && !isShiftPagiExpanded) {
            isShiftPagiExpanded = false;
          }
        });
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              leading: Icon(icon),
            ),
            if (isExpanded) buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      // Replace 'your_collection' with the actual Firestore collection name
      future: fetchDataFromFirestore('orders'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or another loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else {
          return DataTable(
            columns: ['transactionNumber', 'transactionDate']
                .map((header) => DataColumn(label: Text(header)))
                .toList(),
            rows: snapshot.data!.map((rowData) {
              return DataRow(
                cells: ['transactionNumber', 'transactionDate']
                    .map((field) => DataCell(Text(rowData[field].toString())))
                    .toList(),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirestore(
      String collection) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  void _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other screen after logout
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _handleAccessButtonPress() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;

    if ((hour >= 0 && hour < 12) || (hour == 12 && minute == 0)) {
      // Shift Pagi: 00:00 - 11:59
      setState(() {
        isShiftPagiExpanded = true;
        isShiftSoreExpanded = false;
        isTransactionButtonVisible =
            true; // Show transaction button for Shift Pagi
      });
    } else if (hour >= 12 && hour < 24) {
      // Shift Sore: 12:00 - 23:59
      setState(() {
        isShiftSoreExpanded = true;
        isShiftPagiExpanded = false;
        isTransactionButtonVisible =
            true; // Show transaction button for Shift Sore
      });
    } else {
      setState(() {
        isShiftSoreExpanded = false;
        isShiftPagiExpanded = false;
        isTransactionButtonVisible =
            false; // Hide transaction button outside shift hours
      });
      print("Button pressed outside the specified time range.");
    }
  }

  void Function()? _canAccessButtonBePressed() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if ((isShiftPagiExpanded || isShiftSoreExpanded) &&
        (hour >= 0 && hour < 12 || hour >= 12 && hour < 24)) {
      // Disable the button when a shift is active
      return null;
    }

    return () {
      _handleAccessButtonPress();
    };
  }
}
