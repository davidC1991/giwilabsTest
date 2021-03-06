import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wigilabs_app/models/apiWigiLab_model.dart';
import 'package:wigilabs_app/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  
  UserBloc() : super(UserInitialState()) {
       
    on<AuthenticateUser>((event, emit) {
       if( !state.isUserAuthed!) return;
       emit( UserSetState( event.user));
    });

    on<FetchDataWigiLab>((event, emit) {
      emit( UserWigiLabState( event.wigilabUser, event.user));
    });

    on<SignUPWithEmail>((event, emit) {
      emit(state.copyWith(password: event.password, email: event.email));
    });

    on<UserRegisteredEmail>((event, emit) {
      emit(state.copyWith(isRegisteredEmail: event.userRegistered));  
    });

    on<ResetUser>((event, emit){
      emit(state.copyWith(isUserAuthed: false, userModel: null,userWigiLab: null,password: null,email: null,name: null, isRegisteredEmail: false));
    });
  
  }
}
