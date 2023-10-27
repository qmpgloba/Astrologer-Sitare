import 'dart:convert';

import 'package:http/http.dart' as http;

void makeCknowlarityCall(String customerNumber,String astrologerNumber) async {
  const String apiKey = 'qRwE4Ugq4C3XJfNlUWUkl3CpwZ77ryWradPalKfY';
  const String authorizationToken = '49ca7a02-897e-4b45-a78e-004590717f2b';
  const String apiUrl = 'https://kpi.knowlarity.com/Basic/v1/account/call/makecall';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': authorizationToken,
    'x-api-key': apiKey,
  };

  final Map<String, dynamic> requestBody = {
    'k_number': '+917303429701',
    'agent_number': astrologerNumber,
    'customer_number': customerNumber,
    'caller_id': '+917303429701',
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print('Cknowlarity call successful');
      print('Response: $responseJson');
    } else {
      print('Failed to make Cknowlarity call. Error: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Failed to make Cknowlarity call. Error: $e');
  }
}
