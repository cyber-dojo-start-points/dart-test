
lambda { |stdout,stderr,status|
  output = stdout + stderr
  # A test file that does not compile is reported as a failed test named
  # "loading <file>", and counted in the summary as a failure, so it is
  # checked before red: no test in it ran.
  return :amber if /^\d+:\d\d \+\d+.*: loading \S+ \[E\]$/.match(output)
  # package:test catches whatever a test throws, an exception as much as a
  # failed expect, and counts it as a failure in the same summary.
  return :red   if /^\d+:\d\d \+\d+( ~\d+)? -\d+: Some tests failed\.$/.match(output)
  # Green needs one test to have passed at least. A kata whose tests are all
  # skipped exits zero too, and says "All tests skipped." instead.
  return :green if status == 0 && /^\d+:\d\d \+[1-9]\d*( ~\d+)?: All tests passed!$/.match(output)
  return :amber
}
