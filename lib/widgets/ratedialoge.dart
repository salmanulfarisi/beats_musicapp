import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateDialogePage extends StatefulWidget {
  final RateMyApp rateMyApp;
  const RateDialogePage({Key? key, required this.rateMyApp}) : super(key: key);

  @override
  State<RateDialogePage> createState() => _RateDialogePageState();
}

class _RateDialogePageState extends State<RateDialogePage> {
  String comment = '';
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Rate this app',
          style: TextStyle(
            color: white,
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: const Icon(Icons.star, color: white),
      onTap: () {
        widget.rateMyApp.showStarRateDialog(
          context,
          // contentBuilder: (context, _) => buildComment(context),
          title: 'Rate this app',
          message:
              'If you like this app, please take a moment to rate it. It really helps us and it won\'t take more than a minute. Thanks for your support!',
          starRatingOptions: const StarRatingOptions(initialRating: 4),
          actionsBuilder: actionsBuilder,
        );
        // widget.rateMyApp.showRateDialog(
        //   context,
        //   title: 'Rate this app',
        //   message:
        //       'If you enjoy using this app, please take a moment to rate it. It won\'t take more than a minute. Thanks for your support!',
        //   rateButton: 'Rate now',
        //   laterButton: 'Later',
        // );
      },
    );
  }

  List<Widget> actionsBuilder(BuildContext context, double? stars) {
    return stars == null
        ? [buildCancelButton()]
        : [buildOkButton(stars, context), buildCancelButton()];
  }

  buildCancelButton() {
    return RateMyAppNoButton(widget.rateMyApp, text: 'Cancel');
  }

  buildOkButton(double stars, context) {
    return TextButton(
        onPressed: () async {
          if (stars < 4) {
            Fluttertoast.showToast(
                msg: 'Thank you for your support!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(msg: 'Thanks for your rating!');
          }

          final launchAppStore = stars >= 4;
          const event = RateMyAppEventType.rateButtonPressed;
          await widget.rateMyApp.callEvent(event);
          if (launchAppStore) {
            widget.rateMyApp.launchStore();
          }
          Navigator.of(context).pop();
        },
        child: const Text('Rate now'));
  }

  // buildComment(BuildContext context) {
  //   return TextFormField(
  //     autofocus: true,
  //     onFieldSubmitted: (_)=>Navigator.of(context),
  //     decoration: const InputDecoration(
  //         hintText: 'Please enter your comment...',
  //         border: OutlineInputBorder()),
  //     maxLines: 3,
  //     onChanged: (comment) => setState(() {
  //       this.comment = comment;
  //     }),
  //   );
  // }
}
