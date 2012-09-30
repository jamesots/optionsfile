#library('unittests');

#import('package:unittest/unittest.dart');
#import('package:optionsfile/options.dart');

#import('dart:io');

void main() {
  test('Should throw exception when file is missing', () {
    try {
      new OptionsFile('bob');
    } on FileIOException catch (e) {
      return;
    }
    expect(false);
  });
}