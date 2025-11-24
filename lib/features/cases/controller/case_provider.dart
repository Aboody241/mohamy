import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamy/features/cases/controller/cubit/case_cubit.dart';
import 'package:mohamy/features/cases/controller/repository/case_repository.dart';

class CaseProvider extends StatelessWidget {
  final Widget child;
  final CaseRepository repository;

  const CaseProvider({super.key, required this.child, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaseCubit(repository),
      child: child,
    );
  }

  static CaseCubit of(BuildContext context) {
    return BlocProvider.of<CaseCubit>(context);
  }
}
