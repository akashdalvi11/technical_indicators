import '../indicators/interfaceIndicators/interfaceIndicatorData.dart';
import '../indicators/interfaceIndicators/ohlc.dart';
import 'indicatorDataNode.dart';
class InterfaceIndicatorDataNode<D extends InterfaceIndicatorData>{
    late List<D> list;
    final List<IndicatorDataNode> children;
    InterfaceIndicatorDataNode(this.children);
    fill(List<D> list){
        this.list = list;
        for(var x in children){
            x.fill(list);
        }
    }
    updateCurrent(double data){
        late InterfaceIndicatorData updated;
        if(D == OHLC) updated = ohlcUpdated(list.last as OHLC,data);
        assert(updated is D);
        list.last = updated as D;
        for(var x in children) x.updateCurrent(list);
    }
    addNew(double data){
        late InterfaceIndicatorData justFormed;
        if(D == OHLC) justFormed = ohlcJustFormed(data);
        assert(justFormed is D);
        list.add(justFormed as D);
        for(var x in children) x.addNew(list);
    }
    String toString(){
        var sl = list.length -2;
        var s = '${list[sl]}\n';
        for(var x in children) s+= '$x\n';
        return s;
    }
}