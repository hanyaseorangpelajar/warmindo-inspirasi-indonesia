import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDeleteScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const UpdateDeleteScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  _UpdateDeleteScreenState createState() => _UpdateDeleteScreenState();
}

class _UpdateDeleteScreenState extends State<UpdateDeleteScreen> {
  late String _transactionDetails;
  late double _transactionTotal;
  late String _transactionStatus;
  late String _selectedPaymentMethod;

  TextEditingController _detailsController = TextEditingController();
  TextEditingController _totalController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _paymentMethodController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _transactionDetails = widget.orderData['transactionDetails'];
    _transactionTotal = widget.orderData['transactionTotal'];
    _transactionStatus = widget.orderData['transactionStatus'];
    _selectedPaymentMethod = widget.orderData['selectedPaymentMethod'];

    _detailsController.text = _transactionDetails;
    _totalController.text = _transactionTotal.toString();
    _statusController.text = _transactionStatus;
    _paymentMethodController.text = _selectedPaymentMethod;
  }

  Future<void> fetchData() async {
    String transactionNumber = widget.orderData['transactionNumber'];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .where('transactionNumber', isEqualTo: transactionNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> updatedData =
          querySnapshot.docs.first.data() as Map<String, dynamic>;

      setState(() {
        _transactionDetails = updatedData['transactionDetails'];
        _transactionTotal = updatedData['transactionTotal'];
        _transactionStatus = updatedData['transactionStatus'];
        _selectedPaymentMethod = updatedData['selectedPaymentMethod'];
      });
    } else {
      print("Document with transactionNumber $transactionNumber not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update/Delete Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Transaction Number: ${widget.orderData['transactionNumber']}'),
            TextFormField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Transaction Details'),
            ),
            TextFormField(
              controller: _totalController,
              decoration: InputDecoration(labelText: 'Transaction Total'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Transaction Status'),
            ),
            TextFormField(
              controller: _paymentMethodController,
              decoration: InputDecoration(labelText: 'Payment Method'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String transactionNumber =
                        widget.orderData['transactionNumber'];

                    // Get a reference to the document
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection("orders")
                        .where('transactionNumber',
                            isEqualTo: transactionNumber)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      String documentID = querySnapshot.docs.first.id;

                      // Update the document with new data
                      await FirebaseFirestore.instance
                          .collection("orders")
                          .doc(documentID)
                          .update({
                        'transactionDetails': _detailsController.text,
                        'transactionTotal': double.parse(_totalController.text),
                        'transactionStatus': _statusController.text,
                        'selectedPaymentMethod': _paymentMethodController.text,
                      });

                      // Fetch updated data
                      await fetchData();

                      print("Document updated");
                      Navigator.pop(context);
                    } else {
                      print(
                          "Document with transactionNumber $transactionNumber not found");
                    }
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String transactionNumber =
                        widget.orderData['transactionNumber'];

                    FirebaseFirestore.instance
                        .collection("orders")
                        .where('transactionNumber',
                            isEqualTo: transactionNumber)
                        .get()
                        .then((querySnapshot) {
                      if (querySnapshot.docs.isNotEmpty) {
                        String documentID = querySnapshot.docs.first.id;
                        FirebaseFirestore.instance
                            .collection("orders")
                            .doc(documentID)
                            .delete()
                            .then(
                          (doc) {
                            print("Document deleted");
                            Navigator.pop(context);
                          },
                          onError: (e) => print("Error deleting document: $e"),
                        );
                      } else {
                        print(
                            "Document with transactionNumber $transactionNumber not found");
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
