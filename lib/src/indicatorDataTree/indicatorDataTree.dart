import '../indicators/interfaceIndicatorData.dart';
import '../indicators/ohlc/candle.dart';
import '../indicators/indicatorDataFactory.dart' as dataFactory;
import '../indicators/indicatorData.dart';
import 'event.dart';
part 'indicatorDataNode.dart';
DateTime _edgedDateTime(int interval,DateTime datetime){
        return datetime.subtract(Duration(
            minutes:datetime.minute % interval,
            milliseconds: datetime.millisecond,
            microseconds: datetime.microsecond,
            seconds: datetime.second));
}
class IndicatorDataTree<D extends InterfaceIndicatorData>{
    final int interval;
    final List<DateTime> dateTimeList;
    final List<IndicatorDataNode> children;
    late List<D> dataList;
    IndicatorDataTree(this.interval,this.dateTimeList,this.children);
    bool update(Event e){
        var dateTime = _edgedDateTime(interval,e.dateTime);
        if(dateTime == dateTimeList.last){
            _updateCurrent(e.value);
            return false;
        }else{
            dateTimeList.add(dateTime);
            _addNew(e.value);
            return true;
        }
    }
    fill(List<D> dataList){
        this.dataList = dataList;
        for(var x in children){
            x._fill(dataList);
        }
    }
    _updateCurrent(double data){
        late InterfaceIndicatorData updated;
        if(D == Candle) updated = candleUpdated(dataList.last as Candle,data);
        dataList.last = updated as D;
        for(var x in children) x._updateCurrent(dataList);
    }
    _addNew(double data){
        late InterfaceIndicatorData justFormed;
        if(D == Candle) justFormed = candleJustFormed(data);
        dataList.add(justFormed as D);
        for(var x in children) x._addNew(dataList);
    }
}