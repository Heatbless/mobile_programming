class MenuItem {
  final String id;
  final String name;
  final int price;
  final String imagePath;
  final String category;
  final String description;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath = 'assets/coffee.jpg', // Default image
    required this.category,
    required this.description,
  });
}