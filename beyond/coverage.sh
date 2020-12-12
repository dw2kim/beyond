#!/usr/bin/env bash
flutter test --coverage --no-test-assets
genhtml coverage/lcov.info --output-directory coverage/report
