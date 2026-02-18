import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String baseUrl = dotenv.env['TMDB_BASE_URL']!;
  static String apiKey = dotenv.env['TMDB_API_KEY']!;
}
