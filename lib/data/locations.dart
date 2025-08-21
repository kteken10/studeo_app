// src/data/locations.dart

class City {
  final String name;
  final String image; // chemin vers l’image locale (assets)

  const City({required this.name, required this.image});
}

class Country {
  final String name;
  final String flag; // ✅ chemin du drapeau du pays
  final List<City> cities;

  const Country({
    required this.name,
    required this.flag,
    required this.cities,
  });
}

const List<Country> countries = [
  Country(
    name: 'France',
    flag: 'assets/france_flag.png', 
    cities: [
      City(name: 'Paris', image: 'assets/paris.png'),
      City(name: 'Bordeaux', image: 'assets/bordeaux.png'),
      City(name: 'Lille', image: 'assets/lille.png'),
      City(name: 'Lyon', image: 'assets/lyon.png'),
      City(name: 'Toulouse', image: 'assets/toulouse.png'),
      City(name: 'Marseille', image: 'assets/marseille.png'),
      City(name: 'Nantes', image: 'assets/nantes.png'),
      City(name: 'Montpellier', image: 'assets/montpellier.png'),
      City(name: 'Rennes', image: 'assets/rennes.png'),
      City(name: 'Grenoble', image: 'assets/grenoble.png'),
    ],
  ),
  Country(
    name: 'Belgique',
    flag: 'assets/belgium_flag.png', 
    cities: [
      City(name: 'Bruxelles-capitale', image: 'assets/bruxelles.png'),
      City(name: 'Anvers', image: 'assets/anvers.png'),
      City(name: 'Louvain', image: 'assets/louvain.png'),
      City(name: 'Courtal', image: 'assets/courtal.png'),
      City(name: 'Mons', image: 'assets/mons.png'),
    ],
  ),
  Country(
    name: 'Italie',
    flag: 'assets/italy_flag.png', 
    cities: [
      City(name: 'Rome', image: 'assets/rome.png'),
      City(name: 'Milan', image: 'assets/milan.png'),
    ],
  ),
];
