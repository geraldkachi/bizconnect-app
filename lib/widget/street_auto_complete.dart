import 'dart:developer';

import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';

class StreetAutoComplete extends ConsumerStatefulWidget {
  const StreetAutoComplete({super.key});

  @override
  ConsumerState<StreetAutoComplete> createState() =>
      _StreetAutoCompleteState();
}

class _StreetAutoCompleteState extends ConsumerState<StreetAutoComplete> with SingleTickerProviderStateMixin {
    // Flag to control whether suggestions are visible or not
  bool showSuggestions = true;

  @override
  Widget build(BuildContext context) {
    final setupBusinessProfileState = ref.watch(setupBusinessProfileViewModelProvider);
    final streetController = setupBusinessProfileState.streetController;
    final streetSuggestions = setupBusinessProfileState.streetSuggestionsList;
    final isLoading = setupBusinessProfileState.isLoading;

          // Method that handles the selected street
          void onStreetSelected(String selectedStreet) {
            streetController.text = selectedStreet;
              print('streetController texting: $streetController');
               setState(() {
                showSuggestions = false; // Hide suggestions after selection
              });
          }
    
        
    void fetchAddressSuggestions(String query) {
      print('query: $query');
       if (query.isEmpty) {
          // Clear suggestions if the query is empty
          ref.read(setupBusinessProfileViewModelProvider.notifier)
              .updateStreetSuggestions([]);
          return;
        }

        // Show suggestions when starting to type
      setState(() {
        showSuggestions = true;
      });

      final selectedCountry = setupBusinessProfileState.selectedCountry;
      final selectedState = setupBusinessProfileState.selectedState;
      final selectedCity = setupBusinessProfileState.selectedCity;

      if (selectedCountry == null || selectedState == null || selectedCity == null) {
        log('Error: Missing required fields');
          log(' query: ${query} country: ${selectedCountry}, state: ${selectedState}, city: ${selectedCity}');

        setupBusinessProfileState.notifyListeners();
        return;
      }

      ref.read(setupBusinessProfileViewModelProvider.notifier)
          .fetchStreetSuggestions(context, query, selectedCountry, selectedState, selectedCity);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Street Address'),
        TextFormField(
          controller: streetController,
          onChanged: fetchAddressSuggestions, // Trigger fetching on text change
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical:   10.0,
              horizontal:  15.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: grey100,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                // color: Colors.grey,
                color: grey100,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            // hintText: hintText,
            hintText: 'Search for street address...',
            hintStyle: const TextStyle(
              fontSize: 10.0,
              color: grey400,
              fontWeight: FontWeight.w400,
            ),
               suffixIcon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.search),
            // prefixIcon:prefixIcon 
          ),
        ),
        if (streetSuggestions.isNotEmpty && showSuggestions) ...[
          // Container
          Container(
            color: Colors.grey[100],
            child: SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: streetSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(streetSuggestions[index]),
                    onTap: () {
                      streetController.text = streetSuggestions[index];
                      onStreetSelected(streetSuggestions[index]);
                      // widget.onStreetSelected(streetSuggestions[index]);
                    },
                  );
                },
              ),
            ),
          ),

          // if (streetSuggestions.isNotEmpty)
          // DropdownButton<String>(
          //   isExpanded: true,
          //   value: null, // No pre-selected value
          //   hint: const Text(''),
          //   items: streetSuggestions.map((street) {
          //     return DropdownMenuItem<String>(
          //       value: street,
          //       child: Text(street),
          //     );
          //   }).toList(),
          //   onChanged: (selectedStreet) {
          //     if (selectedStreet != null) {
          //       onStreetSelected(selectedStreet);
          //     }
          //   },
          // ),
        ],
      ],
    );
  }
}
