## Testing
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/generated/*' 'lib/l10n/*' -o coverage/lcov.info     
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html