import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/city.dart';
import '../screens/main_screen.dart';

class CitySelectionType extends StatelessWidget {
  static const routeName = '/city-selection';
  const CitySelectionType({super.key});

  @override
  Widget build(BuildContext context) {
    var cityProvider = Provider.of<CityData>(context);
    // navigating to home screen
    void _navigateToMainScreen() {
      Navigator.of(context).pushNamed(MainScreen.routeName);
      cityProvider.swapSelectedData();
    }

    Size size = MediaQuery.of(context).size;

    // Status color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      floatingActionButton: cityProvider.getSelectedCities().isNotEmpty
          ? FloatingActionButton(
              backgroundColor: Constants.primaryColor,
              onPressed: _navigateToMainScreen,
              child: const Icon(
                Icons.pin_drop,
                color: Colors.white,
              ),
            )
          : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        title: Text(
          '${cityProvider.getSelectedCities().length} Cities Selected',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          cityProvider.getSelectedCities().isNotEmpty
              ? IconButton(
                  onPressed: _navigateToMainScreen,
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                  ),
                )
              : const Text('')
        ],
      ),
      body: ListView.builder(
        itemCount: cityProvider.cities().length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Constants.primaryColor.withOpacity(.6),
            border: cityProvider.cities()[index].isSelected
                ? Border.all(
                    color: Constants.secondaryColor.withOpacity(.6),
                    width: 2,
                  )
                : Border.all(
                    color: Colors.white,
                  ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Constants.primaryColor.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                blurStyle: BlurStyle.outer,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  cityProvider
                      .toggleIsSelected(cityProvider.cities()[index].id);
                },
                child: Image.asset(
                  cityProvider.cities()[index].isSelected
                      ? 'assets/images/checked.png'
                      : 'assets/images/unchecked.png',
                  width: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${cityProvider.cities()[index].city}, ${cityProvider.cities()[index].country}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: cityProvider.cities()[index].isSelected
                      ? Constants.primaryColor
                      : Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// <uses-permission android:name="android.permission.INTERNET"/>