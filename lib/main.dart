import 'package:chat_app/services/auth.dart';
import 'package:chat_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lentkgvmeqgnblifzmbx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxlbnRrZ3ZtZXFnbmJsaWZ6bWJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYzNzk3NzgsImV4cCI6MjAzMTk1NTc3OH0.xprm57V7wT7yJjBW1BfOSB_5sgvg2xzjI1307DrYrM0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Chat App',
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}
