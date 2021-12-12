import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationApi {
  Future<void> getPermissions() async {
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future<void> showNotification(
      String channelKey, String title, String body) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0, channelKey: channelKey, title: title, body: body));
  }
}
