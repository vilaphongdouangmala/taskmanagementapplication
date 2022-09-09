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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppStyle.defaultPadding * 0.25),
            child: Text(
              heading,
              style: AppStyle.subHeading_l,
            ),
          ),
          Text(
            content,
          )
        ],
      ),
    );
  } //ef
}//ec