import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled36/helpers.dart';


class DialScreen extends StatefulWidget {
  const DialScreen({Key? key}) : super(key: key);

  @override
  State<DialScreen> createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {

  final textfield = TextEditingController();

  onNumberTapped(number) {
    setState(() {
      textfield.text += number;
    });
  }

  onCancelText() {
    if (textfield.text.isNotEmpty) {
      var newvalue = textfield.text.substring(0, textfield.text.length - 1);
      setState(() {
        textfield.text = newvalue;
      });
    }
  }

  Widget inputField() {
    return Container(
      color: Colors.white,
      height: 100,
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        readOnly: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        controller: textfield,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget gridView() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 60),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: [
          keyField("1", ""),
          keyField("2", "A B C"),
          keyField("3", "D E F"),
          keyField("4", "G H I"),
          keyField("5", "J K L"),
          keyField("6", "M N O"),
          keyField("7", "P Q R S"),
          keyField("8", "T U V"),
          keyField("9", "W X Y Z"),
          starField(),
          keyField("0", "+"),
          hashField(),
          blankField(),
          dialField(),
          backSpace()
        ],
      ),
    );
  }

  Widget keyField(numb, dsc) {
    return GestureDetector(
      onTap: () => onNumberTapped(numb),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numb,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              dsc,
              style:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  Widget starField() {
    return GestureDetector(
      onTap: () => onNumberTapped("*"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "*",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget hashField() {
    return GestureDetector(
      onTap: () => onNumberTapped("#"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "#",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget backSpace() {
    if (textfield.text.isNotEmpty) {
      return InkWell(
        onTap: () => onCancelText(),
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.backspace_outlined,
                size: 30,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget dialField() {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.green[500], borderRadius: BorderRadius.circular(60)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          IconButton(
            onPressed: (){
              callNumber(textfield.text.toString());
              textfield.clear();
            },
            iconSize: 40,
            color: Colors.white, icon: Icon(Icons.phone),
          )
        ],
      ),
    );
  }

  Widget blankField() {
    return InkWell(
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(60)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(children: [inputField(), gridView()]),
      ),
    );
  }
}