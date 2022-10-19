import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model/search_model.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  Search(text) {
    emit(LoadingSearchState());
    DioHelper.postData(url: 'products/search', data: {'text': text})
        .then((value) {
          model = SearchModel.fromJson(value.data);
          emit(SuccessSearchState());
    })
        .catchError((error) {
          print(error);
      emit(ErrorSearchState());
    });
  }
}
