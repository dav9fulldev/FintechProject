class OnboardingData {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? countryCode; // Indicatif pays (ex: +225, +221, etc.)
  String? profession;
  String? incomeRange;
  List<String> goals;
  List<String> categories;

  OnboardingData({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.countryCode,
    this.profession,
    this.incomeRange,
    this.goals = const [],
    this.categories = const [],
  });

  String? get fullPhoneNumber {
    if (phone == null || countryCode == null) return null;
    return '$countryCode$phone';
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'phone': fullPhoneNumber,
      'profession': profession,
      'income_range': incomeRange,
      'goals': goals,
      'spending_categories': categories,
    };
  }
}
