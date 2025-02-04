import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime selectedDate = DateTime.now(); // تتبع التاريخ المحدد
  DateTime today = DateTime.now(); // تثبيت اليوم عند بداية البناء

  int currentDateSelectedIndex = 0; // لمتابعة اليوم المحدد
  ScrollController scrollController = ScrollController(); // للتحكم في التمرير

  List<String> listOfMonths = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  void dispose() {
    scrollController.dispose(); // تنظيف الموارد عند إلغاء الـ State
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: const Text('My Calendar'),
          ),
          body: Column(
            children: [
              // إظهار التاريخ الحالي
              Container(
                  height: 30,
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${selectedDate.day}-${listOfMonths[selectedDate.month - 1]}, ${selectedDate.year}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.indigo[700]),
                  )),
              const SizedBox(height: 10),
              // تقويم أفقي للتمرير
              SizedBox(
                  height: 80,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: 365,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime displayDate = today.add(Duration(days: index));
                      bool isSelected = currentDateSelectedIndex == index;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentDateSelectedIndex = index;
                            selectedDate = displayDate;
                          });
                        },
                        child: Container(
                          height: 80,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400]!,
                                    offset: const Offset(3, 3),
                                    blurRadius: 5)
                              ],
                              color: isSelected ? Colors.black : Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listOfMonths[displayDate.month - 1],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected ? Colors.white : Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                displayDate.day.toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected ? Colors.white : Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                listOfDays[displayDate.weekday - 1],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected ? Colors.white : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
