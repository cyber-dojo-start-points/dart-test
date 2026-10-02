import 'package:test/test.dart';

// Not a test of the kata. It shows some of the matchers expect() can take,
// on values written out in full, so it goes on passing whatever you change.
// It counts as one test in every total. Delete it whenever you like.
void main() {
  test('expect matchers', () {
    expect(6 * 7, equals(42));
    expect(42, isNot(equals(54)));
    expect(42, greaterThan(41));
    expect(0.1 + 0.2, closeTo(0.3, 0.0001));
    expect(1 < 2, isTrue);
    expect(null, isNull);
    expect('hitchhiker', contains('hike'));
    expect('hitchhiker', startsWith('hitch'));
    expect([4, 2], hasLength(2));
    expect([4, 2], orderedEquals([4, 2]));
    expect([4, 2], unorderedEquals([2, 4]));
    expect(<int>[], isEmpty);
    expect({'answer': 42}, containsPair('answer', 42));
    expect(() => throw StateError('no towel'), throwsStateError);
    expect(() => int.parse('six'), throwsA(isA<FormatException>()));
  });
}
