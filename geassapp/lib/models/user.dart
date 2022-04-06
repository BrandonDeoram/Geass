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
}
