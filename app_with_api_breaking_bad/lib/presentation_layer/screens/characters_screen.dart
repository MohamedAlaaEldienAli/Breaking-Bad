import 'package:app_with_api/business_logic_layer/cubit/breakingbad_characters_cubit.dart';
import 'package:app_with_api/constants/theme.dart';
import 'package:app_with_api/data_layer/models/characters.dart';
import 'package:app_with_api/presentation_layer/widgets/character_itme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForcharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<BreakingbadCharactersCubit>(context).getAllCharaters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitel(), 
        leading: _isSearching ? BackButton(color: myColors.myGrey,): Container(),
        actions:  _buildAppBarActions(),
        
      ),
      body: buildBlocWidget(),
    );
  }

  Widget _buildAppBarTitel(){
    return Text(
          'Characters',
          style: TextStyle(color: myColors.myGrey),
        );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<BreakingbadCharactersCubit, BreakingbadCharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: myColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: myColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty ?  allCharacters.length : searchedForcharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty ?  allCharacters[index] :searchedForcharacters[index] ,
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: myColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a Characters...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: myColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: myColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForcharacters = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: myColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: myColors.myGrey,
            size: 29,
          ),
        )
      ];
    }
  }


  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }


  void _stopSearching(){
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }






}
