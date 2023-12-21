import 'package:products_app/domain/models/ingredient.dart';
import 'package:products_app/domain/models/product.dart';
import 'package:products_app/domain/models/product_category.dart';
import 'package:products_app/domain/models/product_details.dart';

final List<Product> products = [
  Product(
      name: 'Hamburguesa whopper',
      description: 'Deliciosa hamburguesa con doble carne y queso',
      price: 12.7,
      image:
          'https://smartremo.es/wp-content/uploads/2020/04/hamburguesa-scaled.jpg'),
  Product(
      name: 'Hamburguesa cheese bacon',
      description: 'Deliciosa hamburguesa con queso ricotta y bacon ahumado',
      price: 13,
      image: 'https://i.imgur.com/G3EJnwX.jpg'),
  Product(
      name: 'Hamburguesa XT',
      description: 'Deliciosa hamburguesa con jalapeño picante',
      price: 12.5,
      image:
          'https://i.pinimg.com/originals/1e/44/e5/1e44e5eded84532b5f3ecf90a2849671.jpg'),
  Product(
      name: 'Hamburguesa Mega',
      description: 'Deliciosa hamburguesa con carne gigante y bacon ahumado',
      price: 15,
      image:
          'https://media-cdn.tripadvisor.com/media/photo-p/0f/92/8b/de/wagyu-beast-burger.jpg'),
];

final List<ProductDetails> productDetails = products
  .map((elm) => ProductDetails(product: elm, ingredients: List<Ingredient>.of([
      Ingredient(name: 'Pan', image: 'https://th.bing.com/th/id/OIP.ol3cym5UaXAsOf1aSsg1wwHaEb?rs=1&pid=ImgDetMain'),
      Ingredient(name: 'Carne', image: 'https://th.bing.com/th/id/R.6eab23a4b8e8542ef9baf4f320db1941?rik=1ZGAWeegqAT%2b0g&pid=ImgRaw&r=0'),
      Ingredient(name: 'Queso', image: 'https://th.bing.com/th/id/OIP.ojLjkUPmcuy1dm7DyKjfFAHaHa?rs=1&pid=ImgDetMain'),
      Ingredient(name: 'Lechuga', image: 'https://bolcereales.com.ar/wp-content/uploads/2019/12/lechuga-plato.jpg'),
    ]),
  ),
).toList();

final List<ProductCategory> categories = [
  ProductCategory(name: 'Pizza', image: 'assets/pizza.png'),
  ProductCategory(name: 'Tacos', image: 'assets/tacos.png'),
  ProductCategory(name: 'Burguer', image: 'assets/burguer.png'),
  ProductCategory(name: 'Fritos', image: 'assets/fritos.png'),
  ProductCategory(name: 'Perros', image: 'assets/perros.png'),
  ProductCategory(name: 'Pollo', image: 'assets/pollo.png'),
  ProductCategory(name: 'Sanwich', image: 'assets/sanwich.png'),
];
