import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CaseDetailScreen extends StatelessWidget {
  final String title;
  final String client;
  final String status;
  final String reviewDate;
  final String phone;
  final String details;

  const CaseDetailScreen({
    super.key,
    required this.title,
    required this.client,
    required this.status,
    required this.reviewDate,
    required this.phone,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'مفتوحة';
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل القضية')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _InfoTile(label: 'اسم القضية', value: title),
            Gap(7.h),
            _InfoTile(label: 'اسم الموكل', value: client),
            Gap(7.h),

            _InfoTile(label: 'تاريخ المراجعة', value: reviewDate),
            Gap(7.h),

            _InfoTile(label: 'رقم التواصل', value: phone),
            Gap(7.h),

            _InfoTile(
              label: 'الحالة',
              value: status,
              valueColor: isActive ? Colors.green[700] : Colors.grey[700],
            ),
            const SizedBox(height: 12),
            const Text(
              'تفاصيل القضية',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(details),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: الانتقال لواجهة تعديل القضية
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      'تعديل',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color?>(
                        Colors.blue,
                      ), // Replace with your color
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      'إنهاء القضية',
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color?>(
                        Colors.redAccent,
                      ), // Replace with your color
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoTile({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }
}
