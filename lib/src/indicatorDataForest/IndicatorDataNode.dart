import '../indicators/indicatorDataFactory.dart';
import '../indicators/indicatorData.dart';

class IndicatorDataNode<D extends IndicatorData,P extends IndicatorData>{
    final Map<String,dynamic> specs;
    final List<IndicatorDataNode> children;
    late List<D> list;
    IndicatorDataNode(this.specs,this.children);
    fill(List<P> parentList){
        list = IndicatorDataFactory<D,P>(specs).convert(parentList);
        for(var x in children){
            x.fill(list);
        }
    }
    updateCurrent(List<P> parentList){
       list.last = IndicatorDataFactory<D,P>(specs).update(list.sublist(0,list.length-1),parentList);
        for(var x in children)
            x.updateCurrent(list);
    }
    addNew(List<P> parentList){
        list.add(IndicatorDataFactory<D,P>(specs).update(list,parentList));
        for(var x in children)
            x.addNew(list);
    }
    String toString(){
        var sl = list.length -2;
        var s = '${list[sl]}\n';
        for(var x in children) s+= '$x\n';
        return s;
    }
}