import 'dart:math';
import 'interfaceIndicatorData.dart';
class OHLC extends InterfaceIndicatorData{
    final double o,h,l,c;
    OHLC(this.o,this.h,this.l,this.c);
    @override
    String toString(){
        return '$o,$h,$l,$c';
    }
}
OHLC ohlcJustFormed(double ltp){
    return OHLC(ltp,ltp,ltp,ltp);
}
OHLC ohlcUpdated(OHLC ohlc,double ltp){
    var low = min(ohlc.l,ltp);
    var high = max(ohlc.h,ltp);
    return OHLC(ohlc.o,high,low,ltp);
}