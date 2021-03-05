library prettier_log;

import 'package:intl/intl.dart' show DateFormat;
import 'package:logging/logging.dart';

const String TAG_RESET = "\u001b[0m";
const String TAG_COLOR_ERROR = "\u001b[31m";
const String TAG_COLOR_WARNING = "\u001b[33m";
const String TAG_COLOR_INFO = "\u001b[34m";
const String TAG_UNDERLINE = "\u001b[4m";

class PrettierLog {
  static PrettierLog _instance;
  static Logger _logger;
  static final _dateFormatter = DateFormat('H:m:s.S');
  static const appName = 'PrettierLog';

  PrettierLog._internal(String logName) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_recordHandler);

    _logger = Logger(logName ?? appName);
    _instance = this;
  }

  factory PrettierLog() => _instance ?? PrettierLog._internal(null);

  factory PrettierLog.setup(String logName) => _instance ?? PrettierLog._internal(logName);

  void _recordHandler(LogRecord rec) {
    if (rec.level == Level.SHOUT) {
      _printLogWithColor(TAG_COLOR_ERROR, rec);
    } else if (rec.level == Level.INFO) {
      _printLogWithColor(TAG_COLOR_INFO, rec);
    } else if (rec.level == Level.WARNING) {
      _printLogWithColor(TAG_COLOR_WARNING, rec);
    } else {
      _printLogWithColor(null, rec);
    }
  }

  void _printLogWithColor(String markColor, LogRecord rec) {
    if (markColor == null) {
      print('$TAG_UNDERLINE${rec.loggerName}:$TAG_RESET ${_dateFormatter.format(rec.time)}: ${rec.message}');
      return;
    }
    print(
        '$TAG_UNDERLINE$markColor${rec.loggerName}:$TAG_RESET $markColor${_dateFormatter.format(rec.time)}: ${rec.message}$TAG_RESET');
  }

  void log(message, [Object error, StackTrace stackTrace]) => _logger.fine(message, error, stackTrace);

  void logD(message, [Object error, StackTrace stackTrace]) => _logger.info(message, error, stackTrace);

  void logE(message, [Object error, StackTrace stackTrace]) => _logger.shout(message, error, stackTrace);

  void logW(message, [Object error, StackTrace stackTrace]) => _logger.warning(message, error, stackTrace);

  void disable() {
    Logger.root.level = Level.OFF;
  }
}
