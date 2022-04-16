
part of 'indicatorDataTree.dart';
class IndicatorDataNode<D extends IndicatorData,P extends IndicatorData>{
    final Map<String,dynamic> specs;
    final List<IndicatorDataNode> children;
    late List<D> dataList;
    IndicatorDataNode(this.specs,this.children);
    _fill(List<P> parentValues){
        dataList = dataFactory.convert<D,P>(parentValues,specs);
        for(var x in children){
            x._fill(dataList);
        }
    }
    _updateCurrent(List<P> parentValues){
        dataList.last = dataFactory.update<D,P>(dataList.sublist(0,dataList.length-1),parentValues,specs);
        for(var x in children)
            x._updateCurrent(dataList);
    }
    _addNew(List<P> parentValues){
        dataList.add(dataFactory.update<D,P>(dataList,parentValues,specs));
        for(var x in children)
            x._addNew(dataList);
    }
}