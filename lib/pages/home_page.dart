import 'package:flutter/material.dart';
import 'package:poc/components/pet_category.dart';
import 'package:poc/pages/history_screen.dart';
import 'package:poc/provider/pet_provider.dart';
import 'package:poc/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search = '';
  final TextEditingController _productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Icon(
              Icons.location_on,
            ),
          ),
          title: const Text(
            'Bangalore, India',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Provider.of<ThemeProvider>(context).getTheme == lightMode
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme()
                        },
                        child: const Icon(
                          Icons.light_mode,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme()
                        },
                        child: const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: Theme.of(context).colorScheme.background,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HistoryScreen();
              },
            ),
          ),
          child: Icon(Icons.history,
              color: Theme.of(context)
                  .colorScheme
                  .surface), // Icon(Icons.shopping_cart),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  child: TextFormField(
                    controller: _productNameController,
                    onChanged: (text) {
                      setState(() {
                        search = text; // Update the entered text
                      });
                    },
                    decoration: InputDecoration(
                      // focusColor: Colors.black38,
                      isCollapsed: false,
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: TextStyle(fontSize: size.width * 0.040,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.01,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          // color: Colors.black26,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          // color: Colors.black26,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PetCategory(title: 'Rabbit', search: search),
                    PetCategory(title: 'Dog', search: search),
                    PetCategory(title: 'Cat', search: search),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Call loadState() when the screen/widget is initialized
    Provider.of<PetProvider>(context, listen: false).loadState();
    //Provider.of<ThemeProvider>(context, listen: false).loadTheme();
  }
}
