import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';
import 'package:bizconnect/utils/business_profile_data.dart';
import 'package:flutter/material.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateTimeSlot {
  String day;
  String openTime;
  String closeTime;

  DateTimeSlot(
      {required this.day, required this.openTime, required this.closeTime});
  // Convert the DateTimeSlot instance to a JSON-compatible map
  Map<String, String> toJson() {
    return {
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}

class DateTimeSlots extends  ConsumerStatefulWidget {
  final List<DateTimeSlot>? initialSlots;
  final void Function(List<DateTimeSlot>)? onSlotsUpdated;

  const DateTimeSlots({
    super.key,
    this.initialSlots,
    this.onSlotsUpdated,
  });

  @override
  _DateTimeSlotsState createState() => _DateTimeSlotsState();
}

class _DateTimeSlotsState extends ConsumerState<DateTimeSlots> {

  @override
  Widget build(BuildContext context) {
    final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Setup opening hours',
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: red),
        ),
        const SizedBox(height: 8),
        ...setupProfileWatch.slots.asMap().entries.map((entry) {
          final index = entry.key;
          final slot = entry.value;
          return SlotItem(
            slot: slot,
            availableDays:BusinessProfileData.daysOfWeek
                .where((day) =>
                    setupProfileWatch.slots.every((s) => s.day != day || s.day == slot.day))
                .toList(),
            timeSlots: BusinessProfileData.timeSlots,
            onSlotUpdated: (updatedSlot) => setupProfileWatch.updateSlot(index, updatedSlot),
            onDelete: setupProfileWatch.slots.length > 1 ? () => setupProfileWatch.deleteSlot(index) : null,
          );
        }),
        if (setupProfileWatch.slots.length < 7)
          TextButton.icon(
            onPressed: setupProfileWatch.addSlot,
            icon: const Icon(Icons.add_circle, color: red),
            label: const Text(
              'Add more',
              style:
                  TextStyle(color: red, decoration: TextDecoration.underline),
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
    super.key,
    required this.slot,
    required this.availableDays,
    required this.timeSlots,
    required this.onSlotUpdated,
    this.onDelete,
  });

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Day",
                  style: TextStyle(
                    color: grey401,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 7),
                TextFormField(
                  controller: dayController,
                  readOnly: true,
                  decoration: InputDecoration(
                    // labelText: 'Day',
                    hintText: '--',
                    hintStyle: const TextStyle(
                      fontSize: 6.0,
                      color: grey400,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon:
                        const Icon(Icons.arrow_drop_down, color: grey400),
                    // border: OutlineInputBorder(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: grey100, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: grey100, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: black, width: 1.0),
                    ),
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
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Open Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Opening hour",
                  style: TextStyle(
                    color: grey401,
                    fontSize: 12,
                    // fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 7),
                TextFormField(
                  controller: openTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    // labelText: 'Opening hour',
                    hintStyle: const TextStyle(
                      fontSize: 6.0,
                      color: grey400,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: '--',
                    // suffixIcon: const Icon(Icons.access_time, color: grey400),
                    suffixIcon:
                        const Icon(Icons.arrow_drop_down, color: grey400),
                    // border: OutlineInputBorder(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: grey100, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: grey100, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: black, width: 1.0),
                    ),
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
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none, // Allows the icon to overflow the bounds
              children: [
                // Closing Hour Input Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Closing hour",
                      style: TextStyle(
                        color: grey401,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: closeTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        // labelText: 'Closing hour',
                        hintText: '--',
                        hintStyle: const TextStyle(
                      fontSize: 6.0,
                      color: grey400,
                      fontWeight: FontWeight.w400,
                    ),
                        suffixIcon:
                            const Icon(Icons.arrow_drop_down, color: grey400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: grey100, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: grey100, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: black, width: 1.0),
                        ),
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
                  ],
                ),
                // Delete Icon Positioned at the Top-Right Corner
                if (onDelete != null)
                  Positioned(
                    top: 2,
                    right: -12,
                    child: IconButton(
                      icon:
                          const Icon(Icons.cancel_rounded, color: Colors.black),
                      onPressed: onDelete,
                      constraints:
                          const BoxConstraints(), // Removes extra padding
                      padding:
                          EdgeInsets.zero, // Ensures the icon aligns correctly
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
