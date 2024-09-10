import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/screens/subject_marks_screen.dart';

class MarksPreviewItem extends StatefulWidget {
  const MarksPreviewItem(
      {super.key,
      required this.subjectName,
      required this.marks,
      required this.subjectId,
      required this.selectedMonth});

  final String subjectName;
  final List<String> marks;
  final String subjectId;
  final DateTime selectedMonth;

  @override
  State<MarksPreviewItem> createState() => _MarksPreviewItemState();
}

class _MarksPreviewItemState extends State<MarksPreviewItem> {
  bool moreButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ApplicationColors.greyWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.subjectName,
                style: TextStyle(
                  color: ApplicationColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.fade,
              ),
              Listener(
                onPointerDown: (event) {
                  setState(() {
                    moreButtonPressed = true;
                  });
                },
                onPointerUp: (event) {
                  setState(() {
                    moreButtonPressed = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectMarksScreen(
                            subjectId: widget.subjectId,
                            selectedMonth: widget.selectedMonth),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.buttonMore,
                        style: TextStyle(
                          color: moreButtonPressed
                              ? ApplicationColors.darkGrey
                              : ApplicationColors.lightGrey,
                          fontSize: 17,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: moreButtonPressed
                            ? ApplicationColors.darkGrey
                            : ApplicationColors.lightGrey,
                        size: 17,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(15),
          Row(
            children: List.generate(
              widget.marks.length,
              (markIndex) => Row(
                children: [
                  Text(
                    widget.marks[markIndex],
                    style: TextStyle(
                      color: ApplicationColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(33),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
