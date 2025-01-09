import 'package:flutter/material.dart';
import 'package:frontmetafit/const.dart';

class SumaryWidget extends StatelessWidget {
  final List<ElementosSumary> data;

  const SumaryWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width;
    final sizeh = MediaQuery.of(context).size.height;

    return Container(
        height: sizeh * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondary,
            width: 2,
          ),
          color: AppColors.primaryDark,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text('Sumary',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.complementary,
                  )),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (var e in data)
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                ),
                                color: AppColors.complementary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 13,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: LinearProgressIndicator(
                              value: e.value / 100,
                              backgroundColor: Colors.transparent,
                              minHeight: 8,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.complementary),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(e.value.toString(),
                                  style: TextStyle(
                                      color: AppColors.complementary))),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ));
  }
}

class ElementosSumary {
  final String name;
  final int value;

  ElementosSumary({required this.name, required this.value});
}
