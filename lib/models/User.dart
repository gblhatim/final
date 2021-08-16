class User {
  late String nom;
  late String email;
  late String id;
  late String password;
  late String etat;

  User({
    required this.nom,
    required this.email,
    required this.id,
    required this.password,
    required this.etat,
  });

  User.init() {
    print("init");
  }
  User.init1() {
    nom = "";
    email = "";
  }
}
