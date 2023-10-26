//
//  QAFlutterPluginHelper.swift
//  qa_flutter_plugin
//
//  Created by User on 20/10/2023.
//

import Foundation
import QuantActionsSDK

class QAFlutterPluginHelper{
    public static let metricChannelNames : [String] = [
        "sleep", "cognitive", "social", "action", "typing", "sleep_summary", "screen_time_aggregate", "social_taps",
        "sleep_trend", "cognitive_trend", "social_engagement_trend", "action_trend", "typing_trend", "sleep_length_trend",
        "sleep_interruptions_trend", "social_screen_time_trend", "social_taps_trend", "the_wave_trend",
    ]
    
    public static func parseGender(gender: String?) -> Gender {
        switch gender {
        case "male":
            return Gender.male
        case "female":
            return Gender.female
        case "other":
            return Gender.other
        default:
            return Gender.unknown
        }
    }
    
    public static func getTrendKind(metric: String) -> TrendKind? {
        switch(metric) {
        case "cognitive_trend":
            return TrendKind.cognitiveFitness
        case "action_trend":
            return TrendKind.actionSpeed
        case "typing_trend":
            return TrendKind.typingSpeed
        case "sleep_trend":
            return TrendKind.sleepScore
        case "sleep_length_trend":
            return TrendKind.sleepLength
        case "sleep_interruptions_trend":
            return TrendKind.sleepInterruptions
        case "social_engagement_trend":
            return TrendKind.socialEngagement
        case "social_screen_time_trend":
            return TrendKind.socialScreenTime
        case "social_taps_trend":
            return TrendKind.socialTaps
        case "the_wave_trend":
            return TrendKind.wave
        default: return nil
        }
    }
}
