import 'package:flutter/material.dart';
import 'package:simple_yucatec_dictionary/helpers/entry_class.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key, required this.entry});
  final Entry entry;
  @override
  Widget build(BuildContext context) {
    final iconCategoryList = [
      Icons.abc,
      Icons.fastfood,
      Icons.family_restroom,
      Icons.pets,
      Icons.local_drink,
      Icons.forest,
      Icons.emoji_emotions,
      Icons.account_tree,
      Icons.speaker_notes,
      Icons.nightlife_rounded,
      Icons.directions_run,
      Icons.nightlight_round_sharp,
      Icons.hotel_class,
      Icons.sign_language_sharp,
      Icons.cloud,
      Icons.place,
      Icons.bug_report,
      Icons.smartphone,
      Icons.format_shapes,
      Icons.rectangle,
      Icons.note,
      Icons.local_hospital,
      Icons.back_hand_rounded,
      Icons.access_time,
      Icons.accessibility,
      Icons.people,
      Icons.work,
      Icons.church,
      Icons.landscape,
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("U Le' K'óopte'", style: Theme.of(context).textTheme.headline1,),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 13.0),
                    child: Text(entry.yucatecWord, // PALABRA MAYOR
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                        fontFamily: 'FreeSerif',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    for(var i in entry.categories)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: Icon(
                            iconCategoryList[i],
                            color: const Color(0xff447821),
                            size: 45.0,
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              color: Colors.white10,
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 30.0),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    definitionWidget(entry.definition[index], index),
                itemCount: entry.definition.length,
              ),
            ),
          ),
          Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                color: Colors.white30,
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: entry.example.isNotEmpty?
                ListView.builder(itemBuilder: (context, index) =>
                    exampleWidget(entry.example[index], entry.exampleTranslation[index]),
                  itemCount: entry.example.length,) : noExampleWidget(),
              )
          ),
        ],
      ),
    );
  }
  Widget definitionWidget(definition, index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Text((index + 1).toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Text(definition + '.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        ),
      ],
    );
  }
  Widget noExampleWidget() {
    return const Text("No hay ejemplos");
  }
  Widget exampleWidget(exampleNative, exampleTranslation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exampleNative,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(exampleTranslation,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
