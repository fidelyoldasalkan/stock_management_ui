class DateUtil {

  static String apiDate(DateTime date) {
    final day = date.day < 10 ? "0${date.day}" : "${date.day}";
    final month = date.month < 10 ? "0${date.month}" : "${date.month}";
    return "${date.year}-$month-$day";
  }

  static String ddMmYy(DateTime date) {
    final day = date.day < 10 ? "0${date.day}" : "${date.day}";
    final month = date.month < 10 ? "0${date.month}" : "${date.month}";
    return "$day/$month/${date.year}";
  }

  static String ddMmYyStr(String? dateStr) {
    if (dateStr == null) {
      return "";
    }

    final s = dateStr.split("-");

    if (s.isEmpty) {
      return "";
    }

    return "${s[2]}/${s[1]}/${s[0]}";
  }
}