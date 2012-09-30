#library('unittests');

#import('package:unittest/unittest.dart');
#import('package:optionsfile/options.dart');

#import('dart:io');

class FileIOExceptionMatcher extends BaseMatcher {
  const FileIOExceptionMatcher();
  Description describe(Description description) => description.add("FileIOException");
  bool matches(item, MatchState matchState) => item is FileIOException;  
}

class FormatExceptionMatcher extends BaseMatcher {
  const FormatExceptionMatcher();
  Description describe(Description description) => description.add("FormatException");
  bool matches(item, MatchState matchState) => item is FormatException;  
}

void main() {
  test('Should throw exception when file is missing', () {
    expect((){
      new OptionsFile('bob');
    }, throwsA(new FileIOExceptionMatcher()));
  });

  test('Should not throw exception when file is present', () {
    new OptionsFile('pubspec.yaml');
  });
  
  test('Should read string value', () {
    var options = new OptionsFile('test/options');
    var name = options.getString("name");
    expect("James", name);
  });

  test('Should ignore space around keys', () {
    var options = new OptionsFile('test/options');
    var name = options.getString("name1");
    expect("James", name);

    name = options.getString("name2");
    expect("James", name);
  });
  
  test('Should read int value', () {
    var options = new OptionsFile('test/options');
    var age = options.getInt("age");
    expect(90, age);
  });
  
  test('Should throw format exception when reading bad int', () {
    var options = new OptionsFile('test/options');
    expect((){
      var age = options.getInt("name");
    }, throwsA(new FormatExceptionMatcher()));
  });

  test('Should ignore comment lines', () {
    var options = new OptionsFile('test/options');
    var thing = options.getInt("thing");
    expect(null, thing);
  });
  
  test('Should use default string value when option is missing', () {
    var options = new OptionsFile('test/options');
    var wibble = options.getString("wibble", "default");
    expect("default", wibble);
  });
  
  test('Should use default int value when option is missing', () {
    var options = new OptionsFile('test/options');
    var wibble = options.getInt("wibble", 123);
    expect(123, wibble);
  });
  
  test('Should use default string value from default file when option is missing', () {
    var options = new OptionsFile('test/options', 'test/defaultoptions');
    var wibble = options.getString("thing");
    expect("default", wibble);
  });
  
  test('Should use default int value from default file when option is missing', () {
    var options = new OptionsFile('test/options', 'test/defaultoptions');
    var wibble = options.getInt("number");
    expect(12, wibble);
  });
  
  test('Should use default string value when option is missing in both files', () {
    var options = new OptionsFile('test/options', 'test/defaultoptions');
    var wibble = options.getString("thing2", "xyz");
    expect("xyz", wibble);
  });
  
  test('Should use default int value when option is missing in both files', () {
    var options = new OptionsFile('test/options', 'test/defaultoptions');
    var wibble = options.getInt("number2", 123);
    expect(123, wibble);
  });
}