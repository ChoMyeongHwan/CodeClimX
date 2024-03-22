import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final String? communityApiKey = dotenv.env['COMMUNITY_API_KEY'];
  static final String? baseUrl = dotenv.env['BASE_URL'];
  static final bool debug = dotenv.env['DEBUG'] == 'true';
}
