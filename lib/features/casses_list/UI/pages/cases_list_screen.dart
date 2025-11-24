import 'package:flutter/material.dart';

enum CasesListMode { view, edit, close }

class CasesListScreen extends StatelessWidget {
  final CasesListMode mode;

  const CasesListScreen({super.key, required this.mode});

  String get _title {
    switch (mode) {
      case CasesListMode.edit:
        return 'تعديل القضايا';
      case CasesListMode.close:
        return 'إقفال القضايا';
      case CasesListMode.view:
        return 'عرض القضايا';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dummyCases = [
      {'name': 'قضية عقد إيجار', 'client': 'محمد أحمد', 'status': 'مفتوحة'},
      {'name': 'قضية مطالبة مالية', 'client': 'سارة علي', 'status': 'قيد المراجعة'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'ابحث باسم القضية أو العميل',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: dummyCases.length,
                separatorBuilder: (context, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final c = dummyCases[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(c['name'] as String),
                      subtitle: Text('العميل: ${c['client']}'),
                      trailing: Text(
                        c['status'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (c['status'] == 'مفتوحة')
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      onTap: () {
                        if (mode == CasesListMode.edit) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('فتح شاشة التعديل قريباً'),
                            ),
                          );
                        } else if (mode == CasesListMode.close) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تنبيه إقفال القضية قريباً'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('عرض تفاصيل القضية قريباً'),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
