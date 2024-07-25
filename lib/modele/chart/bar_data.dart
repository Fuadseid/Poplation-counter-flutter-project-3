import 'chart_bar.dart';
import 'package:practice/modele/pop_model.dart';
class BarData {
  final PopBucket choice1;
  final PopBucket choice2;
  final PopBucket choice3;
  final PopBucket choice4;
  BarData({
    required this.choice1,
    required this.choice2,
    required this.choice3,
    required this.choice4,
  });
  List<ChartBar> bardata = [];
  void initializeBar() {
    bardata = [
ChartBar(x: choice1, y:0 ),
ChartBar(x: choice2, y:0 ),
ChartBar(x: choice3, y:0 ),
ChartBar(x: choice4, y:0 ),
];
  }
}
