import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/core/constants/constant.dart';
import 'package:receipe_app/core/widget/utils.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_details_entity.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meal_details/meal_details_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:receipe_app/features/categories/presentations/bloc/meal_details/meal_details_cubit.dart';

class MealsDetails extends StatefulWidget {
  final MealEntity mealEntity;
  const MealsDetails({super.key, required this.mealEntity});

  @override
  State<MealsDetails> createState() => _MealsDetailsState();
}

class _MealsDetailsState extends State<MealsDetails> {
  late Box<MealEntity> favourites;
  final ValueNotifier<MealEntity?> _favouritesModel = ValueNotifier(null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favourites = Hive.box<MealEntity>('favourites');
    context.read<MealDetailsCubit>().getMealsById(widget.mealEntity.idMeal);
    checkIfAlreadyfavourites();
  }

  checkIfAlreadyfavourites() {
    _favouritesModel.value = favourites.get(widget.mealEntity.idMeal);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealEntity.strMeal),
      ),
      body: Column(
        children: [
          BlocConsumer<MealDetailsCubit, MealDetailsState>(
              listener: (context, state) {},
              builder: (BuildContext context, state) {
                return Expanded(child: _buildBody(state));
              }),
        ],
      ),
    );
  }

  _buildBody(MealDetailsState state) {
    if (state is MealDetailsLoaded) {
      var lead = state.mealModel!.meals[0];
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                child: ValueListenableBuilder(
                    valueListenable: _favouritesModel,
                    builder: (c, m, W) {
                      return Stack(
                        children: [
                          Image.network(
                            lead.strMealThumb,
                            height: 300,
                            width: double.infinity,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(right: 30, bottom: 20),
                            height: 300,
                            child: CustomFavButton(
                              isFavorate: _favouritesModel.value != null,
                              onPress: (b) async {
                                if (b) {
                                  await favourites.put(widget.mealEntity.idMeal,
                                      widget.mealEntity);
                                } else {
                                  await favourites
                                      .delete(widget.mealEntity.idMeal);
                                }
                                checkIfAlreadyfavourites();
                              },
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 10),

              // Tags
              lead.strTags?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: lead.strTags!
                          .split(',')
                          .map(
                            (e) => Chip(
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    ),
              const SizedBox(height: 10),

              // Category
              Text(
                "Category: ${lead.strCategory}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Area
              Text(
                "Area: ${lead.strArea}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Youtube link
              lead.strYoutube == null
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            launchUrlString(lead.strYoutube ?? '');
                          },
                          child: Text(
                            'Watch on YouTube',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),

              // Ingredients
              DataTable(
                dividerThickness: 2.0,
                // every second row is grey
                headingRowColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
                columnSpacing: 0,
                dataRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.08);
                    }
                    return Colors.grey.withOpacity(0.2);
                  },
                ),
                dataRowHeight: 60,
                columns: const [
                  DataColumn(label: Text('Preview')),
                  DataColumn(label: Text('Ingredient')),
                  DataColumn(label: Text('Measure')),
                ],
                rows: lead.ingredients
                    .where((w) => w.ingredient.isNotEmpty)
                    .map((Ingredients entry) {
                  final ingredient = entry.ingredient;
                  final String measure = entry.measure;
                  return DataRow(
                    cells: [
                      DataCell(Container(
                          width: 60,
                          height: 60,
                          child: Image.network(
                              '$ingredientUrl$ingredient-small.png'))),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(ingredient),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(measure),
                      )),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              // Instructions, each sentence is a step is more than 6 characters
              Stepper(
                physics: const NeverScrollableScrollPhysics(),
                steps: lead.strInstructions!
                    .split('.\r\n')
                   .where((element) => element.length > 5)
                    .map(
                      (e) => Step(
                        title: Text(e.replaceAll('\r\n', '.')),
                        isActive: true,
                        content: const SizedBox.shrink(),
                      ),
                    )
                    .toList(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return const Row();
                },
              ),
            ],
          ),
        ),
      );
    } else if (state is MealDetailsError) {
      return Center(
        child: Text(state.error!.message ?? ''),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
