import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warmindo/transaction_details.dart';

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListTransaksi> createState() => _List();
}

class _List extends State<ListTransaksi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode:
          ThemeMode.system, // Set to dark, light, or system to auto switch

      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
              Text('Daftar Transaksi', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var orders = snapshot.data!.docs;

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index].data() as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateDeleteScreen(orderData: order),
                          ),
                        );
                      },
                      title: Text(order['transactionNumber'] ?? ''),
                      subtitle: Text(order['transactionDetails'] ?? ''),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data from Firestore'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_order');
          },
          backgroundColor: Color(0xFF03A54F),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
