import 'package:logging/logging.dart';

class EnvironmentConfig {
  static const APP_ENV = String.fromEnvironment('APP_ENV', defaultValue: "dev");

  static bool isDevEnv() {
    return APP_ENV == "dev" || APP_ENV == "development";
  }

  static bool isProductionEnv() {
    return APP_ENV == "prod" || APP_ENV == "production";
  }

  static bool isTestEnv() {
    return APP_ENV == "test";
  }

  static Level getLogLevel() {
    if (isProductionEnv()) {
      return Level.OFF;
    }
    return Level.ALL;
  }
}
