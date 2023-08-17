import 'package:qa_flutter_plugin/src/data/mappers/screen_time_aggregate/screen_time_aggregate_mapper.dart';
import 'package:qa_flutter_plugin/src/data/mappers/trend_holder/tremd_holder_mapper.dart';

import '../../../domain/domain.dart';
import '../action_speed/action_speed_mapper.dart';
import '../cognitive_fitness/cognitive_fitness_mapper.dart';
import '../screen_scope/screen_scope_mapper.dart';
import '../sleep_summary/sleep_summary_mapper.dart';
import '../social_engagement/social_engagement_mapper.dart';
import '../social_tap/social_tap_mapper.dart';
import '../typing_speed/typing_speed_mapper.dart';

class TimeSeriesMapper {
  static const String _timestamps = 'timestamps';
  static const String _values = 'values';
  static const String _confidenceIntervalLow = 'confidenceIntervalLow';
  static const String _confidenceIntervalHigh = 'confidenceIntervalHigh';
  static const String _confidence = 'confidence';

  static TimeSeries<double> fromJson(Map<String, dynamic> json) {
    return TimeSeries<double>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .cast<double>()
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<double>((e) => e == null ? double.nan : e as double)
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<TrendHolder> fromJsonTrendTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<TrendHolder>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<TrendHolder>((e) => TrendHolderMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<SleepSummary> fromJsonSleepSummaryTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<SleepSummary>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<SleepSummary>((e) => SleepSummaryMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<ScreenTimeAggregate> fromJsonScreenTimeAggregateTimeSeries(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenTimeAggregate>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<ScreenTimeAggregate>(
              (e) => ScreenTimeAggregateMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<ActionSpeed> fromJsonActionSpeed(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ActionSpeed>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<ActionSpeed>((e) => ActionSpeedMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<ActionSpeed>((e) => ActionSpeedMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<ActionSpeed>((e) => ActionSpeedMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<CognitiveFitness> fromJsonCognitiveFitness(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<CognitiveFitness>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<CognitiveFitness>((e) => CognitiveFitnessMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<CognitiveFitness>((e) => CognitiveFitnessMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<CognitiveFitness>((e) => CognitiveFitnessMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<ScreenScope> fromJsonScreenScope(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<ScreenScope>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<ScreenScope>((e) => ScreenScopeMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<ScreenScope>((e) => ScreenScopeMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<ScreenScope>((e) => ScreenScopeMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<SocialEngagement> fromJsonSocialEngagement(
    Map<String, dynamic> json,
  ) {
    return TimeSeries<SocialEngagement>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<SocialEngagement>((e) => SocialEngagementMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<SocialEngagement>((e) => SocialEngagementMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<SocialEngagement>((e) => SocialEngagementMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<SocialTap> fromJsonSocialTap(Map<String, dynamic> json) {
    return TimeSeries<SocialTap>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<SocialTap>((e) => SocialTapMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<SocialTap>((e) => SocialTapMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<SocialTap>((e) => SocialTapMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static TimeSeries<TypingSpeed> fromJsonTypingSpeed(
      Map<String, dynamic> json,
      ) {
    return TimeSeries<TypingSpeed>(
      timestamps: _getTimestamps(json[_timestamps]),
      values: json[_values]
          .map<TypingSpeed>((e) => TypingSpeedMapper.fromJson(e))
          .toList(),
      confidenceIntervalLow: json[_confidenceIntervalLow]
          .map<TypingSpeed>((e) => TypingSpeedMapper.fromJson(e))
          .toList(),
      confidenceIntervalHigh: json[_confidenceIntervalHigh]
          .map<TypingSpeed>((e) => TypingSpeedMapper.fromJson(e))
          .toList(),
      confidence: json[_confidence].cast<double>(),
    );
  }

  static List<DateTime> _getTimestamps(dynamic data) {
    return data
        .map<DateTime>(
          (e) => DateTime.parse((e as String).split('[').first).toLocal(),
        )
        .toList();
  }
}
