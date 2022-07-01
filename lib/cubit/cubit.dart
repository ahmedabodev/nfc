import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test_with_cubit_dio/cubit/news_models.dart';
import 'package:news_test_with_cubit_dio/cubit/states.dart';
import 'package:news_test_with_cubit_dio/shared/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialAppStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> articles = [];

  //top-headlines?country=${con}&category=${Cat}&apiKey=c9490d45393f4ff6b93ea9804d51a788
  void getData({String con = 'eg', String cat = 'general'}) {
    emit(LoadingStates());
    DioHelper.getData(
            url:
                'top-headlines?country=$con&category=$cat&apiKey=c9490d45393f4ff6b93ea9804d51a788')
        .then((value) {
      articles = value.data['articles'];
      if (kDebugMode) {
        print(value.data);
      }
      //print(value.data['articles']);
      emit(SuccessStates());
    }).catchError((error) {
      emit(ErrorStates(error: error.toString()));
    });
  }
}
