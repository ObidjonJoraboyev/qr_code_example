import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_example/app/app.dart';
import 'package:qr_code_example/blocs/scan_bloc.dart';
import 'package:qr_code_example/blocs/scan_event.dart';
import 'package:qr_code_example/services/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScanBloc()..add(ProductGetEvent()))
      ],
      child: const App(),
    ),
  );
}
