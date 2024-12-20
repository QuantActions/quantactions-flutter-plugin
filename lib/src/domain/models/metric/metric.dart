import '../../../../quantactions_flutter_plugin.dart';
import 'metric_type.dart';

///  Enumeration class that holds all of the info for the metrics
enum Metric implements MetricType {
  /// **Good sleep is crucial for pretty much everything we do.**
  ///
  /// Sleep is a powerful stress-reliever. It improves concentration, regulates mood, and sharpens judgment skills and decision-making.
  /// A lack of sleep not only reduces mental clarity but negatively impacts your ability to cope with stressful situations.
  /// So getting a good night’s sleep is incredibly important for your health. In fact, it’s just as important as eating a balanced, nutritious diet and exercising.
  ///
  /// Getting enough sleep has many benefits. It can help you:
  ///   - get sick less often
  ///   - reduce stress and improve your mood
  ///   - get along better with people
  ///   - increase concentration abilities and cognitive speed
  ///   - make good decisions and avoid injuries
  ///
  /// **How much sleep is enough sleep?**
  ///
  /// The amount of sleep each person needs depends on many factors, including age. For most adults, 7 to 8 hours a night appears to be the best amount of sleep, although some people may need as few as 5 hours or as many as 10 hours of sleep each day.
  ///
  /// Your sleep is not directly recorded, only your taps on your smartphone are captured and analysed by our algorithm. This includes, for example, when you check the time on your smartphone at night.
  ///
  /// When monitoring your sleep, these components are used:
  ///   - Duration of sleep
  ///   - Regularity of sleep
  ///   - Sleep interruptions (taps during the night)
  ///   - Longest sleep session without interruption
  ///
  /// The data reflects your sleep patterns over the past 7 days and the most weight is placed on the previous night. This data is fed into a validated algorithm that predicts and estimates the likelihood of when you sleep.
  ///
  ///
  /// Checkout our scientific literature about sleep:
  /// - [Large cognitive fluctuations surrounding sleep in daily living](https://www.cell.com/iscience/fulltext/S2589-0042(21)00127-9?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS2589004221001279%3Fshowall%3Dtrue)
  /// - [Trait-like nocturnal sleep behavior identified by combining wearable, phone-use, and self-report data](https://www.nature.com/articles/s41746-021-00466-9)
  /// - [Capturing sleep–wake cycles by using day-to-day smartphone touchscreen interactions](https://www.nature.com/articles/s41746-019-0147-4)
  ///
  sleepScore(
      id: 'sleep',
      code: '003-001-001-002',
      eta: 7,
      populationRange: populationRangeSleep),

  /// **Cognitive fitness reflects how quickly you are able to see, understand and act.**
  ///
  /// Cognitive Processing Speed measures your cognitive fitness, which is a composition of various cognitive skills.
  ///
  /// Examples of these cognitive skills are:
  ///   - The ability to focus your attention on a single stimulation
  ///   - A contextual memory, that enables you to recall the source and circumstance of a certain event
  ///   - Good hand-eye coordination
  ///   - The ability to execute more than one action at a time
  ///
  /// **The higher your Cognitive Processing Speed, the more efficient your ability to think and learn.**
  ///
  /// Chronic stress is likely to negatively affect key cognitive functions such as memory, reaction times, attention span, and concentration skills. It is also likely that high stress levels will cause performance variability.
  ///
  /// When monitoring your cognitive fitness, these components are used (privacy is ensured and there's no tracking in terms of content):
  ///  - Your tapping speed
  ///  - Your typing speed
  ///  - Your unlocking speed
  ///  - Your app locating speed (how long it takes you to find apps that you're using)
  ///
  /// The score doesn't measure your efficiency in using your smartphone or executing one particular task. The focus is on the totality and consistency of your behaviour, not on certain maximum scores. Individual actions do not contribute to an increase or decrease in your score, e.g. if it takes you a little longer to find something because you were busy doing something else at the same time.
  ///
  /// Checkout our scientific literature about cognitive fitness:
  /// - [Can you hear me now? Momentary increase in smartphone usage enhances neural processing of task-irrelevant sound tones](https://www.sciencedirect.com/science/article/pii/S2666956022000551?via%3Dihub)
  /// - [Reopening after lockdown: the influence of working-from-home and digital device use on sleep, physical activity, and wellbeing following COVID-19 lockdown and reopening](https://academic.oup.com/sleep/article/45/1/zsab250/6390581)
  /// - [Generalized priority-based model for smartphone screen touches](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.102.012307)
  /// - [The details of past actions on a smartphone touchscreen are reflected by intrinsic sensorimotor dynamics](https://www.nature.com/articles/s41746-017-0011-3)
  /// - [Use-Dependent Cortical Processing from Fingertips in Touchscreen Phone Users](https://www.cell.com/current-biology/fulltext/S0960-9822(14)01487-0?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS0960982214014870%3Fshowall%3Dtrue)
  ///
  cognitiveFitness(
      id: 'cognitive',
      code: '003-001-001-003',
      eta: 4,
      populationRange: populationRangeSpeed),

  /// **Social Engagement is the process of engaging in digital activities in a social group. Engaging in social relationships benefits brain health.**
  /// While it has been long known that social interactions are good for you, digital social engagement is a new indicator of brain health. Recent studies have linked smartphone social engagement with the production of dopamine—the hormone that helps us feel pleasure as part of the brain’s reward system. Here are some examples of smartphone social interactions:
  ///
  /// - Text messaging
  /// - Checking social media (e.g. Facebook, Instagram etc.)
  /// - Playing multi-player smartphone games
  ///
  /// Other ways we use our smartphones like watching videos, reading news articles, and playing single-player games do not count as social interactions. The level of digital social engagement helps us to probe brain activity (synthesis of dopamine) which consequently helps us understand more about brain health.
  ///
  /// Checkout our scientific literature about social engagement:
  /// - [Striatal dopamine synthesis capacity reflects smartphone social activity](https://www.cell.com/iscience/fulltext/S2589-0042(21)00465-X?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS258900422100465X%3Fshowall%3Dtrue)
  ///
  socialEngagement(
      id: 'social',
      code: '003-001-001-004',
      eta: 2,
      populationRange: populationRangeEngagement),

  /// Action time refers to the amount of time it takes for you to decide and complete a task on
  /// your smartphone.
  /// Action time is the time it typically takes you to execute simple actions, such as inputting
  /// text characters, browsing or navigating between apps. The speed and efficiency with which you
  /// are able to perform these actions will impact your action time. Action time can be influenced
  /// by a variety of factors, including individual ability, distraction, and environmental factors.
  /// Tracking your action time and typing speed can help you monitor your health.
  /// Slow action time or typing speed can be a sign of underlying health issues, such physical or
  /// neurological disorders. By monitoring your performance, you can identify potential health
  /// issues early and seek medical attention if necessary. Additionally, tracking your performance
  /// can help you monitor your progress during rehabilitation if you have suffered an injury or
  /// illness that has affected your performance. So, take a moment to track your performance and
  /// keep an eye on your health.
  actionSpeed(
      id: 'action',
      code: '001-003-003-002',
      eta: 5,
      populationRange: placeholder),

  /// This metric is reported in milliseconds and represents the time efficiency of the user in
  /// typing any kind of text on their smartphone.
  typingSpeed(
      id: 'typing',
      code: '001-003-004-002',
      eta: 5,
      populationRange: placeholder),

  /// A series of detailed information for each night detected. In particular this series gives
  /// information about bed time, wake up time and interruptions of sleep.
  /// See [com.quantactions.sdk.data.model.SleepSummary] for more information.
  sleepSummary(
      id: 'sleep_summary',
      code: '001-002-006-004',
      eta: 7,
      populationRange: placeholder),

  /// Screen time is a measure of the time you spend on your smartphone.
  screenTimeAggregate(
      id: 'screen_time_aggregate',
      code: '003-001-001-005',
      eta: 2,
      populationRange: placeholder),

  /// **Social taps are the number of taps you make on your smartphone while engaging in social activities.**
  ///
  /// Social taps are a measure of the number of taps you make on your smartphone while engaging in social activities. This metric is a proxy for the level of social engagement you have with your smartphone.
  ///
  /// Checkout our scientific literature about social taps:
  /// - [Striatal dopamine synthesis capacity reflects smartphone social activity](https://www.cell.com/iscience/fulltext/S2589-0042(21)00465-X?_returnURL=https%3A%2F%2Flinkinghub.elsevier.com%2Fretrieve%2Fpii%2FS258900422100465X%3Fshowall%3Dtrue)
  ///
  socialTaps(
      id: 'social_taps',
      code: '001-005-005-011',
      eta: 2,
      populationRange: placeholder),

  /// Behavioral age
  behaviouralAge(
      id: 'age',
      code: '003-001-001-007',
      eta: 21,
      populationRange: placeholder);

  @override
  final String id;
  @override
  final String code;
  @override
  final int eta;
  @override
  final PopulationRange populationRange;

  const Metric(
      {required this.id,
      required this.code,
      required this.eta,
      required this.populationRange});
}

/// The range of the population for the cognitive fitness
const PopulationRange populationRangeSpeed = PopulationRange(
    global: Range(25.984, 61.667),
    globalMale: Range(20.004, 67.1376666667),
    globalFemale: Range(30.2793333333, 68.5296666667),
    male: SexRange(
      Range(77.9633333333, 92.734),
      Range(68.6626666667, 84.4713333333),
      Range(14.8116666667, 40.343),
    ),
    female: SexRange(
      Range(79.484, 94.636),
      Range(69.2213333333, 83.3413333333),
      Range(25.4356666667, 49.818333333300004),
    ),
    other: SexRange(
      Range(80.18966546235, 94.9056666667),
      Range(23.8803333333, 56.1703333333),
      Range(21.0006666667, 46.875),
    ));

/// The range of the population for the sleep score
const PopulationRange populationRangeSleep = PopulationRange(
    global: Range(62.5965333462, 80.1198962555),
    globalMale: Range(62.821373606925, 79.9647116475),
    globalFemale: Range(61.720432246, 79.4648495177),
    male: SexRange(
      Range(53.747138727999996, 68.852517714225),
      Range(55.69155824175, 69.503734701475),
      Range(67.6732350188, 82.04550006815),
    ),
    female: SexRange(
      Range(59.1220032185, 74.4762757562),
      Range(57.6548306463, 74.2748247876),
      Range(63.1446127319, 80.7494870951),
    ),
    other: SexRange(
      Range(56.647460836, 72.3603778729),
      Range(62.7969151007, 80.0634274084),
      Range(64.28684596055001, 81.0107266759),
    ));

/// The range of the population for the social engagement
const PopulationRange populationRangeEngagement = PopulationRange(
    global: Range(28.7124676865, 75.7599105337),
    globalMale: Range(24.270382410049997, 70.70684047155001),
    globalFemale: Range(32.2609985538, 77.973185984),
    male: SexRange(
      Range(53.030621088675005, 90.08054630645),
      Range(26.900045929999997, 72.83407604007499),
      Range(21.5921014173, 66.04760364165),
    ),
    female: SexRange(
      Range(70.6135977054, 94.548489533925),
      Range(45.8729243654, 88.2134250365),
      Range(27.8253770719, 68.8399696894),
    ),
    other: SexRange(
      Range(66.69589297649999, 94.098611152425),
      Range(28.315763304024998, 72.023246148975),
      Range(27.181074135, 69.049205978625),
    ));

/// The placeholder for the population range
const PopulationRange placeholder = PopulationRange(
    global: Range(0, 0),
    globalMale: Range(0, 0),
    globalFemale: Range(0, 0),
    male: SexRange(
      Range(0, 0),
      Range(0, 0),
      Range(0, 0),
    ),
    female: SexRange(
      Range(0, 0),
      Range(0, 0),
      Range(0, 0),
    ),
    other: SexRange(
      Range(0, 0),
      Range(0, 0),
      Range(0, 0),
    ));
