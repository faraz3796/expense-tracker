import 'package:expense_tracker/providers/add_expense_provider.dart';
import 'package:expense_tracker/providers/dashboard_provider.dart';
import 'package:expense_tracker/providers/register_provider.dart';
import 'package:expense_tracker/providers/signin_provider.dart';
import 'package:expense_tracker/views/bottom_bar/bottom_bar.dart';
import 'package:expense_tracker/views/signin_screen/signin_screen.dart';
import 'package:expense_tracker/views/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SignInProvider()),
      ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ChangeNotifierProvider(create: (_) => AddExpenseProvider()),
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: _buildTheme(),
      //home: MyBottomBar(),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (auth.currentUser == null) {
            return SignInScreen();
          } else {
            return MyBottomBar();
          }
        },
      ),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.inriaSansTextTheme(baseTheme.textTheme),
    );
  }
}
