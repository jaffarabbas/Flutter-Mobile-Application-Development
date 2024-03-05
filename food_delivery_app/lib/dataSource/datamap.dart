// ignore_for_file: non_constant_identifier_names

class Datamap {
  static DataSource() {
    return {
      "category": [
        {
          'flag': true,
          'itemName': 'All Food',
          'itemImage': 'assets/Images/roundImg1.png'
        },
        {
          'flag': false,
          'itemName': 'Shrimp',
          'itemImage': 'assets/Images/roundImg1.png'
        },
        {
          'flag': false,
          'itemName': 'Noodles',
          'itemImage': 'assets/Images/roundImage2.png'
        },
        {
          'flag': false,
          'itemName': 'Burger',
          'itemImage': 'assets/Images/baked-fries.jpg'
        },
      ],
      "favoriteFoods": [
        {
          "name": "Orignal Fried Shrimp",
          "price": 6.9,
          "image": "assets/Images/roundImg1.png",
          "extras": "With Extra Souse",
          "decription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,book. ",
          "rating": 6
        },
        {
          "name": "Spicy Chicken Noodles",
          "price": 7.9,
          "image": "assets/Images/roundImage2.png",
          "extras": "With Extra Chicken",
          "decription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,book. ",
          "rating": 5
        },
        {
          "name": "Spicy Cheese Pizza",
          "price": 9.9,
          "image": "assets/Images/roundImage3.png",
          "extras": "With Extra Cheese",
          "decription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,book. ",
          "rating": 6
        }
      ],
      "otherFoods":[
        {
          "name": "Chinnese Pizza",
          "price": 6.9,
          "image": "assets/Images/pizza.jpg",
          "extras": "With Extra Souse",
          "decription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,book. ",
          "rating": 6
        },
        {
          "name": "Japanies Sochie",
          "price": 8.9,
          "image": "assets/Images/japanese-restaurant.jpg",
          "extras": "With Tuna",
          "decription": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,book. ",
          "rating": 6
        },
      ]
    };
  }
}
