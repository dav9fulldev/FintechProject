// Pays de l'UEMOA (Union Économique et Monétaire Ouest-Africaine)
// et CEMAC (Communauté Économique et Monétaire de l'Afrique Centrale)

class CountryCode {
  final String name;
  final String code;
  final String flag;
  final String dialCode;

  const CountryCode({
    required this.name,
    required this.code,
    required this.flag,
    required this.dialCode,
  });
}

class CountryCodes {
  // Pays UEMOA
  static const benin = CountryCode(
    name: 'Bénin',
    code: 'BJ',
    flag: '🇧🇯',
    dialCode: '+229',
  );

  static const burkinaFaso = CountryCode(
    name: 'Burkina Faso',
    code: 'BF',
    flag: '🇧🇫',
    dialCode: '+226',
  );

  static const coteDivoire = CountryCode(
    name: 'Côte d\'Ivoire',
    code: 'CI',
    flag: '🇨🇮',
    dialCode: '+225',
  );

  static const guineeBissau = CountryCode(
    name: 'Guinée-Bissau',
    code: 'GW',
    flag: '🇬🇼',
    dialCode: '+245',
  );

  static const mali = CountryCode(
    name: 'Mali',
    code: 'ML',
    flag: '🇲🇱',
    dialCode: '+223',
  );

  static const niger = CountryCode(
    name: 'Niger',
    code: 'NE',
    flag: '🇳🇪',
    dialCode: '+227',
  );

  static const senegal = CountryCode(
    name: 'Sénégal',
    code: 'SN',
    flag: '🇸🇳',
    dialCode: '+221',
  );

  static const togo = CountryCode(
    name: 'Togo',
    code: 'TG',
    flag: '🇹🇬',
    dialCode: '+228',
  );

  // Pays CEMAC
  static const cameroun = CountryCode(
    name: 'Cameroun',
    code: 'CM',
    flag: '🇨🇲',
    dialCode: '+237',
  );

  static const centrafrique = CountryCode(
    name: 'République Centrafricaine',
    code: 'CF',
    flag: '🇨🇫',
    dialCode: '+236',
  );

  static const congo = CountryCode(
    name: 'Congo',
    code: 'CG',
    flag: '🇨🇬',
    dialCode: '+242',
  );

  static const gabon = CountryCode(
    name: 'Gabon',
    code: 'GA',
    flag: '🇬🇦',
    dialCode: '+241',
  );

  static const guineaEquatoriale = CountryCode(
    name: 'Guinée Équatoriale',
    code: 'GQ',
    flag: '🇬🇶',
    dialCode: '+240',
  );

  static const tchad = CountryCode(
    name: 'Tchad',
    code: 'TD',
    flag: '🇹🇩',
    dialCode: '+235',
  );

  // Liste complète UEMOA + CEMAC
  static const List<CountryCode> all = [
    // UEMOA
    benin,
    burkinaFaso,
    coteDivoire,
    guineeBissau,
    mali,
    niger,
    senegal,
    togo,
    // CEMAC
    cameroun,
    centrafrique,
    congo,
    gabon,
    guineaEquatoriale,
    tchad,
  ];

  static CountryCode getByDialCode(String dialCode) {
    return all.firstWhere(
      (country) => country.dialCode == dialCode,
      orElse: () => coteDivoire, // Défaut: Côte d'Ivoire
    );
  }
}
