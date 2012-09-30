optionsfile
===========

Dart libaray for reading options files


usage
=====

OptionsFile options = new OptionsFile('example/local.options', 'example/default.options');
  
String user = options.getString('user', 'bob');
int port = options.getInt('port', 1234);
