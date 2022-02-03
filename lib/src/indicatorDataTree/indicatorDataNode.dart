import '../indicators/indicatorDataFactory.dart' as dataFactory;
import '../indicators/indicatorData.dart';

class IndicatorDataNode<D extends IndicatorData,P extends IndicatorData>{
    final Map<String,dynamic> specs;
    final List<IndicatorDataNode> children;
    late List<D> values;
    IndicatorDataNode(this.specs,this.children);
    fill(List<P> parentValues){
        values = dataFactory.convert<D,P>(parentValues,specs);
        for(var x in children){
            x.fill(values);
        }
    }
    updateCurrent(List<P> parentValues){
        values.last = dataFactory.update<D,P>(values.sublist(0,values.length-1),parentValues,specs);
        for(var x in children)
            x.updateCurrent(values);
    }
    addNew(List<P> parentValues){
        values.add(dataFactory.update<D,P>(values,parentValues,specs));
        for(var x in children)
            x.addNew(values);
    }
    // String toString(){
    //     var sl = values.length -2;
    //     var s = '${values[sl]}\n';
    //     for(var x in children) s+= '$x\n';
    //     return s;
    // }
}