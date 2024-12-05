import 'dart:async';

import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownField<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final GlobalKey<DropdownSearchState<T>>? dropdownKey;
  // final FutureOr<List<T>> Function(String filter, LoadProps? loadProps)? items;
  final T? selectedItem;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget? dropdownIcon;
  final bool showSearchBox;
  final PopupProps<T>? popupProps; // Add this to allow custom PopupProps

  // asyncItems FutureOr<List<T>>;
  

   DropdownField({
    super.key,
    this.dropdownKey,
    required this.labelText,
    required this.hintText,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.validator,
    this.dropdownIcon,
    this.showSearchBox = false,
    // this.asyncItems,
    this.popupProps // Add this to allow custom PopupProps

  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 7),
        DropdownSearch<T>(
          // key: dropDownKey,
          popupProps: popupProps ?? PopupProps.menu(
            showSearchBox: showSearchBox,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                hintText: "Search...",
                hintStyle: const TextStyle(
                  fontSize: 10.0,
                  color: grey400,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: grey100,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),

           asyncItems: (String filter) async {
            return items; // Return the list of items
          },
          //  asyncItems: asyncItems,
          items: items,
      //       asyncItems: (String filter) async {
      //   return items.where((item) => item.toString().contains(filter)).toList();
      // },
          selectedItem: selectedItem,
          
          // decoratorProps: DropDownDecoratorProps(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
            // decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: grey100,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: grey100,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: black,
                  width: 1.0,
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 10.0,
                color: grey400,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: dropdownIcon,
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
