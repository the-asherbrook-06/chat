// packages
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QuotesContainer extends StatefulWidget {
  const QuotesContainer({super.key});

  @override
  State<QuotesContainer> createState() => _QuotesContainerState();
}

class _QuotesContainerState extends State<QuotesContainer> {
  Map<String, dynamic>? body;

  void getQuote() async {
    var url = Uri.https('dummyjson.com', 'quotes/random');
    var response = await http.get(url);
    setState(() {
      body = convert.jsonDecode(response.body) as Map<String, dynamic>;
    });
  }

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: body == null
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${body?['quote']}", style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 4),
                      Text("— ${body?['author']}", style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
