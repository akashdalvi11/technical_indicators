
# Technical Indicators

A technical Indicators package written in dart.
there are two main things this package does... it creates an "indicator tree" and it updates that "indicator tree" as quote data is fed into it.

# Installation

``` yaml
dependencies:
  technical_indicators:
    git:
      url: git://github.com/akashdalvi11/technical_indicators.git
```

``` dart
import 'package:technical_indicators/techincal_indicators.dart';
```
# usage
``` dart
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
```
