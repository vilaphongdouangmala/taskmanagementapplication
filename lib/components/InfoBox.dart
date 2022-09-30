import 'package:flutter/material.dart';

import '../styles/AppStyle.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    Key? key,
    required this.heading,
    required this.content,
  }) : super(key: key);

  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppStyle.defaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$heading:",
            style: AppStyle.subHeading_l,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              content,
              style: AppStyle.subHeading_l,
            ),
          )
        ],
      ),
    );
  } //ef
}//ec