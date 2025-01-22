import 'package:flutter/material.dart';
import 'package:poc/components/pet_hero_image.dart';
import 'package:poc/model/pet_model.dart';
import 'package:poc/pages/details_screen.dart';

class PetCard extends StatefulWidget {
  final PetModel product;

  const PetCard({
    super.key,
    required this.product,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    bool isAvailable = widget.product.isAvailable;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: size.width * 0.50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: isAvailable
                  ? () {
                      Navigator.push(
                        context,
                          createRoute(widget.product)
                        /*MaterialPageRoute(
                          builder: (context) =>
                              BuyScreen(product: widget.product),
                        ),*/
                      );
                    }
                  : null,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: PetHero(
                      image: widget.product.image,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isAvailable == false
                          ? Colors.grey
                          : Colors.transparent,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Text(
              widget.product.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.033,
              ),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            SizedBox(
              child: widget.product.isAvailable
                  ? Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xff03B680),
                          radius: 4,
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          "Available",
                          style: TextStyle(
                            color: const Color(0xff03B680),
                            fontSize: size.width * 0.031,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 4,
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          "Already Adopted",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: size.width * 0.031,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
          ],
        ),
      ),
    );
  }

  Route createRoute(PetModel product) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  DetailsScreen(product: product),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

}
