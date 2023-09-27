import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:sound_cat/bloc/sound_cat_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SoundCatBloc()..add(const GetWaterParamsEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  bool _isRecording = false;
  int? noiseThresHold;
  double? maxDB;
  double? meanDB;

  @override
  void initState() {
    super.initState();
    _noiseMeter = NoiseMeter();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!_isRecording) _isRecording = true;
    });
    maxDB = noiseReading.maxDecibel;
    meanDB = noiseReading.meanDecibel;
    if (noiseThresHold != null && maxDB! > noiseThresHold!) {
      stop();
    }
  }

  void onError(Object e) {
    print(e.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      context.read<SoundCatBloc>().add(const NotifyStartSoundCatEvent());
      _noiseSubscription = _noiseMeter.noise.listen(onData);
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    try {
      _noiseSubscription!.cancel();
      _noiseSubscription = null;
      context.read<SoundCatBloc>().add(const NotifySignalGoEvent());
      // context.read<SoundCatBloc>().add(const CheckPreConditionEvent());
      setState(() => _isRecording = false);
    } catch (e) {
      print('stopRecorder error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<SoundCatBloc, SoundCatState>(
        listener: (context, state) {
          print('listener');
          if (state.isPrecheck && !_isRecording) {
            start();
          }
        },
        listenWhen: (previous, current) {
          return previous.isPrecheck != current.isPrecheck;
        },
        builder: (context, state) {
          final status = state.status;
          final raceNo = state.raceNo;
          noiseThresHold = state.waterParam?.noiceThreshold;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$status',
                  style: const TextStyle(fontSize: 23),
                ),
                if (raceNo != null)
                  Text(
                    'RanNow: $raceNo',
                    style: const TextStyle(fontSize: 23),
                  ),
                Text(
                  'NoiceThreshold: $noiseThresHold',
                  style: const TextStyle(fontSize: 23),
                ),
                if (_isRecording)
                  Column(
                    children: [
                      Text(
                        'Noise db: $maxDB',
                        style: const TextStyle(fontSize: 23),
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
