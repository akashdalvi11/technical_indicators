import '../indicators/interfaceIndicatorData.dart';
import '../indicatorDataTree/indicatorDataTree.dart';
import 'historicalData.dart';
import 'indicatorSpecNode.dart';
class IndicatorSpecTree<D extends InterfaceIndicatorData>{
    final int interval;
    final List<IndicatorSpecNode> children;
    IndicatorSpecTree(this.interval,this.children);
    IndicatorDataTree<D> build(HistoricalData<D> data){
        List<IndicatorDataNode> indicatorDataNodes = [];
        for(var x in children) indicatorDataNodes.add(x.getDataNode<D>());
        var dataTree = IndicatorDataTree<D>(interval,data.dateTimeList,indicatorDataNodes);
        dataTree.fill(data.dataList);
        return dataTree;
    }
}