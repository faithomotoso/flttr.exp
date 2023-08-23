class Contact {
  late final String firstName;
  late final String lastName;
  late final String title;
  late final String email;
  late final String imageUrl;

  String get fullName => "$firstName $lastName".trim();

  Contact.fromJson({required Map<String, dynamic> json}) {
    Map<String, String> nameMap = Map.from(json["name"]);
    Map<String, String> pictureMap = Map.from(json["picture"]);

    this.firstName = nameMap["first"] ?? "";
    this.lastName = nameMap["last"] ?? "";
    this.title = nameMap["title"] ?? "";
    this.email = json["email"] ?? "";
    this.imageUrl = pictureMap["medium"] ?? "";
  }
}
