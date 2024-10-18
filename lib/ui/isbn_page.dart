import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Untuk menggunakan font Roboto
import 'package:buku_flutter/bloc/logout_bloc.dart';
import 'package:buku_flutter/bloc/isbn_bloc.dart';
import 'package:buku_flutter/model/isbn.dart';
import 'package:buku_flutter/ui/login_page.dart';
import 'package:buku_flutter/ui/isbn_detail.dart';
import 'package:buku_flutter/ui/isbn_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark, // Mengatur tema gelap
        primaryColor: Colors.blue[900], // Warna utama biru gelap
        scaffoldBackgroundColor: Colors.black87, // Warna latar belakang utama

        // Atur font global dengan Roboto
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white, // Warna teks menjadi putih
                displayColor: Colors.white, // Warna teks judul juga putih
              ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900], // Warna AppBar biru gelap
          elevation: 0, // Menghilangkan shadow pada AppBar
        ),
      ),
      home: IsbnPage(), // Halaman awal aplikasi
    );
  }
}

class IsbnPage extends StatefulWidget {
  const IsbnPage({Key? key}) : super(key: key);

  @override
  _IsbnPageState createState() => _IsbnPageState();
}

class _IsbnPageState extends State<IsbnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List ISBN'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IsbnForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900], // Warna header drawer biru gelap
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Isbn>>(
        future: IsbnBloc.ambilDaftarIsbn(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data ISBN"));
          }

          return ListIsbn(list: snapshot.data!);
        },
      ),
    );
  }
}

class ListIsbn extends StatelessWidget {
  final List<Isbn> list;
  const ListIsbn({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return ItemIsbn(isbn: list[i]);
      },
    );
  }
}

class ItemIsbn extends StatelessWidget {
  final Isbn isbn;
  const ItemIsbn({Key? key, required this.isbn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IsbnDetail(isbn: isbn),
          ),
        );
      },
      child: Card(
        color: Colors.grey[800], // Warna kartu gelap
        child: ListTile(
          title: Text(isbn.isbn_code ?? 'Tidak ada kode ISBN'),
          subtitle: Text(isbn.format ?? 'Tidak ada format'),
        ),
      ),
    );
  }
}
