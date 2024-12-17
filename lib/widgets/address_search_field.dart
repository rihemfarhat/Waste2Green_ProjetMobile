import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class AddressSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAddressSelected;

  const AddressSearchField({
    Key? key,
    required this.controller,
    required this.onAddressSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "VOTRE_CLE_API_GOOGLE",  // Remplacez par votre clé API Google
        inputDecoration: InputDecoration(
          labelText: 'Delivery Address',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.location_on),
        ),
        debounceTime: 800,
        countries: ["TN"],  // Limiter à la Tunisie
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          onAddressSelected(prediction.description ?? '');
        },
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? '';
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        },
        seperatedBuilder: Divider(),
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Color(0xFF6A994E)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    prediction.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      ),
    );
  }
} 