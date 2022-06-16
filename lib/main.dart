import 'package:flutter/material.dart';

void main(){
  runApp(
      MaterialApp(
        theme: ThemeData(
          brightness:  Brightness.light,

        ),
          debugShowCheckedModeBanner: false,
          home: ProductActivity(
            products: [
              Product(name: 'Samsung', price: 300),
              Product(name: 'iPhone', price: 450),
              Product(name: 'iPhone', price: 450),
              Product(name: 'G-tel', price: 200),
              Product(name: 'iPhone', price: 450),
              Product(name: 'G-tel', price: 200),
              Product(name: 'Huawei', price: 275),
              Product(name: 'Huawei', price: 275),
              Product(name: 'G-tel', price: 200),
              Product(name: 'Huawei', price: 275),
              Product(name: 'Itel', price: 85),
            ],
          )
      )
  );
}
class Product{

  Product({required this.name,required this.price});
  final String name;
  final int price;
}


typedef MyFunction = Function(Product product, bool saved);

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({Key? key, required this.product, required this.saved, required this.changeInCart}) :
        super(key: key);

  final Product product;
  final bool saved;
  final MyFunction changeInCart;

  TextStyle? myStyle(BuildContext context){
    return saved?TextStyle(
        color:Colors.blueGrey,fontSize: 18,decoration: TextDecoration.lineThrough):
    TextStyle(fontSize: 22,color:Colors.white,fontWeight: FontWeight.bold);
  }
  Color myColor(){
    return saved? Colors.black12: Colors.white;
  }
   Icon? myCartIcon(){
     return saved?Icon(Icons.remove_shopping_cart,color: Colors.white70,):Icon(Icons.add_shopping_cart,color: Colors.white,);
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(left:10,top:20,right: 10,bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.white12,blurRadius: 5,spreadRadius: 10,offset: Offset.zero)
        ]
      ),
      child: ListTile(

        tileColor: Colors.deepPurple,

        subtitle: Text('\$ ${product.price.toString()}',style: TextStyle(color:Colors.black,fontSize: 20)),

        onTap: (){
          return changeInCart(product,saved);
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(product.name, style: myStyle(context),),
          ],
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white60,
          child: Text(product.name[0].toUpperCase(),style: TextStyle(color: Colors.black),),
        ),
        trailing: myCartIcon(),
        autofocus: true,

      ),
    );

  }
}

class ProductActivity extends StatefulWidget {
   ProductActivity({Key? key,required this.products}) : super(key: key);
  final List<Product> products;
  @override
  _ProductActivityState createState() => _ProductActivityState();
}

class _ProductActivityState extends State<ProductActivity> {

  final cartProducts = <Product> {};
  productChange(Product product,bool saved){
    setState(() {
      if(saved){
        cartProducts.remove(product);
      }
      else{
        cartProducts.add(product);
      }

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(
      backgroundColor: Colors.lightBlue,
      title: Text('TENQA'),
      actions: [

        IconButton(
            onPressed:() {
              Navigator.push(context, myCart(context,cartProducts)) ;
            },
            icon: Icon(Icons.shopping_cart ,color: Colors.deepOrange,))
      ],
      centerTitle: true,

    ),
    body: Container(
      color:  Theme.of(context).backgroundColor,

      child: ListView(

        children: widget.products.map(
                (product) {
                  return ProductDisplay(
                      product: product,
                      saved: cartProducts.contains(product),
                      changeInCart: productChange);
                }).toList(),
      ),
    ),
    );
  }
}



 myCart(BuildContext context, cartProducts){
    return MaterialPageRoute(

      builder: (BuildContext context)
      {

        return Scaffold(

            appBar: AppBar(
              title: Text('Saved Products'),
              centerTitle: true,
            ),
            body: Container(

              child: ListView(

                children: [

                  ListTile(

                   title: Text('heyy'),
                  ),
                  Divider( thickness: 5,),

                ],
              ),
            ),
          );


      }

  );
}


