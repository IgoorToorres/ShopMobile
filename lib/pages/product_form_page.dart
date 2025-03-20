import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    final isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    final endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    print(newProduct.name);
    print(newProduct.price);
    print(newProduct.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar',
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Campo Nome
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  validator: (nameInput) {
                    final name = nameInput ?? '';

                    if (name.trim().isEmpty) {
                      return 'O campo nome é obrigatório';
                    }
                    if (name.trim().length < 2) {
                      return 'O campo deve ter mais que 2 caracteres!';
                    }

                    if (RegExp(r'^\d+$').hasMatch(name.trim())) {
                      return 'O nome não pode conter apenas números!';
                    }

                    return null;
                  },
                  onSaved: (name) => _formData['name'] = name ?? '',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusNode: _priceFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  validator: (priceInput){
                    final priceString = priceInput ?? '';
                    final price = double.tryParse(priceString) ?? -1;

                    if(price <= 0){
                      return 'valor deve ser maior que 0';
                    }
                    
                    return null;
                  },
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  focusNode: _descriptionFocus,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (descriptionInput){
                    final description = descriptionInput ?? '';

                    if(description.trim().isEmpty){
                      return 'O campo descrição é obrigatório';
                    }

                    if(description.trim().length < 5){
                      return 'Descrição muito curta!';
                    }
                    
                    return null;
                  },
                  onSaved: (description) =>
                      _formData['description'] = description ?? '',
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'URL da Imagem',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        focusNode: _imageUrlFocus,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) => _submitForm(),
                        validator: (imageUrlInput) {
                          final imageUrl = imageUrlInput ?? '';
                          
                          if(!isValidImageUrl(imageUrl)){
                            return 'Url invalida';
                          }
                          return null;
                        },
                        onSaved: (imageUrl) =>
                            _formData['imageUrl'] = imageUrl ?? '',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Informe a URL')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlController.text),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
