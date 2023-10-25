class Product {
  final String name;
  final int price;

  Product({required this.name, required this.price});
}

List<Product> populateProducts() {
  return [
    Product(name: 'Keyboard', price: 24),
    Product(name: 'Mouse', price: 30),
    Product(name: 'Monitor', price: 150),
    Product(name: 'Laptop', price: 800),
    Product(name: 'Headphones', price: 50),
    Product(name: 'Speakers', price: 70),
    Product(name: 'Printer', price: 120),
    Product(name: 'Scanner', price: 100),
    Product(name: 'Router', price: 80),
    Product(name: 'Hard Drive', price: 60),
    Product(name: 'Desk', price: 200),
    Product(name: 'Chair', price: 100),
    Product(name: 'Pen', price: 1),
    Product(name: 'Notebook', price: 3),
    Product(name: 'Tablet', price: 300),
    Product(name: 'Smartphone', price: 500),
    Product(name: 'Camera', price: 400),
    Product(name: 'Projector', price: 200),
    Product(name: 'External Hard Drive', price: 80),
    Product(name: 'USB Flash Drive', price: 20),
  ];
}
