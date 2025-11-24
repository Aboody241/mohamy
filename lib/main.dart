import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohamy/core/styles/utils/main_shell.dart';
import 'package:mohamy/features/cases/controller/case_provider.dart';
import 'package:mohamy/features/cases/controller/repository/case_repository.dart';

void main() {
  runApp(const CaseManagerApp());
}

class CaseManagerApp extends StatelessWidget {
  const CaseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      textTheme: GoogleFonts.cairoTextTheme(),
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'إدارة القضايا',
          debugShowCheckedModeBanner: false,
          theme: baseTheme.copyWith(
            appBarTheme: baseTheme.appBarTheme.copyWith(
              centerTitle: true,
              titleTextStyle: baseTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          builder: (context, appChild) => Directionality(
            textDirection: TextDirection.rtl,
            child: CaseProvider(
              repository: CaseRepository(),
              child: appChild ?? const SizedBox.shrink(),
            ),
          ),
          home: const MainShell(),
        );
      },
    );
  }
}
