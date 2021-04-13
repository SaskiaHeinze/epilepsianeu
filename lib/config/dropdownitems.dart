class Duration {
  final int id;
  final String duration;

  const Duration(this.id, this.duration);
}
//Dropdownmenü für Auswahl der Sportdauer
const List<Duration> getDuration = <Duration>[
  Duration(1, '10 Minuten'),
  Duration(2, '20 Minuten'),
  Duration(3, '30 Minuten'),
  Duration(4, '45 Minuten'),
  Duration(5, '60 Minuten'),
  Duration(6, '90 Minuten'),
];
