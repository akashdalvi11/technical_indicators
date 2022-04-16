import '../interfaceIndicatorData.dart';
import 'singleValued.dart';
class Volume extends SingleValued implements InterfaceIndicatorData{
    Volume(double value):super(value);
    String toString()=> super.toString();
}