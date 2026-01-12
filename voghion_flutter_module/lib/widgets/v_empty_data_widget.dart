import 'package:flutter/material.dart';

class VEmptyDataWidget extends StatelessWidget {
  const VEmptyDataWidget({super.key, this.image, this.title, this.onTap});
  final String? image;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/base/data_empty@2x.png", scale: 2),
            Text("Nothing to display"),
          ],
        ),
      ),
    );
  }
}
