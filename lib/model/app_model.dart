
class AppState{
  final List<Contact> contacts;

  AppState({
    required this.contacts,
  });

  AppState.initialState() : contacts = List.unmodifiable(<Contact>[]);
}

class Contact{
  final int id;
  final String name;

  Contact({required this.id, required this.name});

  Contact copyWith({required int id, required String name}){
    return Contact(id:id, name: name);
  }
}
