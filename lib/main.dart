import 'package:flutter/material.dart';
import 'create_post.dart';
import 'detail_post.dart';

// Modelo de Post
class Post {
  final String title;
  final String subtitle;

  Post({required this.title, required this.subtitle});
}

// Lista global de posts
final ValueNotifier<List<Post>> _posts = ValueNotifier<List<Post>>([]);
ValueNotifier<List<Post>> get posts => _posts;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const PostListScreen(),
    );
  }
}

// Tela de lista de posts
class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //titulo
      appBar: AppBar(title: const Text('Meus Posts')),
      drawer: buildAppDrawer(context),
      body: Center(
        child: ValueListenableBuilder<List<Post>>(
          valueListenable: posts,
          builder: (context, postList, _) {
            //caso sem posts
            if (postList.isEmpty) {
              return const Text('Nenhum post criado.');
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: postList.length,
              itemBuilder: (context, index) {
                final post = postList[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PostDetailScreen(post: post)),
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //captura o title e subtítulo do post
                        children: [
                          Icon(Icons.article, size: 50, color: Theme.of(context).primaryColor),
                          const SizedBox(height: 8),
                          Text(
                            post.title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            post.subtitle,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PostCreationScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Drawer compartilhado
Widget buildAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFF673AB7)),
          child: Text(
            'Menu do App',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        //drawer criar post
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Criar Novo Post'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PostCreationScreen()),
            );
          },
        ),
        //drawer listar post
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Lista de Posts'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PostListScreen()),
            );
          },
        ),
      ],
    ),
  );
}
