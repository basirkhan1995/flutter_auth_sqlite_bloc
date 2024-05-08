import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const Button({super.key,required this.onPressed,required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *.92,
        height: 55,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ))
            ),
            onPressed: onPressed,
            child: Text(label)),
      ),
    );
  }
}
