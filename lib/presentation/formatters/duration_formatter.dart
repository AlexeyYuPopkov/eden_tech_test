import 'package:eden_tech_test/l10n/localization.dart';
import 'package:flutter/material.dart';

final class DurationFormatter {
  static String tryFormat({
    required Duration? duration,
    BuildContext? context,
  }) {
    if (duration == null) {
      return '';
    }
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final hourSuffix = context?.l10n.commonHourShort ?? 'h';
    final minuteSuffix = context?.l10n.commonMinuteShort ?? 'm';

    return '$hours$hourSuffix $minutes$minuteSuffix';
  }
}
