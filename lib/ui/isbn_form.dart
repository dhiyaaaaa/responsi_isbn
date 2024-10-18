import 'package:flutter/material.dart'; 
import 'package:buku_flutter/bloc/isbn_bloc.dart';
import 'package:buku_flutter/model/isbn.dart';
import 'package:buku_flutter/ui/isbn_page.dart';
import 'package:buku_flutter/widget/warning_dialog.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts

class IsbnForm extends StatefulWidget {
  Isbn? isbn;

  IsbnForm({Key? key, this.isbn}) : super(key: key);

  @override
  _IsbnFormState createState() => _IsbnFormState();
}

class _IsbnFormState extends State<IsbnForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH ISBN";
  String tombolSubmit = "SIMPAN";

  final _kodeIsbnTextboxController = TextEditingController();
  final _formatIsbnTextboxController = TextEditingController();
  final _printLengthIsbnTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.isbn != null) {
      setState(() {
        judul = "UBAH ISBN";
        tombolSubmit = "UBAH";
        _kodeIsbnTextboxController.text = widget.isbn!.isbn_code!;
        _formatIsbnTextboxController.text = widget.isbn!.format!;
        _printLengthIsbnTextboxController.text =
            widget.isbn!.print_length.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul, style: GoogleFonts.roboto()), // Menggunakan font Roboto
        backgroundColor: Colors.blueGrey[900], // Warna biru gelap
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeIsbnTextField(),
                _formatIsbnTextField(),
                _printLengthIsbnTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[800], // Warna latar belakang biru gelap
    );
  }

  // Membuat Textbox Kode ISBN
  Widget _kodeIsbnTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kode ISBN",
        labelStyle: TextStyle(color: Colors.white), // Warna label putih
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      style: TextStyle(color: Colors.white), // Warna teks putih
      keyboardType: TextInputType.text,
      controller: _kodeIsbnTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode ISBN harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Format ISBN
  Widget _formatIsbnTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Format ISBN",
        labelStyle: TextStyle(color: Colors.white), // Warna label putih
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      style: TextStyle(color: Colors.white), // Warna teks putih
      keyboardType: TextInputType.text,
      controller: _formatIsbnTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Format ISBN harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Print Length ISBN
  Widget _printLengthIsbnTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Print Length",
        labelStyle: TextStyle(color: Colors.white), // Warna label putih
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      style: TextStyle(color: Colors.white), // Warna teks putih
      keyboardType: TextInputType.number,
      controller: _printLengthIsbnTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Print length harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(
        tombolSubmit,
        style: GoogleFonts.roboto(color: Colors.white), // Menggunakan font Roboto
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white), // Warna border putih
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.isbn != null) {
              // kondisi update ISBN
              ubah();
            } else {
              // kondisi tambah ISBN
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    Isbn createIsbn = Isbn(
      isbn_code: _kodeIsbnTextboxController.text,
      format: _formatIsbnTextboxController.text,
      print_length: int.parse(_printLengthIsbnTextboxController.text),
    );

    IsbnBloc.tambahIsbn(isbn: createIsbn).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const IsbnPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Isbn updateIsbn = Isbn(
      id: widget.isbn!.id,
      isbn_code: _kodeIsbnTextboxController.text,
      format: _formatIsbnTextboxController.text,
      print_length: int.parse(_printLengthIsbnTextboxController.text),
    );

    IsbnBloc.perbaruiIsbn(isbn: updateIsbn).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const IsbnPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
