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
  final bool? important;
  final Widget? prefixIcon;
  final PopupProps<T>? popupProps; // Add this to allow custom PopupProps
  // final FutureOr<List<T>> Function(String filter)? asyncItems; // Added for async filtering
 final Future<List<T>> Function(String)? asyncItems; 
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
     this.prefixIcon,
    this.asyncItems,
    this.popupProps, 
    this.important // Add this to allow custom PopupProps
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(
                color: black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            
            if (important ?? false) 
            const Text(
              "*",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xffE03137),
                letterSpacing: -.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        DropdownSearch<T>(
          // key: dropDownKey,
          popupProps: popupProps ?? PopupProps.menu(
            showSearchBox: showSearchBox,
            isFilterOnline: true,
            searchFieldProps: TextFieldProps(
              autofocus: true,
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
          
            //  items: items, // Use items if asyncItems is not provided
             items: items.isEmpty ? [] : items, // Use items if asyncItems is not provided
          asyncItems: asyncItems, 
          //  asyncItems: asyncItems, // i need that type of this props 
      //     items: items.toSet().toList(),
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
              prefixIcon: prefixIcon,
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
