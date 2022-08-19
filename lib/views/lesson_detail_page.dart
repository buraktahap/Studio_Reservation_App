import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studio_reservation_app/components/background.dart';
import 'package:studio_reservation_app/core/base/base_viewmodel.dart';
import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({Key? key}) : super(key: key);

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BookingViewModel>(
        viewModel: BookingViewModel(),
        onModelReady: (model) {},
        onPageBuilder: (context, value) => Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Flexible(
                child: Stack(
                  children: [
                    Image.asset('assets/images/asset01.png'),
                    DraggableScrollableSheet(
                      expand: true,
                      initialChildSize: 0.6,
                      minChildSize: 0.4,
                      maxChildSize: 0.8,
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text(
                                  "asdasdadasdasdadadasdafsadsdfgadfhadfailsşdişlhşflhmİŞbmhŞİHBMŞEmŞİELGmEŞgmlSDKfmLASkfm",
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ));
                      },
                    )
                    // ...
                  ],
                ),
              ),
            ));
  }
}
