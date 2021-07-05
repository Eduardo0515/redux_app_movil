import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_contacts/model/app_model.dart';
import 'package:redux/redux.dart';
import 'package:redux_contacts/pages/integrantes.dart';
import 'package:redux_contacts/redux/actions.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombres'),
        centerTitle: true,
        actions: [],
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Column(
          children: <Widget>[
            AddContactWidget(viewModel),
            Expanded(
              child: ContactListWidget(viewModel),
            ),
            RemoveContactsButton(viewModel)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Integrantes()),
          );
        },
      ),
    );
  }
}

class AddContactWidget extends StatefulWidget {
  final _ViewModel model;

  AddContactWidget(this.model);

  @override
  State<StatefulWidget> createState() => _AddContactState();
}

class _AddContactState extends State<AddContactWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 10, 60, 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Escribe un nombre',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.red)),
        ),
        onSubmitted: (String name) {
          if (name.isNotEmpty) {
            widget.model.onAddContact(name);
            controller.text = '';
          }
        },
      ),
    );
  }
}

class RemoveContactsButton extends StatelessWidget {
  final _ViewModel model;

  RemoveContactsButton(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 10, 60, 20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10.0,
            shadowColor: Colors.blue,
            primary: Colors.red,
            minimumSize: Size(88, 42),
            padding: EdgeInsets.symmetric(horizontal: 12),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onPressed: () => {model.onRemoveContacts()},
          child: Text('Eliminar todos los nombres')),
    );
  }
}

class ContactListWidget extends StatelessWidget {
  final _ViewModel model;

  ContactListWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: model.contacts
          .map((Contact contact) => ListTile(
                title: Text(
                  contact.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent.shade200,
                  ),
                  onPressed: () => model.onRemoveContact(contact),
                ),
              ))
          .toList(),
    );
  }
}

class _ViewModel {
  final List<Contact> contacts;
  final Function(String) onAddContact;
  final Function(Contact) onRemoveContact;
  final Function() onRemoveContacts;

  _ViewModel(this.contacts, this.onAddContact, this.onRemoveContact,
      this.onRemoveContacts);

  factory _ViewModel.create(Store<AppState> store) {
    _onAddContact(String name) {
      store.dispatch(AddContactAction(name));
    }

    _onRemoveContact(Contact contact) {
      store.dispatch(RemoveContactAction(contact));
    }

    _onRemoveContacts() {
      store.dispatch(RemoveContactsAction());
    }

    return _ViewModel(store.state.contacts, _onAddContact, _onRemoveContact,
        _onRemoveContacts);
  }
}
