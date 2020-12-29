import 'package:elevinfo/essential.dart';
import 'package:elevinfo/managers/databasehelper.dart';
import 'package:elevinfo/screens/list.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final addressController1 = TextEditingController();
  final addressController2 = TextEditingController();

  Widget textInput(TextEditingController controller, String hint) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
            color: Colors.black12,
          ),
          child: Text(
            hint,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
                fontFamily: FONT_FAMILY
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: Dimens.marginDefault),
            color: Colors.white70,
            child: TextField(
              controller: controller,
              keyboardAppearance: Config().type == LIGHT_MODE ? Brightness.light : Brightness.dark,
              style: TextStyle(
                color: Colors.black,
                fontFamily: FONT_FAMILY
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            if(controller == addressController1) {
              addressController1.text = '';
            } else {
              addressController2.text = '';
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: 42,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              color: Colors.white70,
            ),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.clear,
                size: 10,
                color: Colors.white30,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TitleScaffold(
      title: '주소로 검색',
      backSwipe: true,
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Dimens.marginDefault),
              child: Column(
                children: <Widget>[
                  textInput(addressController1, '주소'),
                  Container(
                    height: Dimens.marginTiny,
                  ),
                  textInput(addressController2, '건물명'),
                  Container(
                    height: Dimens.marginTiny,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(Dimens.marginDefault),
                child: CoreButton(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    await DatabaseHelper().addHistoryAddress(addressController1.text, addressController2.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen(
                      addressController1.text,
                      addressController2.text
                    )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '검색',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FONT_FAMILY
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
