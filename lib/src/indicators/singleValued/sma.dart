import '../indicatorData.dart';
import 'singleValued.dart';

class SMA extends SingleValued implements IndicatorData {
  SMA(double value):super(value);
  String toString()=> super.toString();
}
SMA getSMA(List<double> values) {
  double sma = 0;
  for(var i=0;i<values.length;i++)
    sma+= values[i];
  return SMA(sma/values.length);
}
List<SMA> getSMAList(List<double> values, int period) {
  List<SMA> SMAs = [];
  for(var i=0;i<period-1;i++){
    SMAs.add(SMA(0));
  }
  for (var i = period-1; i < values.length; i++) {
    SMAs.add(
      getSMA(
        values.sublist(i-(period-1),i+1)
      )
    );
  }
  return SMAs;
}
