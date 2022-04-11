class User {
  final String userName;
  final String userAt;
  final String email;
  final List<String> planToWatch;
  final List<String> watching;
  final List<String> finished;
  final List<String> favourites;

  User(this.userName, this.userAt, this.email, this.planToWatch, this.watching,
      this.finished, this.favourites);
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      data['userName'],
      data['atName'],
      data['email'],
      data['planToWatch'],
      data['watching'],
      data['finished'],
      data['favourites'],
    );
  }
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'userAt': userAt,
        'email': email,
        'plantToWatch': planToWatch,
        'watching': watching,
        'finished': finished,
        'favourites': favourites,
      };
}
