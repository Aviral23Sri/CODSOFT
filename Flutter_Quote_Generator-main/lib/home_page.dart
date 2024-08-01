import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services package
import 'package:quote_app/api.dart';
import 'package:quote_app/quote_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  QuoteModel? quote;
  String? errorMessage;

  @override
  void initState() {
    _fetchQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey, // Change the background color here
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Quotes",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'monospace',
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
                Text(
                  quote?.q ?? "............",
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  quote?.a ?? ".....",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                    fontFamily: 'serif',
                  ),
                ),
                const Spacer(),
                if (inProgress)
                  const CircularProgressIndicator(
                    color: Colors.white,
                  )
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _fetchQuote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Generate",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _copyQuote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Copy Quote",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fetchQuote() async {
    setState(() {
      inProgress = true;
      errorMessage = null; // Reset error message
    });
    try {
      final fetchedQuote = await Api.fetchRandomQuote();
      debugPrint(fetchedQuote.toJson().toString());
      setState(() {
        quote = fetchedQuote;
      });
    } catch (e) {
      debugPrint("Failed to generate quote: $e");
      setState(() {
        errorMessage = "Failed to generate quote. Please try again.";
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  void _copyQuote() {
    if (quote != null) {
      final text = '"${quote!.q}" - ${quote!.a}';
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quote copied to clipboard')),
      );
    }
  }
}
