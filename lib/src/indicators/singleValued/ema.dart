import '../indicatorData.dart';
import 'singleValued.dart';
class EMA extends SingleValued implements IndicatorData {
  EMA(double value):super(value);
  String toString()=> super.toString();
}
EMA getEMA(EMA previousEMA,double newValue,int period) {
  var alpha = 2 / (period + 1);
  var toReturn = round(previousEMA.value + alpha * (newValue - previousEMA.value));
  return EMA(toReturn);
}
List<EMA> getEMAList(List<double> values, int period) {
  List<EMA> emas = [];
  double sma = 0;
  for(var i=0;i<period-1;i++){
    sma+= values[i];
    emas.add(EMA(0));
  }
  sma += values[period-1];
  emas.add(EMA(round(sma/period)));
  for (var i = period; i < values.length; i++) {
    emas.add(getEMA(emas[i - 1], values[i], period));
  }
  return emas;
}
