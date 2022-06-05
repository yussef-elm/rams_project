class CustomUser{

  final String? uid;
  CustomUser({this.uid});

  factory CustomUser.initialData() {
    return CustomUser(
      uid: '',
    );
  }
}