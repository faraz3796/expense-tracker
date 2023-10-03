import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

SizedBox verticalSpace(double n) {
  return SizedBox(
    height: n,
  );
}

SizedBox horizontalSpace(double n) {
  return SizedBox(
    width: n,
  );
}

SizedBox verticalRSpace(double n) {
  return SizedBox(
    height: Get.height * n,
  );
}

SizedBox horizontalRSpace(double n) {
  return SizedBox(
    width: Get.width * n,
  );
}
