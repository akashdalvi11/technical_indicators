import '../indicators/interfaceIndicatorData.dart';
class HistoricalData<D extends InterfaceIndicatorData>{
    final List<DateTime> dateTimeList;
    final List<D> dataList;
    HistoricalData(this.dateTimeList,this.dataList);
}