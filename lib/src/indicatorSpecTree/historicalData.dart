import '../indicators/interfaceIndicatorData.dart';
import '../indicators/ohlc/candle.dart';
class HistoricalData<D extends InterfaceIndicatorData>{
    final List<DateTime> dateTimeList;
    final List<D> dataList;
    HistoricalData(this.dateTimeList,this.dataList);
    static HistoricalData<Candle> createOHLC(List<DateTime> dateTimeList,List<List<double>> ohlcList){
        List<Candle> candles = [];
        for(var l in ohlcList){
            assert(l.length == 4);
            candles.add(Candle(l[0],l[1],l[2],l[3]));
        }
        return HistoricalData<Candle>(dateTimeList,candles);
    }
}