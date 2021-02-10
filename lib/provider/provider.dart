import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/cubit/archive/archivecubit.dart';
import 'package:isbusiness/cubit/courseinfo/courseinfocubit.dart';
import 'package:isbusiness/cubit/coursespromo/coursespromocubit.dart';
import 'package:isbusiness/cubit/eventinfo/eventinfocubit.dart';
import 'package:isbusiness/cubit/eventpastinfo/eventpastinfocubit.dart';
import 'package:isbusiness/cubit/events/eventscubit.dart';
import 'package:isbusiness/cubit/home/homecubit.dart';
import 'package:isbusiness/cubit/lessoninfo/lessoninfocubit.dart';
import 'package:isbusiness/cubit/login/logincubit.dart';
import 'package:isbusiness/cubit/menu/menucubit.dart';
import 'package:isbusiness/cubit/pastevents/pasteventscubit.dart';
import 'package:isbusiness/cubit/privilege/privilegecubit.dart';
import 'package:isbusiness/cubit/profile/profilecubit.dart';
import 'package:isbusiness/cubit/projectinfo/projectinfocubit.dart';
import 'package:isbusiness/cubit/registration/registrationcubit.dart';
import 'package:isbusiness/cubit/settings/settingscubit.dart';
import 'package:isbusiness/cubit/shop/shopcubit.dart';
import 'package:isbusiness/cubit/splash/splashcubit.dart';
import 'package:isbusiness/screens/archive/archivescreen.dart';
import 'package:isbusiness/screens/course/coursescreen.dart';
import 'package:isbusiness/screens/course/coursespromo.dart';
import 'package:isbusiness/screens/event/eventscreen.dart';
import 'package:isbusiness/screens/lesson/lessonscreen.dart';
import 'package:isbusiness/screens/pastevent/pastevent.dart';
import 'package:isbusiness/screens/pastevents/pasteventsscreen.dart';
import 'package:isbusiness/screens/projectinfo/projectinfoscreen.dart';
import 'package:isbusiness/screens/events/eventsscreen.dart';
import 'package:isbusiness/screens/home/homescreen.dart';
import 'package:isbusiness/screens/homemenu/menu.dart';
import 'package:isbusiness/screens/login/loginscreen.dart';
import 'package:isbusiness/screens/privilege/privilegescreen.dart';
import 'package:isbusiness/screens/profile/profilescreen.dart';
import 'package:isbusiness/screens/registration/registrationscreen.dart';
import 'package:isbusiness/screens/settings/settings.dart';
import 'package:isbusiness/screens/shop/shopscreen.dart';
import 'package:isbusiness/screens/splash/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: ApiService()),
  BlocProvider(
    create: (context) => LoginCubit(ApiService()),
    child: LoginScreen(),
  ),
  BlocProvider(
    create: (context) => RegistrationCubit(ApiService()),
    child: RegistrationScreen(),
  ),
  BlocProvider(
    create: (context) => HomeCubit(ApiService()),
    child: HomeScreen(),
  ),
  BlocProvider(
    create: (context) => SplashCubit(ApiService()),
    child: SplashScreen(),
  ),
  BlocProvider(
    create: (context) => EventsCubit(ApiService()),
    child: EventsScreen(),
  ),
  BlocProvider(
    create: (context) => ShopCubit(ApiService()),
    child: ShopScreen(),
  ),
  BlocProvider(
    create: (context) => ProfileCubit(ApiService()),
    child: ProfileScreen(),
  ),
  BlocProvider(
    create: (context) => PrivilegeCubit(ApiService()),
    child: PrivilegeScreen(),
  ),
  BlocProvider(
    create: (context) => MenuCubit(),
    child: Menu(),
  ),
  BlocProvider(
    create: (context) => ProjectInfoCubit(ApiService()),
    child: ProjectInfo(),
  ),
  BlocProvider(
    create: (context) => CourseInfoCubit(ApiService()),
    child: CourseInfo(),
  ),
  BlocProvider(
    create: (context) => EventInfoCubit(ApiService()),
    child: EventInfo(),
  ),
  BlocProvider(
    create: (context) => SettingsCubit(ApiService()),
    child: SettingsScreen(),
  ),
  BlocProvider(
    create: (context) => EventsPastCubit(ApiService()),
    child: PastEventsScreen(),
  ),
  BlocProvider(
    create: (context) => EventPastInfoCubit(ApiService()),
    child: EventPastInfo(),
  ),
  BlocProvider(
    create: (context) => LessonInfoCubit(ApiService()),
    child: LessonInfo(),
  ),
  BlocProvider(
    create: (context) => CoursesPromoCubit(ApiService()),
    child: CoursesPromo(),
  ),
  BlocProvider(
    create: (context) => ArchiveCubit(ApiService()),
    child: ArchiveScreen(),
  ),
];
List<SingleChildWidget> dependentServices = [];