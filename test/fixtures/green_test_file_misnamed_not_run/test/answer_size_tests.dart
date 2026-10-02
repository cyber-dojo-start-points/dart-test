import 'package:hiker/hiker.dart';
import 'package:test/test.dart';

void main() {
  test('the answer is less than 10', () {
    expect(answer(), lessThan(10));
  });
}
