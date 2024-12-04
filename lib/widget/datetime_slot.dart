// import 'package:bizconnect/app/theme/colors.dart';
// import 'package:flutter/material.dart';

// class DateTimeSlot {
//   String day;
//   String openTime;
//   String closeTime;

//   DateTimeSlot({required this.day, required this.openTime, required this.closeTime});
// }

// class DateTimeSlots extends StatefulWidget {
//   final List<DateTimeSlot>? initialSlots;
//   final void Function(List<DateTimeSlot>)? onSlotsUpdated;

//   const DateTimeSlots({
//     Key? key,
//     this.initialSlots,
//     this.onSlotsUpdated,
//   }) : super(key: key);

//   @override
//   _DateTimeSlotsState createState() => _DateTimeSlotsState();
// }

// class _DateTimeSlotsState extends State<DateTimeSlots> {
//   late List<DateTimeSlot> slots;

//   static const List<String> daysOfWeek = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday',
//   ];

//   static const List<String> timeSlots = [
//     '09:00 AM',
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 PM',
//     '01:00 PM',
//     '02:00 PM',
//     '03:00 PM',
//     '04:00 PM',
//     '05:00 PM',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     slots = widget.initialSlots ??
//         [
//           DateTimeSlot(day: 'Monday', openTime: '09:00 AM', closeTime: '05:00 PM'),
//         ];
//   }

//   void addSlot() {
//     if (slots.length >= 7) return;

//     final daysWithSlots = slots.map((slot) => slot.day).toSet();
//     final nextAvailableDay = daysOfWeek.firstWhere((day) => !daysWithSlots.contains(day), orElse: () => '');

//     if (nextAvailableDay.isNotEmpty) {
//       setState(() {
//         slots.add(DateTimeSlot(
//           day: nextAvailableDay,
//           openTime: '09:00 AM',
//           closeTime: '05:00 PM',
//         ));
//       });
//       widget.onSlotsUpdated?.call(slots);
//     }
//   }

//   void deleteSlot(int index) {
//     setState(() {
//       slots.removeAt(index);
//     });
//     widget.onSlotsUpdated?.call(slots);
//   }

//   void updateSlot(int index, DateTimeSlot updatedSlot) {
//     setState(() {
//       slots[index] = updatedSlot;
//     });
//     widget.onSlotsUpdated?.call(slots);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Setup opening hours',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: red),
//         ),
//         const SizedBox(height: 8),
//         ...slots.asMap().entries.map((entry) {
//           final index = entry.key;
//           final slot = entry.value;
//           return SlotItem(
//             slot: slot,
//             availableDays: daysOfWeek.where((day) => slots.every((s) => s.day != day || s.day == slot.day)).toList(),
//             timeSlots: timeSlots,
//             onSlotUpdated: (updatedSlot) => updateSlot(index, updatedSlot),
//             onDelete: slots.length > 1 ? () => deleteSlot(index) : null,
//           );
//         }),
//         if (slots.length < 7)
//           TextButton.icon(
//             onPressed: addSlot,
//             icon: const Icon(Icons.add, color: red),
//             label: const Text(
//               'Add more',
//               style: TextStyle(color: red),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class SlotItem extends StatelessWidget {
//   final DateTimeSlot slot;
//   final List<String> availableDays;
//   final List<String> timeSlots;
//   final Function(DateTimeSlot) onSlotUpdated;
//   final VoidCallback? onDelete;

//   const SlotItem({
//     Key? key,
//     required this.slot,
//     required this.availableDays,
//     required this.timeSlots,
//     required this.onSlotUpdated,
//     this.onDelete,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           children: [
//             Expanded(
//               child: DropdownButtonFormField<String>(
//                 value: slot.day,
//                 items: availableDays
//                     .map((day) => DropdownMenuItem(
//                           value: day,
//                           child: Text(day),
//                         ))
//                     .toList(),
//                 onChanged: (newDay) {
//                   if (newDay != null) {
//                     onSlotUpdated(DateTimeSlot(
//                       day: newDay,
//                       openTime: slot.openTime,
//                       closeTime: slot.closeTime,
//                     ));
//                   }
//                 },
//                 decoration: const InputDecoration(labelText: 'Day'),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: DropdownButtonFormField<String>(
//                 value: slot.openTime,
//                 items: timeSlots
//                     .map((time) => DropdownMenuItem(
//                           value: time,
//                           child: Text(time),
//                         ))
//                     .toList(),
//                 onChanged: (newTime) {
//                   if (newTime != null) {
//                     onSlotUpdated(DateTimeSlot(
//                       day: slot.day,
//                       openTime: newTime,
//                       closeTime: slot.closeTime,
//                     ));
//                   }
//                 },
//                 decoration: const InputDecoration(labelText: 'Open Time'),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: DropdownButtonFormField<String>(
//                 value: slot.closeTime,
//                 items: timeSlots
//                     .map((time) => DropdownMenuItem(
//                           value: time,
//                           child: Text(time),
//                         ))
//                     .toList(),
//                 onChanged: (newTime) {
//                   if (newTime != null) {
//                     onSlotUpdated(DateTimeSlot(
//                       day: slot.day,
//                       openTime: slot.openTime,
//                       closeTime: newTime,
//                     ));
//                   }
//                 },
//                 decoration: const InputDecoration(labelText: 'Close Time'),
//               ),
//             ),
//             if (onDelete != null)
//               IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: onDelete,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:bizconnect/app/theme/colors.dart';

// class DateTimeSlot extends StatelessWidget {
//   final String dayLabel;
//   final String openTimeLabel;
//   final String closeTimeLabel;
//   final TextEditingController dayController;
//   final TextEditingController openTimeController;
//   final TextEditingController closeTimeController;
//   final VoidCallback onAddSlot;
//   final VoidCallback onDeleteSlot;
//   final bool isAddButtonVisible;
//   final bool isDeleteButtonVisible;

//   const DateTimeSlot({
//     Key? key,
//     required this.dayLabel,
//     required this.openTimeLabel,
//     required this.closeTimeLabel,
//     required this.dayController,
//     required this.openTimeController,
//     required this.closeTimeController,
//     required this.onAddSlot,
//     required this.onDeleteSlot,
//     this.isAddButtonVisible = true,
//     this.isDeleteButtonVisible = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Setup opening hours',
//           style:
//               TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: red),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Day Dropdown
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     dayLabel,
//                     style: const TextStyle(
//                       color: black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: 7),
//                   TextFormField(
//                     controller: dayController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       hintText: "Select Day",
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 15.0,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(color: black, width: 1.0),
//                       ),
//                       suffixIcon:
//                           const Icon(Icons.arrow_drop_down, color: grey400),
//                     ),
//                     onTap: () {
//                       // Trigger dropdown selection logic
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             // Opening Time
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     openTimeLabel,
//                     style: const TextStyle(
//                       color: black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: 7),
//                   TextFormField(
//                     controller: openTimeController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       hintText: "Select Opening Time",
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 15.0,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(color: black, width: 1.0),
//                       ),
//                       suffixIcon: const Icon(Icons.arrow_drop_down, color: grey400),
//                       // suffixIcon: const Icon(Icons.access_time, color: grey400),
//                     ),
//                     onTap: () {
//                       // Trigger time picker logic
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             // Closing Time
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     closeTimeLabel,
//                     style: const TextStyle(
//                       color: black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: 7),
//                   TextFormField(
//                     controller: closeTimeController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       hintText: "Select Closing Time",
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 15.0,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide:
//                             const BorderSide(color: grey100, width: 1.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                         borderSide: const BorderSide(color: black, width: 1.0),
//                       ),
//                       suffixIcon: const Icon(Icons.arrow_drop_down, color: grey400),
//                       // suffixIcon: const Icon(Icons.access_time, color: grey400),
//                     ),
//                     onTap: () {
//                       // Trigger time picker logic
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         // Buttons
//         Row(
//           children: [
//             if (isAddButtonVisible)
//               // ElevatedButton(
//               //   onPressed: onAddSlot,
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: red,
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(12.0),
//               //     ),
//               //   ),
//               //   child: const Text(
//               //     "Add Slot",
//               //     style: TextStyle(
//               //       fontSize: 14,
//               //       color: white100,
//               //     ),
//               //   ),
//               // ),
//               // if (slots.length < 7)
//               if (isAddButtonVisible)
//                 TextButton.icon(
//                   // onPressed: addSlot,
//                   onPressed: onAddSlot,
//                   icon: const Icon(Icons.add_circle, color: red),
//                   label: const Text(
//                     'Add more',
//                     style: TextStyle(color: red),
//                   ),
//                 ),
//             const Spacer(),
//             if (isDeleteButtonVisible)
//               IconButton(
//                 onPressed: onDeleteSlot,
//                 icon: const Icon(Icons.delete, color: red),
//               ),
//           ],
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:bizconnect/app/theme/colors.dart';

class DateTimeSlot {
  String day;
  String openTime;
  String closeTime;

  DateTimeSlot({required this.day, required this.openTime, required this.closeTime});
}

class DateTimeSlots extends StatefulWidget {
  final List<DateTimeSlot>? initialSlots;
  final void Function(List<DateTimeSlot>)? onSlotsUpdated;

  const DateTimeSlots({
    Key? key,
    this.initialSlots,
    this.onSlotsUpdated,
  }) : super(key: key);

  @override
  _DateTimeSlotsState createState() => _DateTimeSlotsState();
}

class _DateTimeSlotsState extends State<DateTimeSlots> {
  late List<DateTimeSlot> slots;

  static const List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    slots = widget.initialSlots ??
        [
          DateTimeSlot(day: 'Monday', openTime: '09:00 AM', closeTime: '05:00 PM'),
        ];
  }

  void addSlot() {
    if (slots.length >= 7) return;

    final daysWithSlots = slots.map((slot) => slot.day).toSet();
    final nextAvailableDay = daysOfWeek.firstWhere((day) => !daysWithSlots.contains(day), orElse: () => '');

    if (nextAvailableDay.isNotEmpty) {
      setState(() {
        slots.add(DateTimeSlot(
          day: nextAvailableDay,
          openTime: '09:00 AM',
          closeTime: '05:00 PM',
        ));
      });
      widget.onSlotsUpdated?.call(slots);
    }
  }

  void deleteSlot(int index) {
    setState(() {
      slots.removeAt(index);
    });
    widget.onSlotsUpdated?.call(slots);
  }

  void updateSlot(int index, DateTimeSlot updatedSlot) {
    setState(() {
      slots[index] = updatedSlot;
    });
    widget.onSlotsUpdated?.call(slots);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Setup opening hours',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: red),
        ),
        const SizedBox(height: 8),
        ...slots.asMap().entries.map((entry) {
          final index = entry.key;
          final slot = entry.value;
          return SlotItem(
            slot: slot,
            availableDays: daysOfWeek.where((day) => slots.every((s) => s.day != day || s.day == slot.day)).toList(),
            timeSlots: timeSlots,
            onSlotUpdated: (updatedSlot) => updateSlot(index, updatedSlot),
            onDelete: slots.length > 1 ? () => deleteSlot(index) : null,
          );
        }),
        if (slots.length < 7)
          TextButton.icon(
            onPressed: addSlot,
            icon: const Icon(Icons.add, color: red),
            label: const Text(
              'Add more',
              style: TextStyle(color: red),
            ),
          ),
      ],
    );
  }
}

class SlotItem extends StatelessWidget {
  final DateTimeSlot slot;
  final List<String> availableDays;
  final List<String> timeSlots;
  final Function(DateTimeSlot) onSlotUpdated;
  final VoidCallback? onDelete;

  const SlotItem({
    Key? key,
    required this.slot,
    required this.availableDays,
    required this.timeSlots,
    required this.onSlotUpdated,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayController = TextEditingController(text: slot.day);
    final openTimeController = TextEditingController(text: slot.openTime);
    final closeTimeController = TextEditingController(text: slot.closeTime);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Day Field
          Expanded(
            child: TextFormField(
              controller: dayController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Day',
                hintText: 'Select Day',
                suffixIcon: const Icon(Icons.arrow_drop_down, color: grey400),
                border: const OutlineInputBorder(),
              ),
              onTap: () {
                // Show day selection dropdown
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView(
                      children: availableDays
                          .map((day) => ListTile(
                                title: Text(day),
                                onTap: () {
                                  Navigator.pop(context);
                                  onSlotUpdated(DateTimeSlot(
                                    day: day,
                                    openTime: slot.openTime,
                                    closeTime: slot.closeTime,
                                  ));
                                },
                              ))
                          .toList(),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          // Open Time
          Expanded(
            child: TextFormField(
              controller: openTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Open Time',
                hintText: 'Select Opening Time',
                suffixIcon: const Icon(Icons.access_time, color: grey400),
                border: const OutlineInputBorder(),
              ),
              onTap: () {
                // Show time selection
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView(
                      children: timeSlots
                          .map((time) => ListTile(
                                title: Text(time),
                                onTap: () {
                                  Navigator.pop(context);
                                  onSlotUpdated(DateTimeSlot(
                                    day: slot.day,
                                    openTime: time,
                                    closeTime: slot.closeTime,
                                  ));
                                },
                              ))
                          .toList(),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          // Close Time
          Expanded(
            child: TextFormField(
              controller: closeTimeController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Close Time',
                hintText: 'Select Closing Time',
                suffixIcon: const Icon(Icons.access_time, color: grey400),
                border: const OutlineInputBorder(),
              ),
              onTap: () {
                // Show time selection
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView(
                      children: timeSlots
                          .map((time) => ListTile(
                                title: Text(time),
                                onTap: () {
                                  Navigator.pop(context);
                                  onSlotUpdated(DateTimeSlot(
                                    day: slot.day,
                                    openTime: slot.openTime,
                                    closeTime: time,
                                  ));
                                },
                              ))
                          .toList(),
                    );
                  },
                );
              },
            ),
          ),
          // Delete Button
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
