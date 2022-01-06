import '../indicators/interfaceIndicators/ohlc.dart';
import 'interfaceIndicatorDataNode.dart';
import 'event.dart';
class IndicatorDataForest{
    final int interval;
    final List<DateTime> dateTimeList;
    final InterfaceIndicatorDataNode<OHLC> ohlc;
    IndicatorDataForest(this.interval,this.dateTimeList,this.ohlc);
    DateTime edgedDateTime(DateTime datetime){
        return datetime.subtract(Duration(
            minutes:datetime.minute % interval,
            milliseconds: datetime.millisecond,
            microseconds: datetime.microsecond,
            seconds: datetime.second));
    }
    bool update(Event e){
        var dateTime = edgedDateTime(e.dateTime);
        if(dateTime == dateTimeList.last){
            ohlc.updateCurrent(e.ltp);
            return false;
        }else{
            dateTimeList.add(dateTime);
            ohlc.addNew(e.ltp);
            return true;
        }
    }
}