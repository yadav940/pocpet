import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poc/components/pet_hero_image.dart';
import 'package:poc/provider/history_provider.dart';
import 'package:poc/provider/pet_provider.dart';
import 'package:poc/model/pet_model.dart';
import 'package:provider/provider.dart';
import 'package:zoom_widget/zoom_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});
  final PetModel product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print('Clicked ${widget.product.name}');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: Text(
        "Pet Details",
        style: TextStyle(
          fontSize: size.width * 0.040,
          fontWeight: FontWeight.w600,
        ),
      ),backgroundColor: Theme.of(context).primaryColor,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: size.height * 0.030,
            ),
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /////
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width,
                                height: size.height * 0.3,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Zoom(
                                          child: PetHero(
                                            image: widget.product.image,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: PetHero(
                                    image: widget.product.image,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Text(
                                      "About Me",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.080,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.010,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          widget.product.name,
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.008,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Age",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          "${widget.product.age} years",
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.055,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<HistoryProvider>()
                            .addToCart(widget.product);
                        context.read<PetProvider>().buyItem(widget.product);

                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // prevents dialog from being dismissed by tapping outside
                          builder: (BuildContext context) {
                            return Center(
                              child: Material(
                                type: MaterialType
                                    .transparency, // makes the dialog transparent
                                child: Lottie.asset(
                                  'lib/animation/confetti.json',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            );
                          },
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Close the dialog
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.grey,
                            content: Text(
                              "You've now adopted ${widget.product.name}! 🎉",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Adopt Me (\$${widget.product.price})",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.040,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
