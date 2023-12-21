import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutte',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListTransaksi(title: 'List Transaksi'),
    );
  }
}

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key, required this.title});

  final String title;

  @override
  State<ListTransaksi> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Transaksi'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              title: Text('#pesanan01'),
              subtitle: Text('es teh 1x'),
            ),
          );
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
    );
  }
}
