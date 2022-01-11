

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/texto.dart';




class GridModeCategory extends StatelessWidget {

  final List<Category>? categories;
  GridModeCategory({this.categories});
  

  @override
  Widget build(BuildContext context) {
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: true);
    String namePage = spotifyBloc.state.statePage;
    print('inicio widget grid mode-->$namePage');
    return  this.categories==null?CircularProgressIndicator():GridView.builder(
        //reverse: true,
        itemCount: categories!.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.0,
          mainAxisExtent:190
        ),
        itemBuilder: (BuildContext context, int i){
          //print(comics[i].apiDetailUrl);
          //print(this.categoriess);
          return categoriesImage(categories![i],context,spotifyBloc,namePage);
        },);
  }
  

  
  Widget categoriesImage(Category category, BuildContext context, SpotifyBloc spotifyBloc, String namePage){
    final size = MediaQuery.of(context).size;
   
    return Container(
      width: size.width*0.25,
      height: size.height*0.05,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.center,
        mainAxisAlignment  : MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
             
              spotifyBloc.add(CleanPlayList());
              spotifyBloc.add(FetchPlayListByCategorie(category));
              Navigator.pushNamed(context, 'playList');
            
               
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(category.icons![0].url!),
                width: size.width*0.23,
                height:size.height*0.2,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: size.height*0.01),
          category.name!=null?
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child:TextoCustomedWidget(text:category.name!,size: 10.0, color:Colors.white,font: FontWeight.w800),
                      ),
                      //Text( date, style: Theme.of(context).textTheme.headline2,maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)
                    ],
                  ),
                ):Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextoCustomedWidget(text:'No Name',size: 10.0, color:Colors.white,font: FontWeight.w100),
                      //child: Text('Not Name', style: Theme.of(context).textTheme.headline1, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
                    ),
                    //Text( date, style: Theme.of(context).textTheme.headline2,maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)
                  ],
                ),
              ],
            ),
          );
        }
      }
                   
                 
                  
                  
                        
         
               
                