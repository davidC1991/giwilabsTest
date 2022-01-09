

import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/widgets/texto.dart';




class GridMode extends StatelessWidget {

  final List<Category>? categories;
  const GridMode({this.categories});


  @override
  Widget build(BuildContext context) {
   
  
    return  this.categories!.isEmpty?CircularProgressIndicator():GridView.builder(
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
          //print(this.categories);
          return comicimage(categories![i],context);
        },);
  }
  

  
  Widget comicimage(Category categorie, BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.25,
      height: size.height*0.05,
      child: Column(
        crossAxisAlignment : CrossAxisAlignment.center,
        mainAxisAlignment  : MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, 'details', arguments: comic.apiDetailUrl);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage(categorie.icons![0].url as String),
                width: size.width*0.23,
                height:size.height*0.2,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: size.height*0.01),
          categorie.name!=null?
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child:TextoCustomedWidget(text:categorie.name!,size: 10.0, color:Colors.black,font: FontWeight.w800),
                      ),
                      //Text( date, style: Theme.of(context).textTheme.headline2,maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)
                    ],
                  ),
                ):Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextoCustomedWidget(text:'No Name',size: 10.0, color:Colors.black,font: FontWeight.w100),
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
                        
         
               
                