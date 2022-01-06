import '../indicators/indicatorData.dart';
import '../indicatorDataForest/indicatorDataNode.dart';
class IndicatorSpecNode<D extends IndicatorData>{
    final Map<String,dynamic> specs;
    final List<IndicatorSpecNode> children;
    IndicatorSpecNode(this.specs,this.children);
    IndicatorDataNode<D,P> getDataNode<P extends IndicatorData>(){
        List<IndicatorDataNode> indicatorDataNodes = [];
        for(var x in children) indicatorDataNodes.add(x.getDataNode<D>());
        return IndicatorDataNode<D,P>(specs,indicatorDataNodes);
    }
}