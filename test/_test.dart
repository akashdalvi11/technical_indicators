import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:technical_indicators/technical_indicators.dart';
void main(){
    late HistoricalData<Candle> historicalData;
    setUp(() async{
        var s = await File('./test/testData.json').readAsString();
        var parsed = json.decode(s);
        var candles = parsed['data']['candles'];
        List<DateTime> dateTimes = [];
        List<Candle> ohlcs = [];
        double intToDouble(dynamic t){
            if(t is double) return t;
            else return t.toDouble();
        }
        for(var candle in candles){
            dateTimes.add(DateTime.parse(candle[0]));
            ohlcs.add(Candle(intToDouble(candle[1]),intToDouble(candle[2]),intToDouble(candle[3]),intToDouble(candle[4])));
        }
        historicalData = HistoricalData<Candle>(dateTimes,ohlcs);
    });
    test('ema demo',(){
        var specTree = IndicatorSpecTree<Candle>(
            interval:15,
            children:[
                IndicatorSpecNode<EMA>({'period':5},[
                    IndicatorSpecNode<SMA>({'period':2},[])
                ])
            ]
        );
        var dataTree = specTree.build(historicalData);
        print(dataTree.children[0].values);
    });
}