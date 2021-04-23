import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productos/pages/product_form/bloc/product_bloc.dart';

class ProductsFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(productBloc.state.product.id != null
            ? 'Editar Producto'
            : 'Agregar producto'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.isFinished) {
            Navigator.pop(context);
          }
        },
        child: _FormContainer(),
      ),
    );
  }
}

class _FormContainer extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                _NameInput(),
                _PriceInput(),
                _AvailableSwitch(),
                _ButtonSubmit()
              ],
            )),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: productBloc.state.product?.title ?? '',
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: 'Nombre'),
          onChanged: (value) => productBloc.add(ProductNameChanged(value)),
        );
      },
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: productBloc.state.product?.value?.toString() ?? '0',
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: 'Precio'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) => productBloc.add(ProductPriceChanged(value)),
        );
      },
    );
  }
}

class _AvailableSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return SwitchListTile(
          title: Text('Disponible'),
          value: state.product?.available ?? false,
          activeColor: Colors.deepPurple,
          onChanged: (value) =>
              context.read<ProductBloc>().add(ProductAvailableChanged(value)),
        );
      },
    );
  }
}

class _ButtonSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.isLoading
            ? CircularProgressIndicator()
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                icon: Icon(Icons.save),
                label: Text('Guardar'),
                onPressed: _onPressed(context, state),
              );
      },
    );
  }

  _onPressed(BuildContext context, ProductState state) {
    // print(state.product.title.length);
    if (state.product != null && state.product.title.length > 3) {
      return () => context.read<ProductBloc>().add(ProductSubmitted());
    }
    return null;
  }
}
