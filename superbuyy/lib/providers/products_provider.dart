import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductsProvider with ChangeNotifier {
  static List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              price: double.parse(
                element.get('price'),
              ),
              salePrice: element.get('salePrice'),
              isOnSale: element.get('isOnSale'),
              isPiece: element.get('isPiece'),
            ));
      });
    });
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }

  // static final List<ProductModel> _productsList = [
  //   ProductModel(
  //     id: 'Apricot',
  //     title: 'Apricot',
  //     price: 50.50,
  //     salePrice: 40.00,
  //     imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Avocado',
  //     title: 'Avocado',
  //     price: 100.00,
  //     salePrice: 80.00,
  //     imageUrl: 'https://i.ibb.co/9VKXw5L/Avocat.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Black grapes',
  //     title: 'Black grapes',
  //     price: 70.50,
  //     salePrice: 60.00,
  //     imageUrl: 'https://i.ibb.co/c6w5zrC/Black-Grapes-PNG-Photos.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Fresh_green_grape',
  //     title: 'Fresh green grape',
  //     price: 80.00,
  //     salePrice: 75.50,
  //     imageUrl: 'https://i.ibb.co/HKx2bsp/Fresh-green-grape.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Green grape',
  //     title: 'Green grape',
  //     price: 65.70,
  //     salePrice: 55.60,
  //     imageUrl: 'https://i.ibb.co/bHKtc33/grape-green.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Red apple',
  //     title: 'Red apple',
  //     price: 100,
  //     salePrice: 90,
  //     imageUrl: 'https://i.ibb.co/crwwSG2/red-apple.png',
  //     productCategoryName: 'Fruits',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   // Vegi
  //   ProductModel(
  //     id: 'Carottes',
  //     title: 'Carottes',
  //     price: 30.10,
  //     salePrice: 22.5,
  //     imageUrl: 'https://i.ibb.co/TRbNL3c/Carottes.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Cauliflower',
  //     title: 'Cauliflower',
  //     price: 40.60,
  //     salePrice: 36.40,
  //     imageUrl: 'https://i.ibb.co/xGWf2rH/Cauliflower.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Cucumber',
  //     title: 'Cucumber',
  //     price: 20.80,
  //     salePrice: 15.80,
  //     imageUrl: 'https://i.ibb.co/kDL5GKg/cucumbers.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Jalape',
  //     title: 'Jalape',
  //     price: 10.00,
  //     salePrice: 6.08,
  //     imageUrl: 'https://i.ibb.co/Dtk1YP8/Jalape-o.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Long yam',
  //     title: 'Long yam',
  //     price: 25.00,
  //     salePrice: 18.00,
  //     imageUrl: 'https://i.ibb.co/V3MbcST/Long-yam.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Onions',
  //     title: 'Onions',
  //     price: 60.00,
  //     salePrice: 40.00,
  //     imageUrl: 'https://i.ibb.co/GFvm1Zd/Onions.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Plantain-flower',
  //     title: 'Plantain-flower',
  //     price: 70.00,
  //     salePrice: 55.80,
  //     imageUrl: 'https://i.ibb.co/RBdq0PD/Plantain-flower.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Potato',
  //     title: 'Potato',
  //     price: 40.00,
  //     salePrice: 32.08,
  //     imageUrl: 'https://i.ibb.co/wRgtW55/Potato.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Radish',
  //     title: 'Radish',
  //     price: 55.05,
  //     salePrice: 48.00,
  //     imageUrl: 'https://i.ibb.co/YcN4ZsD/Radish.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Red peppers',
  //     title: 'Red peppers',
  //     price: 15.00,
  //     salePrice: 10.00,
  //     imageUrl: 'https://i.ibb.co/JthGdkh/Red-peppers.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Squash',
  //     title: 'Squash',
  //     price: 46.80,
  //     salePrice: 32.40,
  //     imageUrl: 'https://i.ibb.co/p1V8sq9/Squash.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Tomatoes',
  //     title: 'Tomatoes',
  //     price: 40.00,
  //     salePrice: 35.00,
  //     imageUrl: 'https://i.ibb.co/PcP9xfK/Tomatoes.png',
  //     productCategoryName: 'Vegetables',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  //   // Grains
  //   ProductModel(
  //     id: 'Corn-cobs',
  //     title: 'Corn-cobs',
  //     price: 45.80,
  //     salePrice: 38.40,
  //     imageUrl: 'https://i.ibb.co/8PhwVYZ/corn-cobs.png',
  //     productCategoryName: 'Grains',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Peas',
  //     title: 'Peas',
  //     price: 20.00,
  //     salePrice: 15.08,
  //     imageUrl: 'https://i.ibb.co/7GHM7Dp/peas.png',
  //     productCategoryName: 'Grains',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   // Herbs
  //   ProductModel(
  //     id: 'Asparagus',
  //     title: 'Asparagus',
  //     price: 58.60,
  //     salePrice: 45.00,
  //     imageUrl: 'https://i.ibb.co/RYRvx3W/Asparagus.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //     isPiece: false,
  //   ),
  //   ProductModel(
  //     id: 'Brokoli',
  //     title: 'Brokoli',
  //     price: 80,
  //     salePrice: 70,
  //     imageUrl: 'https://i.ibb.co/KXTtrYB/Brokoli.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Buk-choy',
  //     title: 'Buk-choy',
  //     price: 90.50,
  //     salePrice: 75.00,
  //     imageUrl: 'https://i.ibb.co/MNDxNnm/Buk-choy.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Chinese-cabbage-wombok',
  //     title: 'Chinese-cabbage-wombok',
  //     price: 30.80,
  //     salePrice: 26.50,
  //     imageUrl: 'https://i.ibb.co/7yzjHVy/Chinese-cabbage-wombok.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Kangkong',
  //     title: 'Kangkong',
  //     price: 70.00,
  //     salePrice: 61.50,
  //     imageUrl: 'https://i.ibb.co/HDSrR2Y/Kangkong.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Leek',
  //     title: 'Leek',
  //     price: 45.00,
  //     salePrice: 40.80,
  //     imageUrl: 'https://i.ibb.co/Pwhqkh6/Leek.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: false,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Spinach',
  //     title: 'Spinach',
  //     price: 80.05,
  //     salePrice: 68.00,
  //     imageUrl: 'https://i.ibb.co/bbjvgcD/Spinach.png',
  //     productCategoryName: 'Herbs',
  //     isOnSale: true,
  //     isPiece: true,
  //   ),
  //   ProductModel(
  //     id: 'Almond',
  //     title: 'Almond',
  //     price: 100,
  //     salePrice: 80,
  //     imageUrl: 'https://i.ibb.co/c8QtSr2/almand.jpg',
  //     productCategoryName: 'Nuts',
  //     isOnSale: true,
  //     isPiece: false,
  //   ),
  // ];
}
