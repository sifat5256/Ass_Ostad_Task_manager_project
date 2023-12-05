class Networkresponce{
final  String ?errortext;
 final int ?statuscode;
 final bool isSuccess;
 final dynamic?jsonresponce;

 Networkresponce({
   this.errortext='Something iswrong',
   this.statuscode=-1,
   required this.isSuccess,
   this.jsonresponce

 });
}