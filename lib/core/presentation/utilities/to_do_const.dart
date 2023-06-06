class TodoConsts {
  static List timeList = [
    '6am - 8am',
    '3am - 5am',
    '1am - 3am',
    '7am - 10am',
    '4am - 6am',
    '5am - 7am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
    '8am - 9am',
  ];

  static List weekList = [
    'TODAY',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];


  static final List<Map> myProducts =
      List.generate(100000, (index) => {'id': index, 'name': 'Product $index'}).toList();

  static String imageUrl =
      'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?s=612x612&w=0&k=20&c=kPvoBm6qCYzQXMAn9JUtqLREXe9-PlZyMl9i-ibaVuY=';
  static String profileImageUrl =
      'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=';
}
