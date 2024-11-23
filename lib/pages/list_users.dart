import 'package:flutter/material.dart';
import 'package:local_crud/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:local_crud/models/user.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({ Key? key }) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  int addId = 3;
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  // Variables para el formulario de edición
  TextEditingController _editControllerName = TextEditingController();
  TextEditingController _editControllerLastName = TextEditingController();
  TextEditingController _editControllerAge = TextEditingController();
  String? _editingUserId;

  // Método para abrir el formulario de editar
  void _editUser(User user) {
    _editControllerName.text = user.name;
    _editControllerLastName.text = user.lastName;
    _editControllerAge.text = user.age.toString();
    _editingUserId = user.id;
  }

  @override
  Widget build(BuildContext context) {

    void increment(){
      setState(() {
        addId++; // Incrementa el valor de addId
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
        title: Text("Lista de usuarios", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controllerName,
            decoration: InputDecoration(label: Text("Nombre")),
          ),
          TextField(
            controller: _controllerLastName,
            decoration: InputDecoration(label: Text("Apellido")),
          ),
          TextField(
            controller: _controllerAge,
            decoration: InputDecoration(label: Text("Edad")),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).addUser(
                User(
                  id: addId.toString(), 
                  name: _controllerName.text, 
                  lastName: _controllerLastName.text, 
                  age: int.parse(_controllerAge.text)
                )
              );
              increment();
            }, 
            child: Text("Agregar")
          ),
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    User user = userProvider.users[index];
                    return ListTile(
                      title: Text(user.name + " " + user.lastName),
                      subtitle: Text("Edad: " + user.age.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editUser(user); // Llamamos al método para llenar el formulario de edición
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Editar Usuario'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _editControllerName,
                                          decoration: InputDecoration(label: Text("Nombre")),
                                        ),
                                        TextField(
                                          controller: _editControllerLastName,
                                          decoration: InputDecoration(label: Text("Apellido")),
                                        ),
                                        TextField(
                                          controller: _editControllerAge,
                                          decoration: InputDecoration(label: Text("Edad")),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Actualizamos el usuario
                                          if (_editingUserId != null) {
                                            Provider.of<UserProvider>(context, listen: false).updateUser(
                                              _editingUserId!,
                                              User(
                                                id: _editingUserId!,
                                                name: _editControllerName.text,
                                                lastName: _editControllerLastName.text,
                                                age: int.parse(_editControllerAge.text),
                                              ),
                                            );
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text("Actualizar"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Cancelar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 20, color: Colors.red),
                            onPressed: () {
                              userProvider.deleteUser(user.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Usuario Eliminado")),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
