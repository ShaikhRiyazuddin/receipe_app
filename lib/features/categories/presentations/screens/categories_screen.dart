import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/core/constants/constant.dart';
import 'package:receipe_app/core/widget/utils.dart';
import 'package:receipe_app/features/categories/domain/entities/categories_entity.dart';
import 'package:receipe_app/features/categories/presentations/bloc/categories_cubit.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';
import 'package:receipe_app/features/meals/presentation/bloc/search/search_meals_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategoriess([]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        // iconTheme: IconThemeData(color: kSecondary),
        //  centerTitle: true,
        title: Text(
          'Receipe App',
          style: kTextStyle.copyWith(
            fontSize: 18.0,
            color: kSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: kPrimary,
      ),
      body: [
        HomeCategory(size: size),
        FavoriteScreen(),
        SearchView(
          size: size,
        )
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(
                Icons.home_filled,
                color: kIconColor,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(
                Icons.favorite,
                color: kIconColor,
              ),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(
                Icons.search,
                color: kIconColor,
              ),
              label: 'Search'),
        ],
      ),
    );
  }
}

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoriesError) {
              return Center(
                child: Text(state.error!.message!),
              );
            }
            if (state is CategoriesLoaded) {
              var exclude = ['pork', 'beef'];
              var categories = state.categories!.categories;
              categories.removeWhere(
                  (t) => exclude.contains(t.strCategory.toLowerCase()));
              return GridView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  var test = categories[index];
                  {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/ListOfMeals',
                            arguments: test);
                      },
                      child: GridItem(
                        size: size,
                        image: test.strCategoryThumb,
                        name: test.strCategory,
                      ),
                    );
                  }
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 4.0, // spacing between rows
                  crossAxisSpacing: 4.0, // spacing between columns
                ),
              );
            }
            return Container();
          }),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                  onChanged: (text) {
                    controller.text = text;
                    _debouncer.run(
                      () {
                        context.read<SearchMealsCubit>().getSearchMeals(text);
                      },
                    );
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                     controller.clear();
                    // context.read<SearchMealsCubit>().getSearchMeals('');
                  },
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            child: BlocConsumer<SearchMealsCubit, SearchMealsState>(
                listener: (context, state) {},
                builder: (BuildContext context, state) {
                  if (state is SearchMealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchMealsError) {
                    return Center(
                      child: Text(state.error!.message!),
                    );
                  }
                  if (state is SearchMealsEmpty) {
                    return Center(
                      child: Text('No Data Found'),
                    );
                  }
                  if (state is SearchMealsLoaded) {
                    var meals = state.mealModel!.meals;

                    return Container(
                      height: MediaQuery.of(context).size.height - 240,
                      child: ListView.builder(
                        itemCount: meals.length,
                        itemBuilder: (BuildContext context, int index) {
                          var test = meals[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/MealDetails',
                                  arguments: MealEntity(
                                      strMeal: test.strMeal,
                                      strMealThumb: test.strMealThumb,
                                      idMeal: test.idMeal));
                            },
                            child: ListItem(
                              size: widget.size,
                              image: test.strMealThumb,
                              name: test.strMeal,
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Box<MealEntity> favourites;
  final ValueNotifier<List<MealEntity>> _favouritesModel = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    favourites = Hive.box<MealEntity>('favourites');
    _favouritesModel.value = favourites.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Flexible(
        child: ListView.builder(
      itemCount: _favouritesModel.value.length,
      itemBuilder: (context, index) {
        var meal = _favouritesModel.value[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/MealDetails', arguments: meal);
          },
          child: ListItem(
            size: size,
            image: meal.strMealThumb,
            name: meal.strMeal,
          ),
        );
      },
    ));
  }
}
