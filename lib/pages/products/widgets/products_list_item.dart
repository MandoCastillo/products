part of 'products_list.dart';

class ProductsListItem extends StatelessWidget {
  final Product product;

  const ProductsListItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          // onTap: () => productsCtrl.deleteProduct(product),
        ),
      ],
      child: ListTile(
          title: Text('${product.title} - \$${product.value}'),
          subtitle: Text(product.id),
          trailing: Column(
            children: [
              Icon(Icons.touch_app),
              Icon(Icons.arrow_back),
            ],
          ),
          onTap: () {
            context.read<ProductBloc>().add(SetProduct(product));
            Navigator.pushNamed(context, 'products-form', arguments: product)
                .then((value) =>
                    context.read<ProductBloc>().add(SetProduct(new Product())));
          }),
    );
  }
}
