import 'dart:collection';

final class Customer extends LinkedListEntry<Customer> {
  String id;
  String name;
  String age;

  Customer(this.id, this.name, this.age);

  String toString() {
    return '$id\t\t$name\t\t$age';
  }
}
