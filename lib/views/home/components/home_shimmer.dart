import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/helpers.ui.dart';
import '../../constants.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.6),
          highlightColor: purpleColor.withOpacity(0.4),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.4,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.6),
                ),
              ),
              verticalSpace(10),
              Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: Get.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.6)),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
