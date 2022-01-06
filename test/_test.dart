import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:technical_indicators/technical_indicators.dart';
void main(){
    late HistoricalData historicalData;
    setUp(() async{
        var s = await File('./test/testData.json').readAsString();
        var parsed = json.decode(s);
        var candles = parsed['data']['candles'];
        List<DateTime> dateTimes = [];
        List<OHLC> ohlcs = [];
        double intToDouble(dynamic t){
            if(t is double) return t;
            else return t.toDouble();
        }
        for(var candle in candles){
            dateTimes.add(DateTime.parse(candle[0]));
            ohlcs.add(OHLC(intToDouble(candle[1]),intToDouble(candle[2]),intToDouble(candle[3]),intToDouble(candle[4])));
        }
        historicalData = HistoricalData(dateTimes,ohlcs);
    });
    test('ema demo',(){
        var f = IndicatorSpecForest(interval:15,ohlc:InterfaceIndicatorSpecNode<OHLC>(
            [
                IndicatorSpecNode<EMA>({'period':5},[
                    IndicatorSpecNode<SMA>({'period':2},[])
                ])
            ]
        ));
        var dataForest = f.build(historicalData);
        print(dataForest.ohlc.children[0].list);
    });
}