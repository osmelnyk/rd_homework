class Product {
  final int id;
  final String name;
  final int price;

  Product({required this.id, required this.name, required this.price});
}

List<Product> populateProducts() {
  return [
    Product(id: 1, name: 'Keyboard', price: 24),
    Product(id: 2, name: 'Mouse', price: 30),
    Product(id: 3, name: 'Monitor', price: 150),
    Product(id: 4, name: 'Laptop', price: 800),
    Product(id: 5, name: 'Headphones', price: 50),
    Product(id: 6, name: 'Speakers', price: 70),
    Product(id: 7, name: 'Printer', price: 120),
    Product(id: 8, name: 'Scanner', price: 100),
    Product(id: 9, name: 'Router', price: 80),
    Product(id: 10, name: 'Hard Drive', price: 60),
    Product(id: 11, name: 'Desk', price: 200),
    Product(id: 12, name: 'Chair', price: 100),
    Product(id: 13, name: 'Pen', price: 1),
    Product(id: 14, name: 'Notebook', price: 3),
    Product(id: 15, name: 'Tablet', price: 300),
    Product(id: 16, name: 'Smartphone', price: 500),
    Product(id: 17, name: 'Camera', price: 400),
    Product(id: 18, name: 'Projector', price: 200),
    Product(id: 19, name: 'External Hard Drive', price: 80),
    Product(id: 20, name: 'USB Flash Drive', price: 20),
  ];
}
