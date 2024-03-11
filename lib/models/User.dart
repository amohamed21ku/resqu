class User {
  String full_name;
  String disability;
  int floor;
  int apartment;
  String email;
  bool has_disability;
  bool is_home;

  User({
    required this.full_name,
    required this.disability,
    required this.floor,
    required this.apartment,
    required this.email,
    required this.has_disability,
    required this.is_home,
  });

  static User currentUser = User(
  full_name: '',
  disability: '',
  floor: 0,
  apartment: 0,
  email: '', has_disability: true, is_home: true);}