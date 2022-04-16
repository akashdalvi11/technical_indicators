import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:kite_connect/kite_connect.dart' as kc;
import 'package:dartz/dartz.dart';
import 'package:technical_indicators/technical_indicators.dart';
void main(){
    late HistoricalData<Candle> historicalData;
    late kc.KiteConnect k;
    setUp(() async{
        var e = Platform.environment;
        var result = await kc.KiteConnect.create(e['userName']!,e['password']!,e['twoFA']!,'./test');
        result.fold(
            (l){
            throw l;
            },(r){
            k = r;
            }
        );
        var data = await k.getHistoricalData("NIFTY BANK",5,
        DateTime.parse('2022-03-30'),DateTime.parse('2022-04-01'));
        data.fold(
            (l){print(l);},
            (r){
                historicalData = HistoricalData.createOHLC(r.dateTimeList,r.ohlcList);
            }
        );
    });
    test('demo',(){
        print(historicalData.dataList);
        var specTree = IndicatorSpecTree<Candle>(
            5,
            [
                IndicatorSpecNode<HeikenAshi>({},[
                    IndicatorSpecNode<EMA>({'period':10},[]),
                    IndicatorSpecNode<Stochastic>({'period':10},[
                        IndicatorSpecNode<SMA>({'period':3},[
                            IndicatorSpecNode<SMA>({'period':3},[])
                        ])
                    ])
                ])
            ]
        );
        var dataTree = specTree.build(historicalData);
        print(dataTree.children[0].children[0].dataList);
        print(dataTree.children[0].children[1].dataList);
        print(dataTree.children[0].children[1].children[0].dataList);
        print(dataTree.children[0].children[1].children[0].children[0].dataList);
    });
}