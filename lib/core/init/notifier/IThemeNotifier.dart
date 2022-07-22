import '../../constants/enums/app_theme_enums.dart';

abstract class IThemeNotifier {
    
    void changeValue(AppThemes theme);
}