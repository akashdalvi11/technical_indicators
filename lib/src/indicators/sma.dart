import 'indicatorData.dart';

class SMA extends IndicatorData {
  final double value;
  SMA(this.value);
  String toString(){
    return "$value";
  }
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
