#!/usr/bin/env bash
(cd hx_widget_booking && flutter packages pub run build_runner build --delete-conflicting-outputs)
flutter packages pub run build_runner build --delete-conflicting-outputs