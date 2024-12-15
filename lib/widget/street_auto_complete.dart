import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';

class StreetAutoComplete extends ConsumerStatefulWidget {
  //  final Function(String) onStreetSelected;
  const StreetAutoComplete({super.key});

  @override
  ConsumerState<StreetAutoComplete> createState() =>
      _StreetAutoCompleteState();
}

class _StreetAutoCompleteState extends ConsumerState<StreetAutoComplete> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final setupBusinessProfileState = ref.watch(setupBusinessProfileViewModelProvider);
    final streetController = setupBusinessProfileState.streetController;
    final streetSuggestions = setupBusinessProfileState.streetSuggestions;
    final isLoading = setupBusinessProfileState.isLoading;

          // Method that handles the selected street
          void onStreetSelected(String selectedStreet) {
            setupBusinessProfileState.streetController.text = selectedStreet;
            // Optionally, you can save this in the state or use it for further actions
          }
    
        void fetchAddressSuggestions(String query) {
          if (query.isEmpty) return;

          ref.read(setupBusinessProfileViewModelProvider.notifier)
              .fetchStreetSuggestions(context, query, setupBusinessProfileState.selectedCountry!, setupBusinessProfileState.selectedState!, setupBusinessProfileState.selectedCity!);
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
        if (streetSuggestions.isNotEmpty) ...[
          // Container
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: streetSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(streetSuggestions[index]),
                  onTap: () {
                    streetController.text = streetSuggestions[index];
                    onStreetSelected(streetSuggestions[index]);
                     streetController.text = streetSuggestions[index];
                    // widget.onStreetSelected(streetSuggestions[index]);
                  },
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
