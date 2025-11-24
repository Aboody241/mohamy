import 'package:flutter/material.dart';
import 'package:mohamy/features/add_case/UI/pages/add_case_screen.dart';
import 'package:mohamy/features/casses_list/UI/pages/cases_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyCases = [
      {
        'name': 'قضية عقد إيجار',
        'client': 'محمد علي',
        'status': 'مفتوحة',
        'date': '2025-11-25',
      },
      {
        'name': 'قضية مطالبة مالية',
        'client': 'سارة حسن',
        'status': 'قيد المراجعة',
        'date': '2025-11-20',
      },
    ];

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
        child: dummyCases.isEmpty
            ? const Center(child: Text('لا توجد قضايا مسجلة حالياً'))
            : ListView.separated(
                itemCount: dummyCases.length,
                separatorBuilder: (context, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final c = dummyCases[index];
                  return _CaseTile(
                    title: c['name'] as String,
                    client: c['client'] as String,
                    status: c['status'] as String,
                    date: c['date'] as String,
                  );
                },
              ),
      ),
    );
  }
}

class _CaseTile extends StatelessWidget {
  final String title;
  final String client;
  final String status;
  final String date;

  const _CaseTile({
    required this.title,
    required this.client,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'مفتوحة';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title),
        subtitle: Text('العميل: $client\nتاريخ المتابعة: $date'),
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
          // يمكن هنا إضافة الانتقال لتفاصيل القضية
        },
      ),
    );
  }
}
