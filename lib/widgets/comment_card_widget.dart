import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class CommentCardWidget extends StatefulWidget {
  const CommentCardWidget({super.key});

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/17483910/pexels-photo-17483910/free-photo-of-abstrato-resumo-abstrair-tecnologia.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'username',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: ' description',
                          style: const TextStyle(
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '23/01/2021',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.favorite),
          )
        ],
      ),
    );
  }
}
