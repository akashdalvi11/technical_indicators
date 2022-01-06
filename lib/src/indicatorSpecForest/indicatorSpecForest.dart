import '../indicators/interfaceIndicators/ohlc.dart';
import '../indicatorDataForest/indicatorDataForest.dart';
import 'interfaceIndicatorSpecNode.dart';
import 'historicalData.dart';
class IndicatorSpecForest{
    final int interval;
    final InterfaceIndicatorSpecNode<OHLC> ohlc;
    IndicatorSpecForest({required this.interval,required this.ohlc});
    build(HistoricalData data){
        var ohlcInterface = ohlc.getInterfaceNode();
        ohlcInterface.fill(data.ohlcList);
        return IndicatorDataForest(interval,data.dateTimeList,ohlcInterface);
    }
}