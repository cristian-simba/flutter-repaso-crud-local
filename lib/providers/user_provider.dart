import 'package:flutter/material.dart';
import 'package:local_crud/models/user.dart';

class UserProvider with ChangeNotifier{
  List<User> _users = [
    User(id: "1", name: "David", lastName: "Simba", age: 20),
    User(id: "2", name: "David", lastName: "Simba", age: 22)
  ];

  List<User> get users => _users;

  void addUser(User user){
    _users.add(user);
    notifyListeners();
  }

  void updateUser(String id, User updateUser){
    int index = _users.indexWhere((user)=>user.id == id);
    if(index != -1){
      _users[index] = updateUser;
      notifyListeners();
    } 
  }

  void deleteUser(String id){
    _users.removeWhere((user)=>user.id == id);
    notifyListeners();
  }
  
}