import 'package:get/get.dart';
import 'package:myapp/app/modules/karyawan_22312019/controllers/karyawan_controller.dart';


class karyawan_22312019Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<karyawan_22312019Controller>(
      () => karyawan_22312019Controller(),
    );
  }
}