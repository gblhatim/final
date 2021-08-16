class Profiles {
  late String uid;
  late String enom;
  late String eville;
  late String eprovince;
  late String epays;
  late String tele;
  late String esite;
  late String secteur;
  late String eadresse;

  Profiles({
    required this.uid,
    required this.enom,
    required this.eadresse,
    required this.eville,
    required this.eprovince,
    required this.epays,
    required this.tele,
    required this.esite,
    required this.secteur,
  });
  Profiles.init() {
    tele = "";
    eadresse = "";
    esite = "";
  }
}
