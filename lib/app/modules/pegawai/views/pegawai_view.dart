import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/views/pegawai_update_view.dart';
import '../controllers/pegawai_controller.dart';

class PegawaiView extends GetView<PegawaiController> {
  void showEnhancedOption(id) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            _buildActionButton(
              icon: Icons.edit_note,
              text: 'Update Pegawai',
              color: Colors.teal,
              onTap: () {
                Get.back();
                Get.to(
                  PegawaiUpdateView(),
                  arguments: id,
                  transition: Transition.rightToLeft,
                );
              },
            ),
            _buildActionButton(
              icon: Icons.delete_sweep,
              text: 'Hapus Pegawai',
              color: Colors.red,
              onTap: () {
                Get.back();
                _showDeleteConfirmation(id);
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(id) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Konfirmasi Hapus',
          style: TextStyle(
            color: Colors.teal[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus data pegawai ini?',
          style: TextStyle(color: Colors.teal[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Get.back();
              controller.delete(id);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(
          'Daftar Pegawai',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Get.put(PegawaiController()).streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data?.docs ?? [];
            return listAllDocs.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    itemCount: listAllDocs.length,
                    itemBuilder: (context, index) {
                      var data =
                          listAllDocs[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.shade100.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.teal[300]!,
                                    Colors.teal[600]!,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.teal.shade200.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "${data["nama"]}",
                              style: TextStyle(
                                color: Colors.teal[900],
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Text(
                              "NIP: ${data["nip"]}",
                              style: TextStyle(
                                color: Colors.teal[700],
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  showEnhancedOption(listAllDocs[index].id),
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.teal[700],
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.diversity_3_outlined,
                          size: 120,
                          color: Colors.teal[300],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Tidak Ada Data Pegawai",
                          style: TextStyle(
                            color: Colors.teal[900],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Silakan tambahkan data pegawai baru",
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
            ),
          );
        },
      ),
    );
  }
}
