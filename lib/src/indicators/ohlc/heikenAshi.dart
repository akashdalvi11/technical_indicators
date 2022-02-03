import 'dart:math';
import 'ohlc.dart';
import '../indicatorData.dart';
HeikenAshi getHeikenAshi(OHLC ohlc,[OHLC? previousOHLC]){
    double close = round((ohlc.o+ohlc.h+ohlc.l+ohlc.c)/4);
    double open = round((previousOHLC == null?
                ohlc.o+ohlc.c:
                previousOHLC.o + previousOHLC.c)/2);
    var high = max(ohlc.h,max(close,open));
    var low = min(ohlc.l,min(close,open));
    return HeikenAshi(open,high,low,close);
}    
List<HeikenAshi> getHeikenAshiList(List<OHLC> list){
    var hlist = <HeikenAshi>[];
    hlist.add(getHeikenAshi(list[0]));
    for(int i=1;i<list.length;i++){
        hlist.add(getHeikenAshi(list[i],hlist[i-1]));
    }
    return hlist;
}
class HeikenAshi extends OHLC implements IndicatorData{
    HeikenAshi(double o,double h,double l,double c):super(o,h,l,c);
    @override
    String toString()=>super.toString();
}