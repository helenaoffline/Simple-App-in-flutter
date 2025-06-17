import 'package:flutter/material.dart';
import 'main.dart'; 

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  // Controladores de texto para capturar entrada do usuário nos campos de título e subtítulo
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  void _createPost() {
    // Verifica se os campos não estão vazios
    if (_titleController.text.isNotEmpty &&
        _subtitleController.text.isNotEmpty) {
      // Cria um novo objeto Post com os dados fornecidos
      final newPost = Post(
        title: _titleController.text,
        subtitle: _subtitleController.text,
      );
      // Atualiza a lista de posts reativa (ValueNotifier)
      posts.value = List.from(posts.value)..add(newPost);

      if (Navigator.canPop(context)) {
        Navigator.pop(context); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Post criado!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      // Caso os campos estejam vazios, exibe mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o título e o subtítulo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  // Interface visual da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //titulo da pagina
      appBar: AppBar(title: const Text('Criar Novo Post')),
      // Menu lateral já criado no main
      drawer: buildAppDrawer(context), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Captura titulo
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 16),
            // Captura subtitulo
            TextFormField(
              controller: _subtitleController,
              decoration: const InputDecoration(
                labelText: 'Subtítulo',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            // Chama a função _createPost
            ElevatedButton(
              onPressed: _createPost,
              child: const Text('Criar Post'),
            ),
          ],
        ),
      ),
    );
  }
}
