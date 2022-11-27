import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'customer.dart';
import 'dart:collection';
import 'dart:math';

void main() async{
    final Set<String> idSet = {};
    int globalCount = 0;
    final customerList = new LinkedList<Customer>();                //create linked list that is going to have customers information
    globalCount = await readFile(new File('file.txt'), idSet, globalCount, customerList);      
    
    while(true){
        showMenu();
        stdout.write('Choose menu by number: ');

        String? pick = stdin.readLineSync();
        print('');

        if(pick == '1') {
            globalCount = await writeFile('file.txt', getInput(idSet, 0), globalCount, customerList);
            print('\nInformation added!\n');
        } else if(pick == '2') {
            showFile(customerList);
        } else if(pick == '3') {
            if(customerList.length == 0) {
                print('There is no information to update.\n');
                continue;
            }
            await updateFile('file.txt', customerList, idSet, globalCount);
        } else if(pick == '4') {
            await deleteFile('file.txt', customerList, globalCount);
            globalCount--;
        } else if(pick == '5') {
            exit(0);
        } else {
            print('Try again!');
        }
    }
}

void showMenu(){
    print('====Customer Managment System====');
    print('1. Add new');
    print('2. View list');
    print('3. Update list');
    print('4. Delete');
    print('5. Exit\n');
}

void showFile(LinkedList<Customer> customerList) {
    int count = 1;
    print('No.\t ID\t\tName\t\tAge');
    print('-----------------------------------------------------');
    for (var customer in customerList) {
        print('${count++}\t|${customer}');
    }
    print('');
}

// mode is to identify if it is for adding new informatin or updating information.
// If this funtion is called for update, there is no need to generate new ID.
List<String> getInput(Set<String> idSet, int mode) {
    if(mode == 0) {
        // create random num for ID
        int id = 0;
        final random = new Random();
        int preIdSetLength = idSet.length;
        while(true) {

            id = random.nextInt(1000)+1;
            idSet.add(id.toString());
            if(preIdSetLength < idSet.length) break;
        }

        String? name;
        while (true) {
            stdout.write('Name: ');
            name = stdin.readLineSync();
            if (name != null) break;
            print('Try again.');
        }
        String? age;
        while (true) {
            stdout.write('Age: ');
            age = stdin.readLineSync();
            if (age != null && int.parse(age).runtimeType == int) break;
            print('Try again.');
        }

        return [id.toString(), name, age];
    } else if(mode == 1) {
        String? name;
        while (true) {
            stdout.write('Name: ');
            name = stdin.readLineSync();
            if (name != null) break;
            print('Try again.');
        }
        String? age;
        while (true) {
            stdout.write('Age: ');
            age = stdin.readLineSync();
            if (age != null && int.parse(age).runtimeType == int) break;
            print('Try again.');
        }

        return ['0', name, age];
    }

    return ['Error'];
}

Future<int> writeFile(final filename, List<String> inputs, int globalCount, final customerList) async{
    var file = await File(filename).writeAsString('${++globalCount} ${inputs[0]} ${inputs[1]} ${inputs[2]}\n', mode: FileMode.append);
    customerList.add(Customer(inputs[0], inputs[1], inputs[2]));
    return globalCount;

}

Future<int> readFile(final file, Set<String> idSet, int globalCount, final customerList) async{
    List<Customer> inputCustomerList = [];
    try {
        if (await file.exists()) {
            Stream<String> lines = file.openRead()
                .transform(utf8.decoder)       // Decode bytes to UTF-8.
                .transform(LineSplitter());    // Convert stream to individual lines.
            try {
                await for (var line in lines) {
                    List<String> lineSplit = line.split(' ');
                    if(line == null) {
                        break;
                    }
                    globalCount++;
                    customerList.add(Customer(lineSplit[1], lineSplit[2], lineSplit[3]));
                    //inputCustomerList.add(Customer(lineSplit[1], lineSplit[2], lineSplit[3]));
                    idSet.add(lineSplit[1]);
                }
                
            } catch (e) {
                print('Error: $e');
                exit(0);
            }
        }
        await file.create();
    } on IOException catch (e) {
        print('Error: $e');
        exit(0);
    }
    

    return globalCount;
}

Future<void> updateFile(final filename, LinkedList<Customer> customerList, Set<String> idSet, int globalCount) async {
    showFile(customerList);
    String? pick;
    while(true) {
        print('0: back to Menu');
        stdout.write('Choose No. which you want to change information: ');
        pick = stdin.readLineSync();
        
        if(pick != null && int.parse(pick) <= globalCount) {
            print(''); 
            break;
        }
        print('Pick No. or 0!');   
    }
    if(pick == '0') {
        return null;
    }

    List<String> updateInput = getInput(idSet, 1);
    customerList.elementAt(int.parse(pick)-1).name = updateInput[1];
    customerList.elementAt(int.parse(pick)-1).age = updateInput[2];
    await rewriteFile(filename, customerList);
    
    print('File is updated!');
    showFile(customerList);
}

Future<void> rewriteFile(final filename, LinkedList<Customer> customerList) async{
    int count = 0;
    int countForFile = 1;
    for(int i = 0; i < customerList.length; i++) {
        if(count == 0) {
            var file = await File(filename).writeAsString('${countForFile++} ${customerList.elementAt(i).id} ${customerList.elementAt(i).name} ${customerList.elementAt(i).age}\n');
            count++;
        } else {
            var file = await File(filename).writeAsString('${countForFile++} ${customerList.elementAt(i).id} ${customerList.elementAt(i).name} ${customerList.elementAt(i).age}\n', mode: FileMode.append);
        }
    }
}

Future<void> deleteFile(final filename, LinkedList<Customer> customerList, int globalCount) async{
    String? pick;
    while(true){
        print('0: Back to menu');
        print('1: delete one line of information.');
        print('2: delete whole lines of information witn the file');
        stdout.write('Pick: ');
        pick = stdin.readLineSync();

        if(pick == '1') {
            if(customerList.length == 0) {
                print('\nThere is no information to delete.\n');
                continue;
            }
            showFile(customerList);
            String? deletePick;
            while(true) {
                stdout.write('Choose No. which you want to delete: ');
                deletePick = stdin.readLineSync();

                if(deletePick != null && int.parse(deletePick) <= globalCount) {
                    print(''); 
                    break;
                }
                print('Pick No.!');   
            }
            customerList.remove(customerList.elementAt(int.parse(deletePick)-1));
            await rewriteFile(filename, customerList);
            print('The information is deleted!');
            showFile(customerList);
            break;
        } else if(pick == '2') {
            customerList.clear();
            await File(filename).delete();
            break;
        } else if(pick == '0') {
            break;
        }
        print('Wrong! Pick No.!');   
    }
}
