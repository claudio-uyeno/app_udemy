import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const rout_name = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  var _idProduct = '';
  var _editedProduct = Product(
      id: DateTime.now().toString(),
      title: '',
      description: '',
      price: 0,
      imageUrl: '',
      isFavorite: false);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _idProduct = ModalRoute.of(context).settings.arguments as String;

      if (_idProduct.isNotEmpty) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).getById(_idProduct);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose(); //previnir memory leak
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((_imageUrlController.text.isEmpty) &&
          (_imageUrlController.text.startsWith('http:') ||
              _imageUrlController.text.startsWith('https:')) &&
          (_imageUrlController.text.endsWith('.png') ||
              _imageUrlController.text.endsWith('.jpg') ||
              _imageUrlController.text.endsWith('.jpeg'))) {
        setState(() {});
      }
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_idProduct.isEmpty) {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                //autovalidate: true, //se informado, valida a cada tecla
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _editedProduct.title,
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _priceFocusNode); //alterna foco para xxx
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title is missing!'; //error
                        }

                        return null; //ok
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.price.toString(),
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode:
                          _priceFocusNode, //indica que este campo será selecionado quando selecionado
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Price is missing!';
                        }

                        if (double.tryParse(value) == null) {
                          return 'Enter a valid number!';
                        }

                        if (double.parse(value) <= 0) {
                          return 'Invalid price! Should be greater than zero.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(value),
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _editedProduct.description,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType
                          .multiline, //adicionar botão de 'enter' no teclado (impossibilita textImputAction)
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description is missing!';
                        }

                        if (value.length < 10) {
                          return 'Should be at least 10 characters long!';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: value,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Center(child: Text('Enter a URL'))
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            // onEditingComplete: (){ //se precisar forçar a renderização
                            //   setState(() {

                            //   });
                            // },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Image URL is missing!';
                              }

                              // if (!value.startsWith('http:') &&
                              //     !value.startsWith('https:')) {
                              //   return 'Invalid URL!';
                              // }

                              var urlPattern =
                                  r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                              var result =
                                  new RegExp(urlPattern, caseSensitive: false)
                                      .firstMatch(value);
                              if (result == null) {
                                return 'Invalid URL!';
                              }

                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Invalid image. Should be png/jpg/jpeg.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: value,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
