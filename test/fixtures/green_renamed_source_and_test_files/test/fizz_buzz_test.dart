import 'package:hiker/fizz_buzz.dart';
import 'package:test/test.dart';

void main() {
  test('multiples of 3 are Fizz', () {
    expect(fizzBuzz(9), equals('Fizz'));
  });

  test('multiples of 15 are FizzBuzz', () {
    expect(fizzBuzz(30), equals('FizzBuzz'));
  });
}
