abstract class OHLC{
    final double o,h,l,c;
    OHLC(this.o,this.h,this.l,this.c);
    @override
    String toString(){
        return '$o,$h,$l,$c';
    }
}