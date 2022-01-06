import 'interfaceIndicators/ohlc.dart';
import 'indicatorData.dart';
import 'ema.dart';
import 'heikenAshi.dart';
import 'sma.dart';
import 'stochastic.dart';
class IndicatorDataFactory<D extends IndicatorData,P extends IndicatorData>{
    final Map<String,dynamic> specs;
    IndicatorDataFactory(this.specs);
    D update(List<D> list,List<P> parentList){
        switch(D){
            case HeikenAshi:
                return getHeikenAshi((parentList.last as OHLC),list.last as HeikenAshi) as D;
            case EMA:
                List<dynamic> dynamicList = parentList;
                double recentValue = 0;
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                        recentValue = dynamicList.last.c;
                        break;
                    case Stochastic:
                    case EMA:
                        recentValue = dynamicList.last.value;
                        break;
                    default:
                        throw "$D $P wrongType";
                }
                return getEMA((list.last as EMA),recentValue,specs['period']) as D;
             case SMA:
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                    case Stochastic:
                    case SMA:
                    case EMA:
                        var values = <double>[];
                        List<dynamic> casted = parentList;
                        var start = casted.length-(specs['period'] as int); 
                        if(P==OHLC || P==HeikenAshi) for(int i=start;i<casted.length;i++) values.add(casted[i].c);
                        else for(int i=start;i<casted.length;i++) values.add(casted[i].value);
                        return getSMA(values) as D;
                    default:
                        throw "$D $P wrongType";
                }
            case Stochastic:
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                        return getStochastic(parentList,specs['period']) as D;
                    default:
                        throw "$D $P wrongType";
                }
            default:
                throw "$D wrongType";
        }
    }
    List<D> convert(List<P> parentList){
        switch(D){
            case EMA:
                var values = <double>[];
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                        for(var x in (parentList as List<dynamic>)) values.add(x.c);
                        break;
                    case Stochastic:
                        for(var x in (parentList as List<dynamic>)) values.add(x.value);
                        break;
                    default:
                        throw "$D $P wrongType";
                }
                return getEMAList(values,specs['period']).cast<D>();
            case Stochastic:
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                        return getStochasticList(parentList as List<dynamic>,specs['period']).cast<D>();
                    default:
                        throw "$D $P wrongType";
                }
            case SMA:
                switch(P){
                    case OHLC:
                    case HeikenAshi:
                    case Stochastic:
                    case SMA:
                    case EMA:
                        var values = <double>[];
                        List<dynamic> casted = parentList;
                        if(P==OHLC || P==HeikenAshi) for(int i=0;i<casted.length;i++) values.add(casted[i].c);
                        else for(int i=0;i<casted.length;i++) values.add(casted[i].value);
                        return getSMAList(values,specs['period']).cast<D>();
                    default:
                        throw "$D $P wrongType";
                }
            case HeikenAshi:
                switch(P){
                        case OHLC:
                            return getHeikenAshiList(parentList.cast<OHLC>()).cast<D>();
                        default:
                            throw "$D $P wrongType";
                }
            default:
                throw "$D $P wrongType";
        }
    }
}