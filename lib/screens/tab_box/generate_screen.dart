import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_example/blocs/scan_bloc.dart';
import 'package:qr_code_example/blocs/scan_event.dart';
import 'package:qr_code_example/data/models/product.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../utils/colors/app_colors.dart';

class GenerateScreen extends StatelessWidget {
  GenerateScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c333333,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Generate Text",
          style: TextStyle(
              fontFamily: "Itim", color: AppColors.cD9D9D9, fontSize: 27),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
              border: const Border.symmetric(
                  horizontal: BorderSide(width: 2, color: AppColors.cFDB623)),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff3B3B3B).withOpacity(.78)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(child: SvgPicture.asset("assets/icons/text.svg")),
              const SizedBox(
                height: 56,
              ),
              const Text(
                "Text",
                style: TextStyle(
                    fontFamily: "Itim", color: AppColors.cD9D9D9, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff3B3B3B).withOpacity(.78),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // Shadow color
                      spreadRadius: 1, // Spread radius
                      blurRadius: 13, // Blur radius
                      offset:
                          const Offset(0, 0), // Offset in the x and y direction
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                      fontFamily: "Itim",
                      color: AppColors.cD9D9D9,
                      fontSize: 18),
                  cursorColor: AppColors.cD9D9D9.withOpacity(.6),
                  cursorWidth: 3,
                  cursorOpacityAnimates: true,
                  cursorRadius: const Radius.circular(100),
                  decoration: InputDecoration(
                    hintText: "Enter text",
                    hintStyle: TextStyle(
                        fontFamily: "Itim",
                        color: AppColors.cD9D9D9.withOpacity(.34),
                        fontSize: 14),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: AppColors.cD9D9D9.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: AppColors.cD9D9D9.withOpacity(.5)),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.cFDB623,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    context.read<ScanBloc>().add(
                          ProductInsertEvent(
                            productModel: ProductModel(
                              id: 1,
                              name: controller.text,
                              qrCode: DateFormat('dd MMM yyyy, hh:mm a')
                                  .format(DateTime.now()),
                            ),
                          ),
                        );
                    controller.clear();
                  },
                  child: const Text(
                    "Generate QR Code",
                    style: TextStyle(
                        fontFamily: "Itim",
                        color: AppColors.c333333,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
