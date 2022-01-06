import 'dart:math';
import 'interfaceIndicators/ohlc.dart';
import 'indicatorData.dart';
HeikenAshi getHeikenAshi(OHLC ohlc,[HeikenAshi? previousHeikenAshi]){
    double close = round((ohlc.o+ohlc.h+ohlc.l+ohlc.c)/4);
    double open = round((previousHeikenAshi == null?
                ohlc.o+ohlc.c:
                previousHeikenAshi.o + previousHeikenAshi.c)/2);
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
class HeikenAshi extends IndicatorData{
    final o,h,l,c;
    HeikenAshi(this.o,this.h,this.l,this.c);
    @override
    String toString(){
        return '$o,$h,$l,$c';
    }
}