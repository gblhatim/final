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

    Map<String, String> message = {};
    List<Map<String, String>> messages = [];

    switch (this.isEmail) {
      case false:
        message.putIfAbsent("type", () => "sms");
        switch (this.language) {
          case "En":
            message.putIfAbsent(
                "messageSMS", () => this.text_s_en + " " + this.lien);
            break;

          case "Fr":
            message.putIfAbsent(
                "messageSMS", () => this.text_s + " " + this.lien);
            break;
        }

        messages.add(message);
        break;

      case true:
        message.putIfAbsent("type", () => "both");
        switch (this.language) {
          case "En":
            message.putIfAbsent(
                "messageSMS", () => this.text_s_en + " " + this.lien);
            message.putIfAbsent("messageEmail",
                () => this.sujet_e_en + " " + this.text_e_en + " " + this.lien);
            break;
          case "Fr":
            message.putIfAbsent(
                "messageSMS", () => this.text_s + " " + this.lien);
            message.putIfAbsent("messageEmail",
                () => this.sujet_e + " " + this.text_e + " " + this.lien);
            break;
        }

        messages.add(message);
        break;
    }

    message.forEach((key, value) {
      print(key + " : " + value);
    });

    return "";
  }

  Message.init() {
    print("init");
  }
}
