
  
// Classe de modèle simple pour la notification
class NotificationItem {
  final String title;
  final String description;
  final DateTime dateTime;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isRead = false,
  });
}

  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Nouvelle offre disponible',
      description: 'Découvrez nos dernières offres de logement.',
      dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      title: 'Rappel paiement',
      description: 'Votre loyer est dû demain.',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      title: 'Message du propriétaire',
      description: 'Le propriétaire a répondu à votre demande.',
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
    ),
  ];