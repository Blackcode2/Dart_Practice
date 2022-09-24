import 'dart:math';
//import 'dart:io';

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
  
 //String? inputNums = stdin.readLineSync();
 //print('Your numbers : $inputNums');
 String? inputNums = '1234';
 
 List<String> replace = inputNums.split('');
 List<int> userNums = replace.map(int.parse).toList();
 result(userNums, lottoSet);
  
 print("${userNums}");
 print("${lottoSet}");
}

void result(List<int> userNums, List<int> lottoSet) {
  int strike = 0;
  int ball = 0;
  int out = 0;
  
  for(int i = 0; i < 4; i++) {
    if(userNums[i] == lottoSet[i]) {
      strike++;
    } else if(lottoSet.contains(userNums[i])) {
      ball++;
    } else {
      out++;
    }
  }
  
  print('${strike}S ${ball}B ${out}OUT');
  
}


