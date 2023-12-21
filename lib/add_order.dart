import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _transactionNumber = '';
  String _transactionDate = '';
  String _transactionDetails = '';
  String _transactionTotal = '';
  String _transactionStatus = 'Pending';
  String _selectedPaymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Pesanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // Set the color to white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(10.0), // Add margin to the Card
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                // Wrap with SingleChildScrollView
                child: Column(
                  children: [
                    // Rekap pesanan
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'No. Transaksi',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter transaction number',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.black),
                        initialValue: _transactionNumber,
                        onSaved: (value) {
                          _transactionNumber = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tanggal',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter transaction date',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.black),
                        initialValue: _transactionDate,
                        onSaved: (value) {
                          _transactionDate = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        maxLines:
                            null, // Set maxLines to null for multiline input
                        decoration: InputDecoration(
                          labelText: 'Pesanan',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter transaction details',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.black),
                        initialValue: _transactionDetails,
                        onSaved: (value) {
                          _transactionDetails = value ?? '';
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Total',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter transaction total',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.black),
                        initialValue: _transactionTotal,
                        onSaved: (value) {
                          _transactionTotal = value ?? '';
                        },
                      ),
                    ),
                    // Informasi status
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            _transactionStatus = value.toString();
                          });
                        },
                        value: _transactionStatus,
                        items: [
                          DropdownMenuItem(
                            value: 'Pending',
                            child: Text('Pending'),
                          ),
                          DropdownMenuItem(
                            value: 'Done',
                            child: Text('Done'),
                          ),
                          DropdownMenuItem(
                            value: 'Failed',
                            child: Text('Failed'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Status',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    // Pilihan pembayaran
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value.toString();
                          });
                        },
                        value: _selectedPaymentMethod,
                        items: [
                          DropdownMenuItem(
                            value: 'Cash',
                            child: Text('Cash'),
                          ),
                          DropdownMenuItem(
                            value: 'Transfer',
                            child: Text('Transfer'),
                          ),
                          DropdownMenuItem(
                            value: 'Kredit',
                            child: Text('Kredit'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Pilihan Pembayaran',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    // Tombol selesaikan pesanan
                    SizedBox(
                        height:
                            16.0), // Add some space between the dropdown and the buttons
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.save();
                          // Handle update logic with the updated data
                        },
                        child: Text('Add Order'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
