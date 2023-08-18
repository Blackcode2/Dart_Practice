import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() async {
  while (true) {
    print('====Customer Managment System====');
    print('1. Add new');
    print('2. View list');
    print('3. Update list');
    print('4. Delete');
    print('5. Exit\n');
    stdout.write('Choose menu by number: ');

    String? pick = stdin.readLineSync();
    print('');

    if (pick == '1') {
      String? id;
      while (true) {
        stdout.write('ID: ');
        id = stdin.readLineSync();
        if (id != '') break;
        print('Try again.');
      }

      String? name;
      while (true) {
        stdout.write('Name: ');
        name = stdin.readLineSync();
        if (name != '') break;
        print('Try again.');
      }

      String? age;
      while (true) {
        stdout.write('Age: ');
        age = stdin.readLineSync();
        if (age != '' && int.tryParse(age!) != null) break;
        print('Try again.');
      }

      final filename = 'file.txt';
      var file = await File(filename)
          .writeAsString('${id} ${name} ${age}\n', mode: FileMode.append);

      print('\nInformation added!\n');
    } else if (pick == '2') {
      //View List

      final file = File('file.txt');
      Stream<String> lines = file
          .openRead()
          .transform(utf8.decoder) // Decode bytes to UTF-8.
          .transform(LineSplitter()); // Convert stream to individual lines.
      try {
        print("ID     Name          Age");
        print("= = = = = = = = = = = = = ");
        await for (var line in lines) {
          List<String> info = line.split(' ');
          print('${info[0]}      ${info[1]}           ${info[2]}');
        }
      } catch (e) {
        print('Error: $e');
      }
      print('');
    } else if (pick == '3') {
      //Update List

      List twoDList = List.generate(10, (_) => [], growable: true); //2d list
      final file = File('file.txt');
      Stream<String> lines = file
          .openRead()
          .transform(utf8.decoder) // Decode bytes to UTF-8.
          .transform(LineSplitter()); // Convert stream to individual lines.

      int count = 0;
      try {
        print("ID     Name          Age");
        print("= = = = = = = = = = = = = ");

        await for (var line in lines) {
          print('\n$line\n');
          twoDList[count] = line.split(' '); // put into 2d list
          count++;
        }
      } catch (e) {
        print('Error: $e');
      }
      //print(twoDList); for debug
      String? pick;
      while (true) {
        stdout.write('Pick by ID: ');
        pick = stdin.readLineSync();
        if (pick != '') break;
        print('Try again.');
      }

      for (int i = 0; i < count; i++) {
        if (pick == twoDList[i][0]) {
          twoDList[i].removeRange(0, 3);

          // update new information
          String? id;
          while (true) {
            stdout.write('ID: ');
            id = stdin.readLineSync();
            if (id != '') break;
            print('Try again.');
          }

          String? name;
          while (true) {
            stdout.write('Name: ');
            name = stdin.readLineSync();
            if (name != '') break;
            print('Try again.');
          }

          String? age;
          while (true) {
            stdout.write('Age: ');
            age = stdin.readLineSync();
            if (age != '' && int.tryParse(age!) != null) break;
            print('Try again.');
          }

          // another way to add in the list
          // twoDList.removeAt(i);
          // twoDList[i].addAll([id, name, age]);

          twoDList[i].add(id);
          twoDList[i].add(name);
          twoDList[i].add(age);

          final filename = 'file.txt';
          int inputCount = 0;
          while (twoDList[inputCount].isNotEmpty) {
            if (inputCount == 0) {
              var file = await File(filename).writeAsString(
                  '${twoDList[inputCount][0]} ${twoDList[inputCount][1]} ${twoDList[inputCount][2]}\n');
              inputCount++; // First line in new file;
            } else {
              var file = await File(filename).writeAsString(
                  '${twoDList[inputCount][0]} ${twoDList[inputCount][1]} ${twoDList[inputCount][2]}\n',
                  mode: FileMode.append);
              inputCount++; // Rest lines are appended.
            }
          }

          print("List is updated!");
          break;
        }
      }
    } else if (pick == '4') {
      //rmove information
      int count = 0;
      String? pick;
      while (true) {
        stdout.write(
            'Delete one person\'s information -> press 1.\nDelete all information -> press 2: ');
        pick = stdin.readLineSync();
        if (pick != '') break;
        print('Try again.');
      }
      if (pick == '1') {
        var twoDList = List.generate(10, (_) => []); //2d list
        final file = File('file.txt');
        Stream<String> lines = file
            .openRead()
            .transform(utf8.decoder) // Decode bytes to UTF-8.
            .transform(LineSplitter()); // Convert stream to individual lines.
        try {
          print("ID     Name          Age");
          print("= = = = = = = = = = = = = ");
          await for (var line in lines) {
            List<String> info = line.split(' ');
            print('${info[0]}      ${info[1]}           ${info[2]}');
            twoDList[count] = line.split(' '); // put into 2d list
            count++;
          }
        } catch (e) {
          print('Error: $e');
        }
        //print(twoDList); for debug
        String? pick;
        while (true) {
          stdout.write('Pick by ID: ');
          pick = stdin.readLineSync();
          if (pick != null) break;
          print('Try again.');
        }
        for (int i = 0; i < 10; i++) {
          if (pick == twoDList[i][0]) {
            twoDList[i].removeRange(0, 3);
            //print(twoDList); for debug
            break;
          }
        }

        final filename = 'file.txt';
        int inputCount = 0;
        for (int i = 0; i < count; i++) {
          if (twoDList[i].isNotEmpty) {
            if (inputCount == 0) {
              var file = await File(filename).writeAsString(
                  '${twoDList[i][0]} ${twoDList[i][1]} ${twoDList[i][2]}\n'); // First line in new file
              inputCount++;
            } else {
              var file = await File(filename).writeAsString(
                  '${twoDList[i][0]} ${twoDList[i][1]} ${twoDList[i][2]}\n',
                  mode: FileMode.append);
              // Rest lines are appended.
            }
          } else {
            continue;
          }
        }
        print("List is updated!");
      } else if (pick == '2') {
        final filename = 'file.txt';
        var file = await File(filename).writeAsString('');
        print('Deleted all information');
      } else {
        print('Try again!');
      }
    } else if (pick == '5') {
      exit(0);
    } else {
      print('Error, try again');
      continue;
    }
  }
}
