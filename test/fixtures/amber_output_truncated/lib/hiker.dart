int answer() {
  var total = 0;
  for (var i = 0; i < 5000; i++) {
    print('debug: i is $i, total is $total');
    total += i;
  }
  return 6 * 9;
}
