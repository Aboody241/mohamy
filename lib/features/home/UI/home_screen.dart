import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamy/features/add_case/UI/pages/add_case_screen.dart';
import 'package:mohamy/features/casses_list/UI/pages/cases_list_screen.dart';
import 'package:mohamy/features/cases/controller/cubit/case_cubit.dart';
import 'package:mohamy/features/home/UI/screens/case_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the cubit instance
    final caseCubit = context.read<CaseCubit>();

    // Load cases when the screen is first built
    return BlocBuilder<CaseCubit, CaseState>(
      builder: (context, state) {
        if (state is CaseInitial) {
          caseCubit.loadCases();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Show loading indicator while loading
        if (state is CaseLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Show error message if there's an error
        if (state is CaseError) {
          return Scaffold(
            appBar: AppBar(title: const Text('إدارة القضايا')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('حدث خطأ: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => caseCubit.loadCases(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }

        // Get the list of cases or an empty list if not loaded yet
        final cases = state is CaseLoaded ? state.cases : [];

        return Scaffold(
          appBar: AppBar(
            title: const Text('إدارة القضايا'),
            centerTitle: true,
            actions: [
              IconButton(
                tooltip: 'إضافة قضية جديدة',
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddCaseScreen()),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CasesListScreen(mode: CasesListMode.edit),
                        ),
                      );
                      break;
                    case 'close':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CasesListScreen(mode: CasesListMode.close),
                        ),
                      );
                      break;
                    case 'all':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CasesListScreen(mode: CasesListMode.view),
                        ),
                      );
                      break;
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('تعديل القضايا')),
                  PopupMenuItem(value: 'close', child: Text('إقفال القضايا')),
                  PopupMenuItem(value: 'all', child: Text('عرض جميع القضايا')),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: cases.isEmpty
                ? const Center(child: Text('لا توجد قضايا مسجلة حالياً'))
                : ListView.separated(
                    itemCount: cases.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final caseItem = cases[index];
                      return _CaseTile(
                        title: caseItem.title,
                        client: caseItem.client,
                        status: caseItem.status,
                        date: caseItem.reviewDate,
                        phone: caseItem.phone,
                        details: caseItem.details,
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _CaseTile extends StatelessWidget {
  final String title;
  final String client;
  final String status;
  final String date;
  final String phone;
  final String details;

  const _CaseTile({
    required this.title,
    required this.client,
    required this.status,
    required this.date,
    required this.phone,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'مفتوحة';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title),
        subtitle: Text('العميل: $client\nتاريخ المراجعة: $date'),
        isThreeLine: true,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? Colors.green.withAlpha(26) : Colors.grey[200],
          ),
          child: Text(
            status,
            style: TextStyle(
              color: isActive ? Colors.green[700] : Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CaseDetailScreen(
                title: title,
                client: client,
                status: status,
                reviewDate: date,
                phone: phone,
                details: details,
              ),
            ),
          );
        },
      ),
    );
  }
}
