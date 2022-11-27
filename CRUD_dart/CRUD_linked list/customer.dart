import 'dart:collection';

class Customer extends LinkedListEntry<Customer> {
    String id;
    String name;
    String age;

    Customer(this.id, this.name, this.age);

    String toString() {
        return '$id\t\t$name\t\t$age';
    }
}

// void main() {
//     final linkedList = new LinkedList<Customer>();
//     linkedList.addAll(
//         [Customer('1', 'kim', '23'), Customer('2', 'lee', '34')]
//     );
//     print(linkedList.first);
// }