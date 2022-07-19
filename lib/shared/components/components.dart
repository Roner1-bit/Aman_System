
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




// MaterialColor buildMaterialColor(Color color) {
//   List strengths = <double>[.05];
//   Map<int, Color> swatch = {};
//   final int r = color.red, g = color.green, b = color.blue;
//
//   for (int i = 1; i < 10; i++) {
//     strengths.add(0.1 * i);
//   }
//   strengths.forEach((strength) {
//     final double ds = 0.5 - strength;
//     swatch[(strength * 1000).round()] = Color.fromRGBO(
//       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//       1,
//     );
//   });
//   return MaterialColor(color.value, swatch);
// }



//const backgroundColor= Color.fromRGBO(64, 64, 64, 1.0);
const backgroundColor=Colors.pink;
const bodyBackGround= Colors.grey;
const textColor= Colors.black;
const titleColor = Colors.black;


const primarySwatch= Colors.red;
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function submitFunction,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed:(){
          submitFunction();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType textType,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textType,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s){
        onSubmit!(s);
      },
      onChanged: (s){
        onChange!(s);
      },
      onTap:(){
        onTap!();
    },
      validator:(s) {
        validate(s);
        return null;
      },
        decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed:(){
            suffixPressed!();
          },
            icon: Icon(
            suffix,
            ),

        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

int previousSteps=0;

void showToast({
  required String text,
  required bool success,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: success? Colors.green:Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
















// Widget imageCreator(int index) {
//   return Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: GestureDetector(
//           onTap: (){
//             eatenFood.add(foodObjects[index]);
//             showToast(text: "Added ${foodNames[index]} to food calculator", success: true);
//           },
//           child: Visibility(
//             visible: true,
//             child: AnimatedContainer(
//               alignment: Alignment.center,
//               duration: const Duration(seconds: 1),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: Image.network(
//                   foodObjects[index].imageUrl,
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//           alignment: Alignment.topLeft,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Text(
//               foodObjects[index].foodName,
//               style: const TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.0,
//               ),
//             ),
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//             alignment: Alignment.topLeft,
//             child: Text(
//               foodObjects[index].calories,
//               style: const TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.0,
//               ),
//             )),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//             alignment: Alignment.topLeft,
//             child: Text(
//               foodObjects[index].serving,
//               style: const TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15.0,
//               ),
//             )),
//       ),
//     ],
//   );
// }
















// Widget defaultFormField({
//   required TextEditingController controller,
//   required TextInputType type,
//   required VoidCallback onSubmit(String),
//   required VoidCallback onChange,
//   required Function onTap,
//   bool isPassword = false,
//   required Function validate,
//   required String label,
//   required IconData prefix,
//   IconData? suffix,
//   required Function suffixPressed,
//   bool isClickable = true,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       obscureText: isPassword,
//       enabled: isClickable,
//       onFieldSubmitted: onSubmit,
//       onChanged: onChange,
//       onTap: onTap,
//       validator: validate,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(
//           prefix,
//         ),
//         suffixIcon: suffix != null
//             ? IconButton(
//           onPressed: suffixPressed,
//           icon: Icon(
//             suffix,
//           ),
//         )
//             : null,
//         border: OutlineInputBorder(),
//       ),
//     );