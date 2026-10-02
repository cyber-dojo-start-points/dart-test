import 'package:hiker/hiker.dart';
import 'package:test/test.dart';

void main() {
  test('life, the universe and everything', () {
    expect(answer(), equals(42));
  });

  test('the answer is a multiple of 7', () {
    expect(answer() % 7, equals(0));
  });

  test('the answer ends in 2', () {
    expect(answer().toString(), endsWith('2'));
  });
}
