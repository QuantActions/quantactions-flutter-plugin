import '../../../../quantactions_flutter_plugin.dart';
import 'metric_type.dart';

enum Metric implements MetricType{
  sleepScore(id: 'sleep', code: '003-001-001-002', eta: 7, populationRange: populationRangeSleep),
  cognitiveFitness(id: 'cognitive', code: '003-001-001-003', eta: 4, populationRange: populationRangeSpeed),
  socialEngagement(id: 'social', code: '003-001-001-004', eta: 2, populationRange: populationRangeEngagement),
  actionSpeed(id: 'action', code: '001-003-003-002', eta: 5, populationRange: placeholder),
  typingSpeed(id: 'typing', code: '001-003-004-002', eta: 5, populationRange: placeholder),
  sleepSummary(id: 'sleep_summary', code: '001-002-006-004', eta: 7, populationRange: placeholder),
  screenTimeAggregate(id: 'screen_time_aggregate', code: '003-001-001-005', eta: 2, populationRange: placeholder),
  socialTaps(id: 'social_taps', code: '001-005-005-011', eta: 2, populationRange: placeholder);

  @override
  final String id;
  @override
  final String code;
  @override
  final int eta;
  @override
  final PopulationRange populationRange;


  const Metric({
    required this.id,
    required this.code,
    required this.eta,
    required this.populationRange
  });
}

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

