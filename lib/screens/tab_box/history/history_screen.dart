import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_example/blocs/scan_event.dart';
import 'package:qr_code_example/screens/tab_box/history/history_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../blocs/scan_bloc.dart';
import '../../../blocs/scan_state.dart';
import '../../../utils/colors/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff525252).withOpacity(.8),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "History",
              style: TextStyle(
                  fontFamily: "Itim", color: AppColors.cD9D9D9, fontSize: 27),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 180),
              child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/icons/scanHistory.svg",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
            )
          ],
        ),
      ),
      body: BlocBuilder<ScanBloc, ScanState>(
        builder: (BuildContext context, state) {
          if (state is ProductSuccessState) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                  color: AppColors.c333333,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.black.withOpacity(.3))
                  ]),
              child: state.products.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                          state.products.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HistoryDetailScreen(
                                            productModel: state.products[index],
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 9),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 15,
                                        color: Colors.black.withOpacity(.3))
                                  ],
                                  color: const Color(0xff333333)),
                              child: ListTile(
                                leading: Image.asset(
                                  "assets/images/img.png",
                                  width: 40,
                                ),
                                subtitle: Row(
                                  children: [
                                    const Text(
                                      "Data",
                                      style: TextStyle(
                                          fontFamily: "itim",
                                          fontSize: 16,
                                          color: Color(0xffa4a4a4)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      state.products[index].qrCode,
                                      style: const TextStyle(
                                          fontFamily: "itim",
                                          fontSize: 14,
                                          color: Color(0xffa4a4a4)),
                                    ),
                                  ],
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      state.products[index].name,
                                      style: const TextStyle(
                                          fontFamily: "itim",
                                          fontSize: 18,
                                          color: AppColors.cD9D9D9),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        context.read<ScanBloc>().add(
                                            ProductDeleteEvent(
                                                id: state.products[index].id));
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: AppColors.cFDB623,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Lottie.asset(
                        "assets/lotties/empty.json",
                        width: 200,
                      ),
                    ),
            );
          }
          return const Center(
            child: Text(
              "Something went wrong",
            ),
          );
        },
      ),
    );
  }
}
