import 'indicatorData.dart';

class Stochastic extends IndicatorData {
  final double value;
  Stochastic(this.value);
  String toString(){
    return "$value";
  }
}
Stochastic getStochastic(List<dynamic> ohlcs,int period){
  double highest = 0;
  double lowest = double.maxFinite;
  for(int i=(ohlcs.length - period);i<ohlcs.length;i++){
    if(ohlcs[i].h>highest) highest = ohlcs[i].h;
    if(ohlcs[i].l<lowest) lowest = ohlcs[i].l;
  }
  double close = ohlcs.last.c;
  if(highest == lowest) return Stochastic(100);
  return Stochastic(
    round(
      (close-lowest)*100/
      (highest-lowest)
    )
  );
}
List<Stochastic> getStochasticList(List<dynamic> ohlcs, int period) {
  List<Stochastic> list = [];
  for(var i=0;i<period-1;i++){
    list.add(Stochastic(0));
  }
  for (var i = (period-1); i < ohlcs.length; i++) {
    list.add(getStochastic(ohlcs.sublist(0,i+1),period));
  }
  return list;
}
