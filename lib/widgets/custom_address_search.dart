import 'package:flutter/material.dart';

class CustomAddressSearch extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onAddressSelected;

  const CustomAddressSearch({
    Key? key,
    required this.controller,
    required this.onAddressSelected,
  }) : super(key: key);

  @override
  _CustomAddressSearchState createState() => _CustomAddressSearchState();
}

class _CustomAddressSearchState extends State<CustomAddressSearch> {
  final List<String> tunisianCities = [
    'Tunis - Centre Ville',
    'La Marsa - Zone Touristique',
    'Carthage - Site Archéologique',
    'Sidi Bou Said - Village',
    'Gammarth - Plage',
    'Les Berges du Lac - Zone d\'Affaires',
    'El Menzah - Quartier Résidentiel',
    'Ariana - Centre',
    'La Soukra - Zone Industrielle',
    'Ben Arous - Centre',
  ];

  List<String> filteredCities = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredCities = List.from(tunisianCities);
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCities = List.from(tunisianCities);
      });
      return;
    }

    setState(() {
      filteredCities = tunisianCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Delivery Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.location_on),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
            ),
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
        if (isSearching) ...[
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a location...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: filterSearchResults,
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.location_city),
                        title: Text(filteredCities[index]),
                        onTap: () {
                          widget.controller.text = filteredCities[index];
                          widget.onAddressSelected(filteredCities[index]);
                          setState(() {
                            isSearching = false;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}