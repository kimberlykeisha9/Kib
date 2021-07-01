import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
	static final NotificationService _notificationService = NotificationService._internal();

	factory NotificationService() {
		return _notificationService;
	}

	NotificationService._internal();

	final FlutterLocalNotificationsPlugin flutterLocalNotifications = FlutterLocalNotificationsPlugin();

	Future<void> init() async {
		final AndroidInitializationSettings initializationSettingAndroid =
		AndroidInitializationSettings (
			'app_icon');

		final InitializationSettings initializationSettings = InitializationSettings (
			android: initializationSettingAndroid,
			iOS: null,
			macOS: null,
		);

		await flutterLocalNotifications.initialize (
			initializationSettings, onSelectNotification: selectNotification,);
	}

	Future selectNotification(String payload) async {
		// Handle tapped logic here
	}

	showLocalNotification(String id, String channelName, String channelDescription) async {
		AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
			id,
			channelName,
			channelDescription,
			importance: Importance.high,
			priority: Priority.high,
		);
		NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

		await flutterLocalNotifications.show(1, 'test', 'test', platformChannelSpecifics);
	}
}
