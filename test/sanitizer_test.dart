library sanitizer_dart;

import 'package:validator/validator.dart' as s;


void test(Map options) {
  List args = options['args'];

  options['expect'].keys.forEach((input) {
    args.insert(0, input);

    var f = options["sanitizer"].toString();
    var result = Function.apply(options['sanitizer'], args);
    var expected = options['expect'][input];

    if (result != expected) {
      throw new Exception('sanitizer.$f($args) failed but should have passed');
    }
    args.removeAt(0);
  });
}


void testToString() {
  test({
    'sanitizer': s.toString,
    'args': [],
    'expect': {
      1: '1',
      1.5: '1.5',
      {1: 2}: '{1: 2}',
      null: ''
    }
  });
}


void testToDate() {
  test({
    'sanitizer': s.toDate,
    'args': [],
    'expect': {
      '2012-02-27 13:27:00': DateTime.parse('2012-02-27 13:27:00')
    }
  });
}


void main() {
  testToString();
  testToDate();

  print('-------------------------------------');
  print('All tests in sanitizer.dart complete.');
  print('-------------------------------------');
}