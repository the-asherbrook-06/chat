// packages
import 'package:chat/screens/EditProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// pages
import 'screens/SplashPage.dart';
import 'screens/WelcomePage.dart';
import 'screens/RegisterPage.dart';
import 'screens/LoginPage.dart';
import 'screens/Dashboard.dart';

// themes
import 'themes/themeNotifier.dart';
import 'themes/theme.dart';
import 'themes/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: const Chat()));
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    TextTheme textTheme = createTextTheme(context, "Nunito Sans", "Nunito");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      themeMode: themeNotifier.themeMode,
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      initialRoute: '/splash',
      routes: {
        '/': (context) => const WelcomePage(),
        '/splash': (context) => const SplashPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(),
        '/editProfile': (context) => const EditProfilePage(),
      },
    );
  }
}
