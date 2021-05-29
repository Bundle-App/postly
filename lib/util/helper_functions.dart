

extension MyString on String {
  String firstCharacter() => this.substring(0,1).toUpperCase();
  String toInitialCaps() => this.substring(0,1).toUpperCase()+this.substring(1);
}
