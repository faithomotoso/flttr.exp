import 'dart:developer';

import 'package:async/async.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flttr_exp/core/repository/dio_repository.dart';
import 'package:flttr_exp/core/repository/http_repository.dart';
import 'package:flttr_exp/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CancelHttpPage extends StatefulWidget {
  static const String routeName = "cancel-http";

  const CancelHttpPage({super.key});

  @override
  State<CancelHttpPage> createState() => _CancelHttpPageState();
}

class _CancelHttpPageState extends State<CancelHttpPage> {
  final ValueNotifier<bool> fetchingNotifier = ValueNotifier(false);
  final Client client = HttpRepository.instance.client;
  final dio.Dio dioClient = DioRepository.instance.dio;
  final String url = "https://jsonplaceholder.typicode.com/posts";
  late final Uri uri;
  final ValueNotifier<String?> httpStrResponseNotifier = ValueNotifier(null);

  CancelableOperation<Response>? httpCancelable;
  dio.CancelToken? cancelToken = dio.CancelToken();

  @override
  void initState() {
    super.initState();

    uri = Uri.parse(url);
  }

  @override
  void dispose() {
    fetchingNotifier.dispose();
    httpStrResponseNotifier.dispose();

    // Doing this closes the client making it unusable, useful for single page clients like this
    // would close all requests too, not specific requests
    // client.close();

    // Surprisingly doesn't work as the api call still completes, not sure the use-case of a cancelable op
    httpCancelable?.cancel().then((v) {
      print("Cancel called: $v");
    });

    // Works
    cancelToken?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancel Http"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: CustomButton(
                  buttonText: "http",
                  onTap: _withHttp,
                ),
              ),
              Expanded(
                child: CustomButton(
                  buttonText: "dio",
                  onTap: _withDio,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ValueListenableBuilder(
              valueListenable: fetchingNotifier,
              builder: (ctx, fetching, _) {
                if (fetching) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              }),
          ListenableBuilder(
              listenable:
                  Listenable.merge([fetchingNotifier, httpStrResponseNotifier]),
              builder: (ctx, child) {
                if (!fetchingNotifier.value &&
                    (httpStrResponseNotifier.value ?? "").isNotEmpty) {
                  return Text(httpStrResponseNotifier.value!);
                }

                return const SizedBox();
              })
        ],
      ),
    );
  }

  Future<void> _withHttp() async {
    if (fetchingNotifier.value) {
      return;
    }

    try {
      httpStrResponseNotifier.value = null;
      fetchingNotifier.value = true;

      httpCancelable = CancelableOperation.fromFuture(client.get(uri));

      Response response = await httpCancelable!.value;

      if (response.statusCode == 200 && mounted) {
        print("Done fetching http: ${response.body}");
        httpStrResponseNotifier.value = response.body;
      }
    } finally {
      fetchingNotifier.value = false;
    }
  }

  Future<void> _withDio() async {
    if (fetchingNotifier.value) {
      return;
    }

    try {
      fetchingNotifier.value = true;
      httpStrResponseNotifier.value = null;

      dio.Response resp = await dioClient.get(url, cancelToken: cancelToken);

      print("Fetched data with dio: ${resp.data.toString()}");

      if (mounted) {
        httpStrResponseNotifier.value = resp.data.toString();
        fetchingNotifier.value = false;
      }
    } finally {
      if (mounted) {
        fetchingNotifier.value = false;
      }
    }
  }
}
