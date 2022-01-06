import '../indicators/interfaceIndicators/ohlc.dart';
class HistoricalData{
    final List<DateTime> dateTimeList;
    final List<OHLC> ohlcList;
    HistoricalData(this.dateTimeList,this.ohlcList);
}