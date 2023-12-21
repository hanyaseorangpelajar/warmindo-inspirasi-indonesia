import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:warmindo/login.dart';
import 'package:warmindo/transaction_details.dart';
import 'package:warmindo/add_order.dart';
import 'package:warmindo/order_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/transaction_details': (context) => const TransactionDetailsScreen(),
        '/add_order': (context) => const OrderDetailsScreen(),
        '/order_list': (context) => const OrderListScreen(),
      },
    );
  }
}
