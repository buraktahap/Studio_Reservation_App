// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';
// import 'package:studio_reservation_app/classes/lesson.dart';
// import 'package:studio_reservation_app/components/lesson_CArd.dart';
// import 'package:studio_reservation_app/viewmodels/booking_view_model.dart';

// class BookingView extends StatelessWidget {
//   BookingViewModel viewModel = BookingViewModel();

//   BookingView() {
//     viewModel.getAllLessons();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final future = viewModel.lessonListFuture;
//     return Observer(
//       builder: (_) {
//         switch (future.status) {
//           case FutureStatus.pending:
//             return Center(
//               child: CircularProgressIndicator(),
//             );

//           case FutureStatus.rejected:
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Failed to load items.',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     child: const Text('Tap to retry'),
//                     onPressed: (){},
//                   )
//                 ],
//               ),
//             );
//           case FutureStatus.fulfilled:
//             final List<Lesson> lessons = future.result;
//             print(lessons);
//             return RefreshIndicator(
//               onRefresh: ()async{
//                 await Future.delayed(Duration(seconds: 1));
//                 viewModel.getAllLessons();

//               },
//               child: ListView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 itemCount: lessons.length,
//                 itemBuilder: (context, index) {
//                   final lesson = lessons[index];
//                   return ExpansionTile(
//                     title: Text(
//                       lesson.name.toString(),
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     children: <Widget>[Text(lesson.trainer.toString())],
//                   );
//                 },
//               ),
//             );
            
//         }
//       },
//     );
//   }
// }
