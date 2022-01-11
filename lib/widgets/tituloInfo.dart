import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/widgets.dart';

// ignore: must_be_immutable
class TituloInfo extends StatelessWidget {
  String texto;
  Size size;
  String? route;
  String? namePage;
  bool isCountryChose;
  TituloInfo({ required this.texto, required this.size, this.route, this.namePage, required this.isCountryChose});

  @override
  Widget build(BuildContext context) {
   
    return Container(
          alignment: Alignment.topLeft,
          margin : EdgeInsets.only(top: 10, bottom: 15),
          width  : this.size.width * 1,
          height : this.size.height * 0.07,
          color  : Colors.grey.withOpacity(0.2),
          child  : this.isCountryChose?ListTile(
                  leading  : TextoCustomedWidget(text:texto,size: 18.0, color:Colors.white,font: FontWeight.w100, align: TextAlign.center),
                  trailing: this.isCountryChose?choseCountry(size, context):Text(''),
         ):ListTile(
                  title  : TextoCustomedWidget(text:texto,size: 18.0, color:Colors.white,font: FontWeight.w100, align: TextAlign.center),
                  trailing: this.isCountryChose?choseCountry(size, context):Text(''),
         )
      );
    }

    Widget choseCountry(Size size, BuildContext context) {
      final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: false);
      return  Container(
        alignment: Alignment.centerLeft,
              height: size.height *0.04,
              width: size.width*0.25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  IconButton(
                    onPressed: (){
                     spotifyBloc.add(ChangeCountry(countryState:'CO')); 
                     spotifyBloc.add(Fetchcategories('CO')); 
                    },
                    icon: TextoCustomedWidget(text:'COL',size: 16.0, color:spotifyBloc.state.countryState=='CO'?Colors.blue:Colors.grey,font: FontWeight.w900, align: TextAlign.center),
                  ),
                  //Text('List', style: Theme.of(context).textTheme.headline1),
                  IconButton(
                    onPressed: (){
                     spotifyBloc.add(ChangeCountry(countryState:'DE'));
                     spotifyBloc.add(Fetchcategories('DE')); 
                    },
                    icon: TextoCustomedWidget(text:'GER',size: 16.0, color:spotifyBloc.state.countryState=='DE'?Colors.blue:Colors.grey,font: FontWeight.w900, align: TextAlign.center),
                  ),
                  //Text('Grid', style: Theme.of(context).textTheme.headline1),
                ]
              ),
            
          );
    }
  }
