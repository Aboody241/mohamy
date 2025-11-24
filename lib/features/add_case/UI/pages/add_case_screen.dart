import "package:flutter/material.dart";

class AddCaseScreen extends StatefulWidget {
  /// لو الشاشة مفتوحة بـ Navigator.push خليها true (الافتراضي)
  /// لو الشاشة جزء من Tab في BottomNavigation خليها false
  final bool popOnSave;

  const AddCaseScreen({super.key, this.popOnSave = true});

  @override
  State<AddCaseScreen> createState() => _AddCaseScreenState();
}

class _AddCaseScreenState extends State<AddCaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _caseNameController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _reviewDate;

  @override
  void dispose() {
    _caseNameController.dispose();
    _clientNameController.dispose();
    _detailsController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _reviewDate = picked;
      });
    }
  }

  void _clearForm() {
    _caseNameController.clear();
    _clientNameController.clear();
    _detailsController.clear();
    _phoneController.clear();
    setState(() {
      _reviewDate = null;
    });
  }

  void _saveCase() {
    if (!_formKey.currentState!.validate()) return;

    if (_reviewDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار موعد المتابعة')),
      );
      return;
    }

    // TODO: حفظ بيانات القضية في قاعدة البيانات أو عبر API

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تم حفظ القضية بنجاح')));

    final canPop = Navigator.of(context).canPop();
    if (widget.popOnSave && canPop) {
      // لو الشاشة مفتوحة بـ Navigator.push ارجع للخلف
      Navigator.pop(context);
      return;
    }

    // لو الشاشة جزء من Tab في البوتوم بار امسح الحقول وابقى في نفس المكان
    _clearForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة قضية جديدة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _caseNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم القضية',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'يجب إدخال اسم القضية'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _clientNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الموكل',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'تفاصيل القضية',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم التواصل (اختياري)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _reviewDate == null
                            ? 'تحديد موعد المتابعة'
                            : '${_reviewDate!.day}/${_reviewDate!.month}/${_reviewDate!.year}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: File picker للمرفقات
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text('إرفاق مستندات (اختياري)'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCase,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('حفظ القضية', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
