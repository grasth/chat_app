String getTime(DateTime date) {
  DateTime dateNow = DateTime.now();
  var passedDays = dateNow.difference(date).inDays;
  if (passedDays < 30 && passedDays > 0) {
    return passedDays.toString() +
        (passedDays == 1 ? " day" : " days") +
        " ago";
  }
  if (passedDays == 0) {
    var passedHour = dateNow.difference(date).inHours;
    if (passedHour == 0) {
      var passedmin = dateNow.difference(date).inMinutes;
      return passedmin.toString() +
          (passedmin == 1 ? " min." : " mins.") +
          " ago";
    } else
      return passedHour.toString() +
          (passedHour == 1 ? " hour" : " hours") +
          " ago";
  }
}
