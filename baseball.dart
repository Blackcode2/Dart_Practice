import 'dart:math';

void main() {
 print("Computer is generating random four numbers...");
 
 List<int> lottoSet = [];
 
 while(true) {
   var rnd = new Random().nextInt(10);
   
   if(!lottoSet.contains(rnd)) {
     lottoSet.add(rnd);
   }
   
   if(lottoSet.length == 4) break;
 }
  
 
 print("${lottoSet}");
}

void result(int a, int b, int c, int d, List<int> lottoSet) {
  if(a == lottoSet[0]) 
}
