import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({super.key});

  final menus = [
    {
      'icon': 'images/floor.png',
      'title': 'Floor',
      'description': 'Lista de livros',
      'route': '/books'
    },
    {
      'icon': 'images/firebase.png',
      'title': 'Firebase',
      'description': 'Lista de carros',
      'route': '/cars'
    },
  ];

  @override
  Widget build(BuildContext context) {
    const title = Text("Flutter - Persistência");
    const nextIcon = Icon(Icons.navigate_next);

    return Scaffold(
      appBar: AppBar(title: title),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final item = menus[index];

            return ListTile(
              leading: Image.asset(item['icon'] ?? ''),
              title: Text(item['title'] ?? ''),
              subtitle: Text(item['description'] ?? ''),
              trailing: nextIcon,
              onTap: () => goToNextRoute(context, item['route'] ?? '/'),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 2, color: Colors.black12),
          itemCount: menus.length),
    );
  }

  goToNextRoute(BuildContext context, String route) {
    return Navigator.pushNamed(context, route);
  }
}
