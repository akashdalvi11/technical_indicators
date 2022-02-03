import '../indicators/interfaceIndicatorData.dart';
import '../indicators/ohlc/candle.dart';
import 'indicatorDataNode.dart';
import 'event.dart';
DateTime edgedDateTime(int interval,DateTime datetime){
        return datetime.subtract(Duration(
            minutes:datetime.minute % interval,
            milliseconds: datetime.millisecond,
            microseconds: datetime.microsecond,
            seconds: datetime.second));
}
class IndicatorDataTree<D extends InterfaceIndicatorData>{
    final int interval;
    final List<DateTime> dateTimeValues;
    final List<IndicatorDataNode> children;
    late List<D> interfaceValues;
    IndicatorDataTree(this.interval,this.dateTimeValues,this.children);
    bool update(Event e){
        var dateTime = edgedDateTime(interval,e.dateTime);
        if(dateTime == dateTimeValues.last){
            updateCurrent(e.value);
            return false;
        }else{
            dateTimeValues.add(dateTime);
            addNew(e.value);
            return true;
        }
    }
    fill(List<D> interfaceValues){
        this.interfaceValues = interfaceValues;
        for(var x in children){
            x.fill(interfaceValues);
        }
    }
    updateCurrent(double data){
        late InterfaceIndicatorData updated;
        if(D == Candle) updated = candleUpdated(interfaceValues.last as Candle,data);
        interfaceValues.last = updated as D;
        for(var x in children) x.updateCurrent(interfaceValues);
    }
    addNew(double data){
        late InterfaceIndicatorData justFormed;
        if(D == Candle) justFormed = candleJustFormed(data);
        interfaceValues.add(justFormed as D);
        for(var x in children) x.addNew(interfaceValues);
    }
    
    // String toString(){
    //     var sl = list.length -2;
    //     var s = '${list[sl]}\n';
    //     for(var x in children) s+= '$x\n';
    //     return s;
    // }
}