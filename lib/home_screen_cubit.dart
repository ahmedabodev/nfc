import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test_with_cubit_dio/cubit/cubit.dart';
import 'package:news_test_with_cubit_dio/cubit/states.dart';
import 'package:news_test_with_cubit_dio/shared/my_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'entertainment',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getData(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.getData();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                        separatorBuilder: (context, i) => const SizedBox(width: 5, height: 30,),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, i) {
                          return CustomButton(
                              onPressed: () {
                                cubit.getData(cat: categories[i]);
                              }, text: categories[i]);
                        }),
                  ),
                  ConditionalBuilder(
                    condition: cubit.articles.isNotEmpty,
                    fallback: (BuildContext context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    builder: (BuildContext context) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: cubit.articles.length,
                            itemBuilder: (context, i) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (cubit.articles[i]['urlToImage'] != null)
                                      Image.network(
                                          cubit.articles[i]['urlToImage'],
                                          fit: BoxFit.cover),
                                    if (cubit.articles[i]['title'] != null)
                                      Text(cubit.articles[i]['title']),
                                    if (cubit.articles[i]['author'] != null)
                                      Center(
                                          child: Text(
                                              cubit.articles[i]['author'])),
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
