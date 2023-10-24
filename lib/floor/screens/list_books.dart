import 'package:flutter/material.dart';
import 'package:persist_type/commons/constants.dart';
import 'package:persist_type/commons/list_item.dart';
import 'package:persist_type/floor/daos/book_dao.dart';
import 'package:persist_type/floor/database/appDatabase.dart';
import 'package:persist_type/floor/models/book.dart';
import 'package:persist_type/floor/screens/form_book.dart';

class ListBooksWidget extends StatefulWidget {
  const ListBooksWidget({super.key});

  @override
  State<ListBooksWidget> createState() => _ListBooksWidgetState();
}

class _ListBooksWidgetState extends State<ListBooksWidget> {
  List<Book> books = [];
  BookDAO? dao;

  @override
  void initState() {
    super.initState();
    _initiateDatabase();
  }

  _initiateDatabase() async {
    final database = await $FloorAppDatabase
        .databaseBuilder("book_floor_database.db")
        .build();

    dao = database.bookDAO;
    await _getAllBooks();
  }

  _getAllBooks() async {
    if (dao != null) {
      final result = await dao!.findAll();
      setState(() {
        books = result;
      });
    }
  }

  _insertBook(Book book) async {
    if (dao != null) {
      await dao!.insertBook(book);
      await _getAllBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = Text("Livros");
    final addRoute = FormBookWidget();

    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
              icon: addIcon,
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => addRoute))
                    .then((book) => _insertBook(book));
              })
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final item = books[index];
            return ListItemWidget(
                leading: item.id.toString(),
                title: item.title,
                subtitle: item.author,
                onLongPress: _onDeleteBook);
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: books.length),
    );
  }

  _onDeleteBook() {}
}
