library options;

import 'dart:io';
import 'dart:math';

/**
 * [OptionsFile] reads options from a file. The options must be stored in name=value pairs, one pair per line. E.g.:
 *   name=James
 *   age=9
 *   height=256
 * The key on the left of the equals sign (=) is trimmed, but the value to the right of the equals sign is
 * not trimmed - the user must trim spaces. Any line which starts with a hash (#) is ignored.
 * Any line which does not contain an equals sign is ignored.
 */
class OptionsFile {
  Map<String, String> _map;
  
  /**
   * Load options from the file called [filename], with defaults in the [defaults] file.
   */
  OptionsFile(String filename, [String defaults]) {
    _map = <String>{};
    if (?defaults) {
      var defaultOptions = new File(defaults);
      _readOptions(defaultOptions);
    }
    var options = new File(filename);
    _readOptions(options);
  }
  
  void _readOptions(File options) {
    if (options.existsSync()) {
      var lines = options.readAsLinesSync();
      for (var line in lines) {
        if (!line.startsWith('#')) {
          var i = line.indexOf('=');
          if (i > -1) {
            var name = line.substring(0, i).trim();
            var value = line.substring(i + 1);
            _map[name] = value;
          }
        }
      }
    } else {
      throw new FileIOException("File not found");
    }
  }
  
  String operator[](String key) => _map[key];
  
  int getInt(String key, [int defaultValue]) {
    var value = _map[key];
    if (value == null) {
      return defaultValue;
    }
    return int.parse(value);
  }
  
  String getString(String key, [String defaultValue]) {
    var value = _map[key];
    if (value != null) {
      return value;
    }
    return defaultValue;
  }
}