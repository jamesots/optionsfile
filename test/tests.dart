#library('unittests');

#import('package:unittest/unittest.dart');
#import('package:optionsfile/options.dart');

#import('dart:io');

class FileIOExceptionMatcher extends BaseMatcher {
  const FileIOExceptionMatcher();
  Description describe(Description description) => description.add("FileIOException");
  bool matches(item, MatchState matchState) => item is FileIOException;  
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
}