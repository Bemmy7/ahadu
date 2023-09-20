List<String> zeroth = ["፩", "፪", "፫", "፬", "፭", "፮", "፯", "፰", "፱"];
List<String> tenth = ["፲", "፳", "፴", "፵", "፶", "፷", "፸", "፹", "፺"];
List<String> special = ["፻", "፼"];

bool isNumeric(String str) {
  try {
    var value = double.parse(str);
  } on FormatException {
    return false;
  } finally {
    return true;
  }
}

// String convertToArab(String geez_number) {}

String convertToGeez(String arabic_number) {
  bool cancel = false;
  String arabicNumber;
  if (arabic_number == "") {
    return "";
  }
  try {
    int x = int.parse(arabic_number);
    arabicNumber = x.toString();

    if (x == 0) {
      cancel = true;
    }
  } on Exception {
    return "Invalid Input";
  }
  if (cancel) {
    return "There is no Value for Zero in Geez";
  }
  int index = 1;
  int subindex = 0;
  List<String> converted = [];
  String finalAnswer = "";

  for (int i = arabicNumber.length - 1; i >= 0; i--) {
    String temp = arabicNumber[i];
    if (index == 1) {
      index++;
      if (temp != "0") {
        converted.add(zeroth[int.parse(temp) - 1]);
      }
    } else if (index == 2) {
      index++;
      if (temp != "0") {
        converted.add(tenth[int.parse(temp) - 1]);
      }
    } else if (index == 3) {
      if (subindex == 1) {
        if (converted.last == special[0]) {
          print(converted);
          converted.removeLast();
        }
      }
      
      converted.add(special[subindex]);
      if (subindex == 1) {
        subindex = 0;
      } else {
        subindex += 1;
      }

      if (temp != "0" && temp != "1") {
        converted.add(zeroth[int.parse(temp) - 1]);
      }
      index = 2;
    }
  }
  for (int i = converted.length - 1; i >= 0; i--) {
    finalAnswer += converted[i];
  }
  return finalAnswer;
}
