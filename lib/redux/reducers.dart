import 'package:redux_contacts/model/app_model.dart';
import 'package:redux_contacts/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(contacts: contactReducer(state.contacts, action));
}

List<Contact> contactReducer(List<Contact> state, action) {
  if (action is AddContactAction) {
    return []
      ..addAll(state)
      ..add(Contact(id: action.id, name: action.contact));
  }

  if (action is RemoveContactAction) {
    return List.unmodifiable(List.from(state)..remove(action.contact));
  }

  if (action is RemoveContactsAction) {
    return List.unmodifiable([]);
  }

  return state;
}
