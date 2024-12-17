import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiAddView extends GetView<PegawaiController> {
  const PegawaiAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tambah Pegawai Baru',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderSection(),
              SizedBox(height: 30),
              _buildFormSection(),
              SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[400]!, Colors.deepPurple[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_add,
            color: Colors.white,
            size: 80,
          ),
          SizedBox(height: 15),
          Text(
            'Lengkapi Data Pegawai',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Pastikan semua informasi yang dimasukkan akurat',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildTextField(
            controller: controller.cNip,
            label: "NIP",
            icon: Icons.card_membership,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: controller.cNama,
            label: "Nama Lengkap",
            icon: Icons.person,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: controller.cJabatan,
            label: "Jabatan",
            icon: Icons.work,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: controller.cJeniskelamin,
            label: "Jenis Kelamin",
            icon: Icons.people,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          _buildTextField(
            controller: controller.cAlamat,
            label: "Alamat",
            icon: Icons.location_on,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      autocorrect: false,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.purple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.deepPurple[800]),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () => controller.add(
        controller.cNama.text,
        controller.cNip.text,
        controller.cJabatan.text,
        controller.cJeniskelamin.text,
        controller.cAlamat.text,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.save),
          SizedBox(width: 10),
          Text(
            "Simpan Data",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
