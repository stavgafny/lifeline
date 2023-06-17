import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6363),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10.0),
          const Icon(
            Icons.error_outline,
            color: Color(0xFF373232),
            size: 28.0,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF373232),
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
