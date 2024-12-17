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
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple[400]!,
              Colors.deepPurple[600]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.shade700.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 3,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 6,
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            _buildActionButton(
              icon: Icons.edit_note,
              text: 'Update Pegawai',
              color: Colors.tealAccent,
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
              color: Colors.pinkAccent,
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
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.deepOrange),
            SizedBox(width: 10),
            Text(
              'Konfirmasi Hapus',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus data pegawai ini?',
          style: TextStyle(
            color: Colors.blueGrey[700],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
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
          backgroundColor: color.withOpacity(0.2),
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
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
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text(
          'Daftar Pegawai',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
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
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.deepPurple[50]!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.deepPurple.shade200.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.deepPurple.shade100,
                              width: 1,
                            ),
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
                                    Colors.deepPurple[300]!,
                                    Colors.deepPurple[600]!,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurple.shade300
                                        .withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
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
                                color: Colors.deepPurple[900],
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Text(
                              "NIP: ${data["nip"]}",
                              style: TextStyle(
                                color: Colors.deepPurple[700],
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () =>
                                  showEnhancedOption(listAllDocs[index].id),
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.deepPurple[700],
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
                          color: Colors.deepPurple[300],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Tidak Ada Data Pegawai",
                          style: TextStyle(
                            color: Colors.deepPurple[900],
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Silakan tambahkan data pegawai baru",
                          style: TextStyle(
                            color: Colors.deepPurple[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade700),
            ),
          );
        },
      ),
    );
  }
}
