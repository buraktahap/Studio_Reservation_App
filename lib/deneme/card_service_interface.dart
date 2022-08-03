import 'package:studio_reservation_app/classes/lesson.dart';
import 'package:studio_reservation_app/classes/pagination_mode.dart';

abstract class CardServiceInterface {
  Future<List<Lesson>> fetchCards(PaginationModel paginate);
}