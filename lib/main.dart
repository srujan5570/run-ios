import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run iOS App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ClientIdScreen(),
    );
  }
}

class ClientIdScreen extends StatefulWidget {
  const ClientIdScreen({super.key});

  @override
  State<ClientIdScreen> createState() => _ClientIdScreenState();
}

class _ClientIdScreenState extends State<ClientIdScreen> {
  final TextEditingController _clientIdController = TextEditingController();
  String? _savedClientId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedClientId();
  }

  Future<void> _loadSavedClientId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedClientId = prefs.getString('client_id');
      if (_savedClientId != null) {
        _clientIdController.text = _savedClientId!;
      }
    });
  }

  Future<void> _saveClientId() async {
    if (_clientIdController.text.trim().isEmpty) {
      _showSnackBar('Please enter a Client ID');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('client_id', _clientIdController.text.trim());

      setState(() {
        _savedClientId = _clientIdController.text.trim();
        _isLoading = false;
      });

      _showSnackBar('Client ID saved successfully!');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error saving Client ID: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run iOS App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_iphone, size: 100, color: Colors.blue),
            const SizedBox(height: 30),
            const Text(
              'Enter Client ID',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _clientIdController,
              decoration: const InputDecoration(
                labelText: 'Client ID',
                hintText: 'Enter your client ID here',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveClientId,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Save Client ID',
                          style: TextStyle(fontSize: 16),
                        ),
              ),
            ),
            const SizedBox(height: 20),
            if (_savedClientId != null) ...[
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Saved Client ID:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _savedClientId!,
                  style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _clientIdController.dispose();
    super.dispose();
  }
}
