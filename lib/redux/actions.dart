
import 'package:redux_contacts/model/app_model.dart';

class AddContactAction {
  static int _id = 0;
  final String contact;

  AddContactAction(this.contact) {
    _id++;
  }

  int get id => _id;
}

class RemoveContactAction {
  final Contact contact;

  RemoveContactAction(this.contact);
}

class RemoveContactsAction {}
