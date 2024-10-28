import 'package:flutter/material.dart';
import 'package:simple_yucatec_dictionary/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:simple_yucatec_dictionary/screens/word_screen.dart';
import 'package:simple_yucatec_dictionary/helpers/entry_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double searchFontSize = 100.0;

  int modeIndex = 0;

  bool _first = true;
  bool _textFocus = false;

  List<Map> results = [];
  List<IconData> modeIcons = [
    Icons.arrow_back_ios_rounded,
    Icons.arrow_forward_ios_rounded
  ];
  List<Alignment> gradientAnimationPath = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomRight,
    Alignment.bottomLeft,
  ];
  List<double> pathTime = [
    //1, 4, 1, 4,
    4.0, 1.0, 4.0, 1.0
  ];

  final int animationSpeed = 400;
  final bool _languageSwitch = true;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 10));

    _controller.repeat();
  }

  query(String value) async {
    if ( value.length <= 1 ) {
      results = [];
      return;
    }
    List<Map<String, Object?>> res;
    String queryWord = "$value%";
    debugPrint(queryWord);
    Database db = await DbHelper.instance.database;
    res = await db.query(
        'contents',
        columns: ['Flags', 'WordYuc', 'Definition', 'Single', 'Example',
          'WordEsp', 'Categories'
        ],
        where: 'WordYuc LIKE ?',
        whereArgs: [queryWord]
    );
    setState(() {
      results = res;
    });
  }
  void switchLanguage() {
    if (!_languageSwitch) {
      return;
    }
    setState(() {
      modeIndex = 1 -modeIndex;
      _first = !_first;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 20.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: null,
            child: languageSwitchWidget(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              onTapOutside: (event){
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  _textFocus = false;
                });
              },
              onTap: (){setState(() {
                _textFocus = true;
              });},
              cursorColor: Colors.redAccent,
              showCursor: false,
              cursorWidth: 5.0,
              onChanged: (String text){
                TextPainter textPainter = TextPainter();
                double textTotalLength;
                double screenWidth;

                textPainter.text = TextSpan(text: text, style: TextStyle(fontSize: searchFontSize));
                textPainter.textDirection = TextDirection.ltr;
                textPainter.layout(minWidth: 0, maxWidth: double.infinity);
                textTotalLength = textPainter.width;
                screenWidth = MediaQuery.sizeOf(context).width;

                debugPrint(textTotalLength.toString());
                debugPrint(screenWidth.toString());

                if (textTotalLength >= screenWidth - 20)
                {
                  setState(() {
                    searchFontSize -= 3;
                  });
                }
                query(text.toLowerCase());
              },
              style: TextStyle(
                fontFamily: 'Prata',
                fontSize: searchFontSize,
              ),
              // inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: _textFocus? Colors.white : Colors.grey.shade800,
                ),
                hintText: "...",
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return entryWidget(results[index], index);
              },
            ),
          )
        ],
      ),
    );
  }
  Widget languageSwitchWidget() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return AnimatedAlign(
          alignment: _first ? Alignment.topRight: Alignment.topLeft,
          duration: Duration(milliseconds: animationSpeed + 100),
          curve: Curves.fastOutSlowIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white,
                    width: 2.0
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("ESP", style: TextStyle(fontSize: 30.0, color: Colors.white),),
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                        child: AnimatedCrossFade(
                            firstChild: const Icon(Icons.arrow_back,
                              size: 30.0, color: Colors.white,),
                            secondChild: const Icon(Icons.arrow_forward,
                              size: 30.0, color: Colors.white,),
                            crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                            duration: Duration(milliseconds: animationSpeed))
                    ),
                    const Text("YUC", style: TextStyle(fontSize: 30.0, color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget entryWidget(result, index){
    return GestureDetector(
      onTap: (){
        Entry entry;
        entry = Entry.fromMap(result);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EntryScreen(entry: entry)));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                index.toString(),
                style: const TextStyle(
                  fontFamily: 'Dosis',
                  //fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            Text(
              result['WordYuc'],
              style: const TextStyle(
                fontFamily: 'Dosis',
                //fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

