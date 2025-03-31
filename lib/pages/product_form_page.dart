import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

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

  bool _isLoading = false;

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

    setState(() => _isLoading = true);

    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData).catchError((error) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text(
            'Ocorreu um erro ao salvar o produto, contate o suporte para mais informações.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Voltar'),
            ),
          ],
        ),
      );
    }).then((value) {
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = product.imageUrl;
      }
    }
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo Nome
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
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
                        initialValue: _formData['price']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Preço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        focusNode: _priceFocus,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        validator: (priceInput) {
                          final priceString = priceInput ?? '';
                          final price = double.tryParse(priceString) ?? -1;

                          if (price <= 0) {
                            return 'valor deve ser maior que 0';
                          }

                          return null;
                        },
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: (descriptionInput) {
                          final description = descriptionInput ?? '';

                          if (description.trim().isEmpty) {
                            return 'O campo descrição é obrigatório';
                          }

                          if (description.trim().length < 5) {
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

                                if (!isValidImageUrl(imageUrl)) {
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
                                      child: Image.network(
                                          _imageUrlController.text),
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
