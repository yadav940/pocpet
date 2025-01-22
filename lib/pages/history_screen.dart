import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poc/provider/history_provider.dart';
import 'package:poc/components/history_item.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Order History",
          style: TextStyle(
            fontSize: size.width * 0.040,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.060,
            ),
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: context.watch<HistoryProvider>().historyList.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<HistoryProvider>(
                              builder: (context, value, child) => Column(
                                children: value.historyList
                                    .map(
                                      (cartItem) => HistoryItem(
                                        historyItem: cartItem,
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("lib/animation/no_record_found_anim.json",
                                  height: 300),
                              SizedBox(
                                height: size.height * 0.020,
                              ),
                              Text(
                                "Your cart is empty!",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Call loadState() when the screen/widget is initialized
    Provider.of<HistoryProvider>(context, listen: false).loadState();
  }
}
