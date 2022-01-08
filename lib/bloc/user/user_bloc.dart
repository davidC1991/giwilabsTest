import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wigilabs_app/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  
  UserBloc() : super(UserInitialState()) {
    print(state.userAuthed);
    on<AuthenticateUser>((event, emit) {
       
    });
  
  }
}
