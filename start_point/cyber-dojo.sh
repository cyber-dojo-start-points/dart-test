set -e

# Text files left under /sandbox come back to you as new files, so what dart
# generates here is removed on the way out.
source ~/cyber_dojo_fs_cleaners.sh
function cyber_dojo_exit()
{
  cyber_dojo_delete_dirs .dart_tool
  cyber_dojo_delete_files pubspec.lock
}
trap cyber_dojo_exit EXIT SIGTERM

readonly HELD=$(mktemp -d)

# There is no network. Every package this kata can use is already in the
# pub cache, so a dependency added to pubspec.yaml that is not there fails
# here. Its output is only shown when it fails.
if ! dart pub get --offline > ${HELD}/pub 2>&1; then
  cat ${HELD}/pub
  exit 1
fi

# dart test only compiles the test files it runs, and what they import.
# dart analyze reads every .dart file, so a file nothing imports yet still
# has its errors reported. Warnings are shown but do not stop the tests.
dart analyze --no-fatal-warnings > ${HELD}/analyze 2>&1 &
readonly ANALYZE_PID=$!

# The tests run while the analyzer reads. This is what `dart test` runs:
# package:test's runner, started from a copy compiled when this image was
# built, and its compiled copy of package:test, rather than compiling both
# again on every test run.
#
# Test files must be under test/ and end in _test.dart, at any depth.
# A test file named any other way is not run, as with dart test anywhere.
readonly DART_TEST_CACHE=~/.cache/dart_test
mkdir -p .dart_tool/test
cp ${DART_TEST_CACHE}/incremental_kernel.* .dart_tool/test/

TEST_OPTS=()
TEST_OPTS+=(--reporter expanded)  # one line per test, and no progress bar
TEST_OPTS+=(--no-color)           # plain text, so the summary is readable

TEST_STATUS=0
dart --packages=.dart_tool/package_config.json \
  ${DART_TEST_CACHE}/test.snapshot "${TEST_OPTS[@]}" \
  > ${HELD}/test 2>&1 || TEST_STATUS=$?

ANALYZE_STATUS=0
wait ${ANALYZE_PID} || ANALYZE_STATUS=$?

# An error the analyzer found is the one to fix first, and it says where it
# is in one line, so it is shown instead of the tests.
if [ ${ANALYZE_STATUS} -ne 0 ]; then
  cat ${HELD}/analyze
  exit ${ANALYZE_STATUS}
fi
if ! grep --quiet '^No issues found!$' ${HELD}/analyze; then
  cat ${HELD}/analyze
fi
cat ${HELD}/test
exit ${TEST_STATUS}
