import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:warmindo/login.dart';
import 'package:warmindo/add_order.dart';
import 'package:warmindo/order_list.dart';
import 'package:warmindo/dashboard.dart';

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
        '/dashboard': (context) => const DashboardScreen(),
        '/add_order': (context) => const AddOrderScreen(),
        '/order_list': (context) => const ListTransaksi(
              title: 'ListTransaksi',
            ),
      },
    );
  }
}
