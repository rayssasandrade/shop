import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formDate = Map<String, Object>();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formDate.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formDate['id'] = product.id;
        _formDate['title'] = product.title;
        _formDate['price'] = product.price;
        _formDate['description'] = product.description;
        _formDate['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formDate);
          Navigator.of(context).pop();
    } catch (e) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro para salvar o produto.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formDate['title']?.toString(),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (title) => _formDate['title'] = title ?? '',
                      validator: (_title) {
                        final title = _title ?? '';
                        if (title.trim().isEmpty) {
                          return 'O título está inválido!';
                        }
                        // if (title.trim().length < 3) {
                        //   return 'O título precisa de no mínimo de 3 letras!';
                        // }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formDate['price']?.toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formDate['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formDate['description']?.toString(),
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      //textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formDate['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return 'A descrição está inválido!';
                        }
                        if (description.trim().length < 5) {
                          return 'A descrição precisa de no mínimo de 5 letras!';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem'),
                            focusNode: _imageUrlFocus,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formDate['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma url válida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informa a url')
                              : Image.network(_imageUrlController.text),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
