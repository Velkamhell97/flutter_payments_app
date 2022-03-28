// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Env {
  DEV,
  PROD
}

class Environment {
  static String getFileName(Env environment) {
    switch (environment) {
      case Env.DEV:
        return '.env.development';
      case Env.PROD:
        return '.env.production';
    } 
  }

  static String get apiUrl => dotenv.env['API_URL']!;
}