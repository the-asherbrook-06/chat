// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// auth
import '../../auth/Auth.dart';

// components
import '../../components/ProfilePicture.dart';
import '../../components/QuotesContainer.dart';

// themes
import '../../themes/themeNotifier.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  Auth auth = Auth();
  User? user;

  void _showThemeSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose Theme", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 24),
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedSun02),
                title: Text("Light Theme"),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false).setTheme(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedMoon01),
                title: Text("Dark Theme"),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false).setTheme(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedDarkMode),
                title: Text("System Default"),
                onTap: () {
                  Provider.of<ThemeNotifier>(context, listen: false).setTheme(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    user = auth.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeNotifier>(context).themeMode;

    String getThemeLabel(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return "Light";
        case ThemeMode.dark:
          return "Dark";
        case ThemeMode.system:
          return "System";
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  ProfilePicture(user: user, radius: 60),
                  SizedBox(height: 16),
                  Text(
                    user?.displayName ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(user!.email ?? "Email", style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    user!.uid,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 14),
                  TextButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, "/editProfile");
                      await FirebaseAuth.instance.currentUser?.reload();
                      setState(() {
                        user = auth.getUserData();
                      });
                    },
                    child: Text("Edit Profile"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          QuotesContainer(),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Settings", style: Theme.of(context).textTheme.headlineMedium),
                  Divider(),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Theme", style: Theme.of(context).textTheme.bodyLarge),
                        Row(
                          children: [
                            Text(
                              getThemeLabel(themeMode),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => _showThemeSwitcher(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
