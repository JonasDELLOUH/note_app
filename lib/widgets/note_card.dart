import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: AppStyle.cardsColor[doc['color_id']],
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: AppStyle.mainTitleStyle,
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            doc["creation_date"].toString(),
            style: AppStyle.dateTitleStyle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            doc["note_content"],
            style: AppStyle.mainContentStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
