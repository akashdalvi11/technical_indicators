import 'dart:math';
import '../interfaceIndicatorData.dart';
import 'ohlc.dart';
class Candle extends OHLC implements InterfaceIndicatorData{
    Candle(double o,double h,double l,double c):super(o,h,l,c);
    @override
    String toString(){
        return super.toString();
    }
}
Candle candleJustFormed(double ltp){
    return Candle(ltp,ltp,ltp,ltp);
}
Candle candleUpdated(Candle candle,double ltp){
    var low = min(candle.l,ltp);
    var high = max(candle.h,ltp);
    return Candle(candle.o,high,low,ltp);
}