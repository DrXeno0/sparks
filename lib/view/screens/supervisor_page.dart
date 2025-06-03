import 'package:flutter/material.dart';
import 'package:sparks/model/gender.dart';
import 'package:sparks/model/profile_card_model.dart';
import 'package:sparks/nav_system/my_custome_nav.dart';
import 'package:sparks/view/components/my_custom_button.dart';
import 'package:sparks/view/components/my_custom_dropdown.dart';
import 'package:sparks/view/components/supervisor_card.dart';
import 'package:sparks/view/screens/add_supervisor_page.dart';

class SuperVisorPage extends StatefulWidget {
  const SuperVisorPage({super.key});

  @override
  State<SuperVisorPage> createState() => _SuperVisorPageState();
}

class _SuperVisorPageState extends State<SuperVisorPage> {
  String selectedDivision = 'All';

  List<ProfileCardInfo> supervisors = [
    ProfileCardInfo(
      id: "1",
      name: "Sarah Amrani",
      division: "Engineering",
      gender: Gender.female,
      imageUrl: "assets/images/dummy.jpeg",
    ),
    ProfileCardInfo(
      id: "2",
      name: "Mohamed Ait Taleb",
      division: "HR",
      gender: Gender.male,
      imageUrl: "assets/images/dummy.jpeg",
    ),
    ProfileCardInfo(
      id: "3",
      name: "Lina Qadiri",
      division: "Design",
      gender: Gender.female,
      imageUrl: null,
    ),
    // Add more supervisors if needed
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = selectedDivision == 'All'
        ? supervisors
        : supervisors.where((sup) => sup.division == selectedDivision).toList();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          children: [
            // Filter + Add Supervisor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyDropdown(
                  title: 'Select Division',
                  items: ['All', 'Engineering', 'HR', 'Design'],
                  width: 250,
                ),
                MyButton(
                    text: 'Add Supervisor',
                    iconAsset: 'assets/icons/icon=add.svg',
                    width: 200,
                    onPressed: () {
                      RouteController.goTo(
                          const AddSupervisorPage(), 'addSupervisor');
                    }),
              ],
            ),
            const SizedBox(height: 20),

            // Grid of supervisor cards
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 740,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 511 / 160,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return SupervisorCard(supervisor: filteredList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
