import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _transactionDetails = '';
  double _transactionTotal = 0.0;
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
          color: Colors.white,
          onPressed: () {
            // Navigate to the '/order_list' route and replace the current route
            Navigator.pushReplacementNamed(context, '/order_list');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        maxLines: null,
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
                          labelText: 'Nominal',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Enter transaction total',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.black),
                        initialValue: _transactionTotal.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Parse the entered value to double
                          _transactionTotal = double.tryParse(value) ?? 0.0;
                        },
                        // Format the total as IDR
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
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
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Form is valid, proceed to add data to Firestore
                            _formKey.currentState?.save();

                            // Generate a unique transaction number using the uuid package
                            String uniqueTransactionNumber = Uuid().v4();

                            // Set the transaction date to the current date and time
                            DateTime now = DateTime.now();
                            String formattedDate =
                                "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";

                            // Firestore reference to your collection
                            CollectionReference orders =
                                FirebaseFirestore.instance.collection('orders');

                            // Add data to Firestore
                            await orders.add({
                              'transactionNumber': uniqueTransactionNumber,
                              'transactionDate': formattedDate,
                              'transactionDetails': _transactionDetails,
                              'transactionTotal': _transactionTotal,
                              'transactionStatus': _transactionStatus,
                              'selectedPaymentMethod': _selectedPaymentMethod,
                            });

                            print('Order added to Firestore');
                            Navigator.pop(context);
                            _formKey.currentState?.reset();
                          }
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
