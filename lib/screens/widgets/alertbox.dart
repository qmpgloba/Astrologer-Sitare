import 'package:flutter/material.dart';

showAlertBox(BuildContext context,String text,Color color,String buttonText){
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // title:  Text(
            //   title,
            //   style: const TextStyle(fontSize: 18),
            // ),
            content:  Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:  Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ))
            ],
          ));
}