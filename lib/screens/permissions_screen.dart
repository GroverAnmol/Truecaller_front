import 'package:untitled36/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled36/helpers.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});
  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  late Widget content = const Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    PermissionStatus statusPhone = await Permission.phone.status;
    PermissionStatus statusContacts = await Permission.contacts.status;

    if (statusPhone.isGranted && statusContacts.isGranted) {
      _openTabsScreen();
    }
    if (statusContacts.isPermanentlyDenied || statusPhone.isPermanentlyDenied) {
      await openAppSettings();
      _closeApp();
    } else {
      _getCallsPermissions();
    }
  }

  void _getCallsPermissions() async {
    PermissionStatus statusPhone = await Permission.phone.request();
    PermissionStatus statusContacts = await Permission.contacts.request();

    if (statusPhone.isGranted && statusContacts.isGranted) {
      _openTabsScreen();
    }
    if (statusContacts.isPermanentlyDenied || statusPhone.isPermanentlyDenied) {
      await openAppSettings();
      _closeApp();
    } else {
      setState(() {
        content = messenger(
            closeAppFunction: _closeApp, allowFunction: _getCallsPermissions);
      });
    }
  }

  void _openTabsScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const TabsScreen(),
    ));
  }

  void _closeApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content,
    );
  }
}