import 'dart:math';
import 'dart:io';

void main() {
  print("Computer is generating random four numbers... \n");
 
  List<int> randomComputerNums = [];
 
  while(true) {
    var rnd = new Random().nextInt(10);
   
    if(!randomComputerNums.contains(rnd)) {
      randomComputerNums.add(rnd);
    }
   
    if(randomComputerNums.length == 4) break;
  }
  print("Computer generated random four numbers! \n");

  while(true){
    guessNums(result, randomComputerNums);  //get user input
  }
  
}



// Input user's guessing four numbers
void guessNums(Function result, List<int> randomComputerNums) {
  
  String? inputNums;
  while(true) {    // keep roop until there is no wrong format
    print('Guess the numbers : ');
    inputNums = stdin.readLineSync();
    
      
    if(inputNums != null && inputNums.length == 4 && int.parse(inputNums).runtimeType == int) {
      List<String> inputNumsToStringList = inputNums.split('');
      Set<String> crossCheck = inputNumsToStringList.toSet();
      inputNumsToStringList = crossCheck.toList();
      if(inputNumsToStringList.length == 4) break;
    }
    print('Warning, pick four different numbers!');
  }

  List<String> inputNumsToStringList = inputNums.split('');
  List<int> userNums = inputNumsToStringList.map(int.parse).toList();
  result(userNums, randomComputerNums);  //check the result
    
  print("${userNums}");
  print("${randomComputerNums}");  //for test
}



// function that shows game result
void result(List<int> userNums, List<int> randomComputerNums) {
  int strike = 0;
  int ball = 0;
  int out = 0;
  
  for(int i = 0; i < 4; i++) {
    if(userNums[i] == randomComputerNums[i]) {
      strike++;
    } else if(randomComputerNums.contains(userNums[i])) {
      ball++;
    } else {
      out++;
    }

    if(strike == 4) {
      print("You win!!");
      exit(0); 
    }
  }
  
  print('${strike}S ${ball}B ${out}OUT');
  
}


