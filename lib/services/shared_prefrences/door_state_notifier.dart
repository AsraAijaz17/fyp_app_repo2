import 'package:firebase_database/firebase_database.dart';
import 'notification_service.dart';

class DoorStateNotifier {
  final NotificationService _notificationService;
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref();

  DoorStateNotifier(this._notificationService);

  void startListening() {
    _databaseRef.child('DoorState').onValue.listen((event) {
      if (event.snapshot.value != null) {
        int doorState = event.snapshot.value as int;

        if (doorState == 1) {
          _notificationService.showNotification(
            'Door Alert',
            'The door has been opened!',
          );
        }
      }
    });
  }

  void stopListening() {
    _databaseRef.child('DoorState').onDisconnect();
  }
}
