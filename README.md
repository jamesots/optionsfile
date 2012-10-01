optionsfile
===========

Dart library for reading options files


Usage
=====


    OptionsFile options = new OptionsFile('example/local.options', 'example/default.options');
  
    String user = options.getString('user', 'bob');
    int port = options.getInt('port', 1234);
