import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0 &&
        difference.inHours == 0 &&
        difference.inMinutes == 0 &&
        difference.inSeconds < 10) {
      return 'Just now';
    } else if (difference.inDays == 0 &&
        difference.inHours == 0 &&
        difference.inMinutes == 0 &&
        difference.inSeconds < 60) {
      return '${difference.inMinutes} seconds ago';
    } else if (difference.inDays == 0 &&
        difference.inHours == 0 &&
        difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays == 0 && difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      final format = DateFormat.yMEd().add_jms();
      return format.format(date);
    }
  }
}
