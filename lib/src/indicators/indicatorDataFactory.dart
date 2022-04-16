import 'indicatorData.dart';
import 'ohlc/candle.dart';
import 'ohlc/heikenAshi.dart';
import 'ohlc/ohlc.dart';
import 'singleValued/ema.dart';
import 'singleValued/sma.dart';
import 'singleValued/stochastic.dart';
import 'singleValued/singleValued.dart';

D update<D extends IndicatorData,P extends IndicatorData>(List<D> list,List<P> parentList,Map<String,dynamic> specs){
    var p = parentList.last;
    if(D == HeikenAshi) return getHeikenAshi((parentList.last as OHLC),list.last as OHLC) as D;
    else if(D == EMA){
        late double recentValue;
        if(p is OHLC) recentValue = (p as OHLC).c;
        else if(p is SingleValued) recentValue = (p as SingleValued).value;
        return getEMA((list.last as EMA),recentValue,specs['period']) as D;
    }else if(D == SMA){
        late List<double> values;
        var lastFew = parentList.sublist(parentList.length-(specs['period'] as int),parentList.length);
        if(p is OHLC) values = lastFew.cast<OHLC>().map((e)=>e.c).toList();
        else if(p is SingleValued) values = lastFew.cast<SingleValued>().map((i)=>i.value).toList();
        return getSMA(values) as D;
    }else if(D == Stochastic){
        return getStochastic(parentList.cast<OHLC>(),specs['period']) as D;
    }else throw 'immpossible';
}
List<D> convert<D extends IndicatorData,P extends IndicatorData>(List<P> parentList,Map<String,dynamic> specs){
    var p = parentList.last;
    if(D == HeikenAshi) return getHeikenAshiList(parentList.cast<OHLC>()) as List<D>;
    else if(D == EMA){
        late List<double> values;
        if(p is OHLC) values = parentList.cast<OHLC>().map((e)=>e.c).toList();
        else if(p is SingleValued) values = parentList.cast<SingleValued>().map((i)=>i.value).toList();
        return getEMAList(values,specs['period']) as List<D>;
    }else if(D == SMA){
        late List<double> values;
        if(p is OHLC) values = parentList.cast<OHLC>().map((e)=>e.c).toList();
        else if(p is SingleValued) values = parentList.cast<SingleValued>().map((i)=>i.value).toList();
        return getSMAList(values,specs['period']) as List<D>;
    }else if(D == Stochastic){
        return getStochasticList(parentList.cast<OHLC>(),specs['period']) as List<D>; 
    }else throw 'impossible';
}