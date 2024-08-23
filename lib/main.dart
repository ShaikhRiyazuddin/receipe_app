import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:receipe_app/config/routes.dart';
import 'package:receipe_app/features/categories/presentations/bloc/categories_cubit.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meal_details/meal_details_cubit.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meals/meals_cubit.dart';
import 'package:receipe_app/features/categories/presentations/screens/categories_screen.dart';
import 'package:receipe_app/features/meals/presentation/bloc/search/search_meals_cubit.dart';
import 'package:receipe_app/injectable_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 Hive.registerAdapter(MealEntityAdapter());

  Hive.openBox<MealEntity>('favourites');
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoriesCubit(sl())),
        BlocProvider(create: (context) => MealsCubit(sl())),
        BlocProvider(create: (context) => MealDetailsCubit(sl())),
        BlocProvider(create: (context) => SearchMealsCubit(sl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        title: 'Whats on your basket',
        home: const CategoriesScreen(),
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
        ),
      ),
    );
  }
}
