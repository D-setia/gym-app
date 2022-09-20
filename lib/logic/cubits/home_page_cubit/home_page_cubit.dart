import 'package:bloc/bloc.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState(isEditModeActive: false));

  void toggleEditMode() =>
      emit(HomePageState(isEditModeActive: !state.isEditModeActive));
}
