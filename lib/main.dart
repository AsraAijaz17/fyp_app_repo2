import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:theiotlab/SplashScreen/splash_screen.dart';
import 'package:theiotlab/firebase_options.dart';
import 'package:theiotlab/services/shared_prefrences/door_state_notifier.dart';
import 'package:theiotlab/services/shared_prefrences/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationWrapper(),
    );
  }
}

class NotificationWrapper extends StatefulWidget {
  const NotificationWrapper({super.key});

  @override
  NotificationWrapperState createState() => NotificationWrapperState();
}

class NotificationWrapperState extends State<NotificationWrapper> {
  late NotificationService _notificationService;
  late DoorStateNotifier _doorStateNotifier;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    // Initialize notification service
    _notificationService = NotificationService();
    await _notificationService.initialize();

    // Initialize real-time database listener for door state
    _doorStateNotifier = DoorStateNotifier(_notificationService);
    _doorStateNotifier.startListening();
  }

  @override
  void dispose() {
    _doorStateNotifier.stopListening(); // Clean up the listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(
      username: "",
      email: "",
    );
  }
}
