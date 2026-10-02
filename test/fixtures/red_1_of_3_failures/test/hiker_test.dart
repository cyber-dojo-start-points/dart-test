import 'package:hiker/hiker.dart';
import 'package:test/test.dart';

void main() {
  test('life, the universe and everything', () {
    expect(answer(), equals(42));
  });

  test('the answer is even', () {
    expect(answer().isEven, isTrue);
  });

  test('the answer has two digits', () {
    expect(answer().toString(), hasLength(2));
  });
}
