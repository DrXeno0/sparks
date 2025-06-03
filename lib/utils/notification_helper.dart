import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> notify({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const WindowsNotificationDetails windowsDetails =
          WindowsNotificationDetails();

      const NotificationDetails platformDetails = NotificationDetails(
        windows: windowsDetails,
      );

      await _notificationsPlugin.show(
        0, // Notification ID
        title,
        body,
        platformDetails,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }
}
