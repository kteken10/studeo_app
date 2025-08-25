import 'package:flutter/material.dart';
import 'package:studapart_mobile/data/notification.dart';
import 'package:studapart_mobile/ui/notification_card.dart';
import '../constants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Supprimer une notification
  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  // Marquer une notification comme lue
  void _markAsRead(int index) {
    setState(() {
      notifications[index].isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.ternary[900],
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'Aucune notification',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return NotificationCard(
                  title: item.title,
                  description: item.description,
                  dateTime: item.dateTime,
                  icon: Icons.notifications,
                  isRead: item.isRead,
                  onTap: () => _markAsRead(index),
                  onDelete: () => _deleteNotification(index),
                );
              },
            ),
    );
  }
}
