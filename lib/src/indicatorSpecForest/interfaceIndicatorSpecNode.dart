import '../indicators/interfaceIndicators/interfaceIndicatorData.dart';
import '../indicatorDataForest/indicatorDataNode.dart';
import '../indicatorDataForest/interfaceIndicatorDataNode.dart';
import 'indicatorSpecNode.dart';
class InterfaceIndicatorSpecNode<D extends InterfaceIndicatorData>{
    final List<IndicatorSpecNode> children;
    InterfaceIndicatorSpecNode(this.children);
    InterfaceIndicatorDataNode<D> getInterfaceNode(){
        List<IndicatorDataNode> indicatorDataNodes = [];
        for(var x in children) indicatorDataNodes.add(x.getDataNode<D>());
        return InterfaceIndicatorDataNode<D>(indicatorDataNodes);
    }
}