import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(
    RegExp(' +'),
    ' ',
  ).split(' ').map((str) => str.toCapitalized).join(' ');
}

String getInitials(String name) {
  final parts = name.trim().split(' ');
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

String getReleaseYear(String? releaseDate) {
  if (releaseDate != null && releaseDate.isNotEmpty) {
    try {
      return DateFormat.y().format(DateTime.parse(releaseDate));
    } catch (_) {
      return 'Unknown';
    }
  }
  return 'Unknown';
}
