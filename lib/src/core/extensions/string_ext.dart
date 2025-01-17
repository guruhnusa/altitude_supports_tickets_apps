extension StringExt on String {
  bool get isEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  //buatkan extension untuk membuat huruf pertama menjadi huruf besar
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
