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
  int strike = 0;
  int ball = 0;
  
  if(a == lottoSet[0]) {
    strike++;
  } else if(lottoSet.contains(a)) {
    ball ++;
  }
  
  if(b == lottoSet[1]) {
    strike++;
  } else if(lottoSet.contains(b)) {
    ball ++;
  }
  
  if(c== lottoSet[2]) {
    strike++;
  } else if(lottoSet.contains(c)) {
    ball ++;
  }
  
  if(d == lottoSet[3]) {
    strike++;
  } else if(lottoSet.contains(d)) {
    ball ++;
  }
  
  if(strike !=0 || ball != 0) {
    print('$strike S $ball B');
  } else {
    print('4 Out');
  }
  
}

