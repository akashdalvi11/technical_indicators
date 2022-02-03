
# Technical Indicators

A technical Indicators package written in dart.
there are two main things this package does... it creates a "indicator forest" and it updates
that "indicator forest" as quote data is fed into it.





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
  interval:15,
  children:[
      IndicatorSpecNode<EMA>({'period':5},[
        IndicatorSpecNode<SMA>({'period':2},[])
      ])
  ]
);
var dataTree = specTree.build(historicalData);
print(dataTree.children[0].values)//EMA values from Candles
print(dataTree.children[0].children[0].values) //SMA values from EMA

dataTree.update(Event(DateTime.now(),5.34)); //respective quote data is fed
```
