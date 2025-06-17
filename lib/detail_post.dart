import 'package:flutter/material.dart';
import 'main.dart'; 

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //titulo da pagina
      appBar: AppBar(title: const Text('Detalhes do Post')),
      // Menu lateral já criado no main
      drawer: buildAppDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          //Forma que cada nota é exibida
          children: [
            // Ícone representando uma nota
            const Icon(
              Icons.article_sharp,
              size: 100,
              color: Color(0xFF673AB7),
            ),
            const SizedBox(height: 24), 

            Text(
              post.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF673AB7), 
              ),
            ),
            const SizedBox(height: 12),
            Text(
              post.subtitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700], 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
