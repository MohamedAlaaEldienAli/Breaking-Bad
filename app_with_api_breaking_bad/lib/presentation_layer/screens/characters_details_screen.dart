import 'package:app_with_api/constants/theme.dart';
import 'package:app_with_api/data_layer/models/characters.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  // const CharactersDetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ' , character.jobs.join(' / '), ),
                      buildDividor(330),
                      characterInfo('Appeared in : ' , character.categoryForTowSeries, ),
                      buildDividor(262),
                      characterInfo('Seasins : ' , character.appearanceOfSeasons.join(' / '), ),
                      buildDividor(295),
                      characterInfo('Status : ' , character.statusIfDeadOrAlive, ),
                      buildDividor(309),

                      character.betterCallSaulappearance.isEmpty ? Container():
                      characterInfo('Better Call Saul Seasons : ' , character.betterCallSaulappearance.join(' / '), ),
                      character.betterCallSaulappearance.isEmpty ? Container():
                      buildDividor(160),

                      characterInfo('Actor/Actress : ' , character.acotrName, ),
                      buildDividor(248),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
                SizedBox(height: 300,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      elevation:0,
      pinned: true,
      stretch: true,
      backgroundColor: myColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: myColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: myColors.myWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: myColors.myWhite,
              fontSize: 16,
             
            ),
          ),
        ],
      ),
    );
  }

Widget buildDividor(double endIndent){
  return Divider(
    height: 30,
    endIndent:endIndent ,
    color: myColors.myYellow,
    thickness: 2,
  );
}
}
