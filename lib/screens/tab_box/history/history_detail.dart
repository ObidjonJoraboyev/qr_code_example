import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_example/blocs/scan_bloc.dart';
import 'package:qr_code_example/blocs/scan_state.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../data/models/product.dart';
import '../../../services/widget_saver_service.dart';
import '../../../utils/colors/app_colors.dart';

class HistoryDetailScreen extends StatelessWidget {
  HistoryDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff525252).withOpacity(.8),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.cD9D9D9,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "QR Code",
          style: TextStyle(
              fontFamily: "Itim", color: AppColors.cD9D9D9, fontSize: 27),
        ),
      ),
      body: BlocBuilder<ScanBloc, ScanState>(builder: (context, state) {
        if (state is ProductSuccessState) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 36),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 20,
                          color: Colors.black.withOpacity(.3))
                    ],
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff3B3B3B)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Data",
                      style: TextStyle(
                          fontFamily: "Itim",
                          color: AppColors.cD9D9D9,
                          fontSize: 19),
                    ),
                    Text(
                      productModel.qrCode,
                      style: const TextStyle(
                          fontFamily: "Itim",
                          color: AppColors.cD9D9D9,
                          fontSize: 19),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: AppColors.cFDB623),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QrImageView(
                        data: productModel.qrCode,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 41,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.cFDB623,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          WidgetSaverService.openWidgetAsImage(
                            context: context,
                            widgetKey: _globalKey,
                            fileId: productModel.qrCode,
                          );
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 32,
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Share",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.cD9D9D9,
                            fontFamily: "itim"),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.cFDB623,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          WidgetSaverService.saveWidgetToGallery(
                            context: context,
                            widgetKey: _globalKey,
                            fileId: productModel.qrCode,
                          );
                        },
                        icon: const Icon(
                          Icons.save,
                          size: 32,
                          color: Color(0xff333333),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.cD9D9D9,
                            fontFamily: "itim"),
                      )
                    ],
                  )
                ],
              )
            ],
          );
        }
        return const Center(
          child: Text("ERROR"),
        );
      }),
    );
  }
}
