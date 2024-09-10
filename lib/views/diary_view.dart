import 'dart:io' show SocketException;
import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/views.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  DateTime _selectedWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime _selectedWeekEnd = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .add(const Duration(days: 6));

  Future<DiaryModel> loadDiary(DateTime startDate, DateTime endDate,
      int studentId, String accessToken) async {
    StudentPeriodModel studentPeriod = StudentPeriodModel(
        endDate: endDate,
        startDate: startDate,
        studentId: studentId.toString());

    DiaryModel diary =
        await DiaryService().fetchDiary(studentPeriod, accessToken);

    return diary;
  }

  void refreshDiary(BuildContext context) {
    final currentWeekStart = _selectedWeekStart;

    setState(() {
      _selectedWeekStart = DateTime.now();
    });

    // fetch user access key
    Provider.of<UserProvider>(context, listen: false).fetchUser();

    setState(() {
      _selectedWeekStart = currentWeekStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: ApplicationColors.backgroundGradient,
      ),
      child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context)!.diary,
            onCodeBtnPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CodeScreen()));
            },
            onSettingsBtnPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
          WeekSelecter(
            onChange: (DateTime startOfWeek, DateTime endOfWeek) {
              setState(() {
                _selectedWeekStart = startOfWeek;
                _selectedWeekEnd = endOfWeek;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<DiaryModel>(
              future: loadDiary(
                _selectedWeekStart,
                _selectedWeekEnd,
                userProvider.user.studentId,
                userProvider.user.accessToken,
              ),
              builder:
                  (BuildContext context, AsyncSnapshot<DiaryModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DataLoadingView();
                }

                if (snapshot.hasError) {
                  if (snapshot.error is SocketException) {
                    return NoInternetConnectionView(
                        onRefreshPressed: () => {refreshDiary(context)});
                  } else {
                    return const Center(child: Text('An error occurred'));
                  }
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.dates == null ||
                    snapshot.data!.dates!.isEmpty) {
                  return const DiaryEmptyView();
                }

                return Scrollbar(
                    child: ListView(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  children:
                      List.generate(snapshot.data!.dates!.length, (dateIndex) {
                    return DiarySection(
                      date: snapshot.data!.dates![dateIndex].date!,
                      calls: snapshot.data!.dates![dateIndex].calls!,
                    );
                  }),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
