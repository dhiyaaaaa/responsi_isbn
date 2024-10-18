import 'package:flutter/material.dart'; 
import 'package:buku_flutter/bloc/isbn_bloc.dart'; // Mengganti dengan bloc ISBN
import 'package:buku_flutter/model/isbn.dart'; // Mengganti dengan model ISBN
import 'package:buku_flutter/ui/isbn_form.dart'; // Mengganti form untuk ISBN
import 'package:buku_flutter/ui/isbn_page.dart'; // Mengganti halaman daftar ISBN
import 'package:buku_flutter/widget/warning_dialog.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts

// ignore: must_be_immutable
class IsbnDetail extends StatefulWidget {
  Isbn? isbn;

  IsbnDetail({Key? key, this.isbn}) : super(key: key);

  @override
  _IsbnDetailState createState() => _IsbnDetailState();
}

class _IsbnDetailState extends State<IsbnDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail ISBN'),
        backgroundColor: Colors.blueGrey[900], // Warna biru gelap
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kode ISBN : ${widget.isbn!.isbn_code}",
              style: GoogleFonts.roboto(
                fontSize: 20.0,
                color: Colors.white, // Ubah warna teks menjadi putih
              ),
            ),
            Text(
              "Format : ${widget.isbn!.format}",
              style: GoogleFonts.roboto(
                fontSize: 18.0,
                color: Colors.white, // Ubah warna teks menjadi putih
              ),
            ),
            Text(
              "Jumlah Halaman : ${widget.isbn!.print_length.toString()}",
              style: GoogleFonts.roboto(
                fontSize: 18.0,
                color: Colors.white, // Ubah warna teks menjadi putih
              ),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[800], // Warna latar belakang biru gelap
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IsbnForm(
                  isbn: widget.isbn!,
                ),
              ),
            );
          },
        ),

        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            IsbnBloc.hapusIsbn(id: widget.isbn!.id!).then(
              (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const IsbnPage(),
                  ),
                );
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
