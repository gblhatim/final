class Message {
  late String id;
  late String uid;
  late String lien;
  late String sujet_e;
  late String sujet_e_en;
  late String text_e;
  late String text_e_en;
  late String text_s;
  late String text_s_en;
  late bool isEmail;
  late bool isSMS;
  late String language;

  Message(
      {required this.id,
      required this.uid,
      required this.lien,
      required this.sujet_e,
      required this.sujet_e_en,
      required this.text_e,
      required this.text_e_en,
      required this.text_s,
      required this.text_s_en,
      required this.isEmail,
      required this.isSMS,
      required this.language});

  String getMessage() {
    print(this.isEmail.toString() +
        " " +
        this.isSMS.toString() +
        " " +
        this.language);
    switch (this.language) {
      case "Fr":
        switch (this.isSMS) {
          case true:
            return this.text_s + " " + this.lien;
          case false:
            return this.sujet_e + " " + this.text_e + " " + this.lien;
        }
        break;

      case "En":
        switch (this.isSMS) {
          case true:
            return this.text_s_en + " " + this.lien;
          case false:
            return this.sujet_e_en + " " + this.text_e_en + " " + this.lien;
        }
        break;
    }

    return "";
  }

  Message.init() {
    print("init");
  }
}
