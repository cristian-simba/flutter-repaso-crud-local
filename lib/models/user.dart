class User{

  final String id;
  final String name;
  final String lastName;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.age
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      age: json['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'age': age
    };
  }

}
