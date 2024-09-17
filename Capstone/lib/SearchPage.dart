import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedCampus;
  String? selectedBuilding;
  String? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownMenu<String>(
                width: 250,
                menuHeight: 300,
                label: Text("Select Campus"),
                initialSelection: null,
                onSelected: (String? newValue) {
                  setState(() {
                    selectedCampus = newValue;
                    selectedBuilding = null;
                  });
                },
                dropdownMenuEntries:
                buildingData.Campus.map<DropdownMenuEntry<String>>(
                        (String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
              ),

              DropdownMenu<String>(
                width: 250,
                menuHeight: 300,
                label: Text("Select Building"),
                initialSelection: null,
                onSelected: (String? newValue) {
                  setState(() {
                    selectedBuilding = newValue;
                  });
                },
                dropdownMenuEntries: getBuildings(selectedCampus)
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),

              DropdownMenu<String>(
                width: 250,
                menuHeight: 300,
                label: Text("Select Room"),
                initialSelection: null,
                onSelected: (String? newValue) {
                  setState(() {
                    selectedRoom = newValue;
                  });
                },
                dropdownMenuEntries: ['1000', '1001', '1002', '1003', '1004', '1005', '1006', '1007', '1008', '1000', '1001', '1002', '1003', '1004', '1005', '1006', '1007', '1008']
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {

                },
                child: Text("Start"),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> getBuildings(String? campus) {
    switch (campus) {
      case 'MainCampus':
        return buildingData.MainCampus;
      case 'Engineering':
        return buildingData.Engineering;
      case 'HealthScience':
        return buildingData.HealthScience;
      default:
        return [];
    }
  }
}

class buildingData {
  static final List<String> Campus = [
    'MainCampus',
    'Engineering',
    'HealthScience',
  ];

  static final List<String> MainCampus = [
    'Student Union',
    'Carlson Library',
    'University Hall',
    'Memorial Field House',
    'Savage Arena',
    'Rocket Hall',
    'Honors Academic Village',
    'Gillham Hall',
    'Bowman-Oddy Laboratories',
    'Wolfe Hall',
    'Stranahan Hall',
    'Fetterman Training Center',
    'Health and Human Services Building',
    'Center for Performing Arts',
  ];

  static final List<String> Engineering = [
    'North Engineering',
    'Nitschke Hall',
  ];

  static final List<String> HealthScience = [
    'UT Medical Center',
    'Mulford Library',
    'Health Education Building',
    'Center for Creative Education',
    'Block Health Science Building',
    'Kobacker Center',
  ];
}
