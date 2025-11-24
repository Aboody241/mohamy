import 'package:mohamy/features/cases/controller/models/case_model.dart';

class CaseRepository {
  // In a real app, this would connect to a database or API
  final List<CaseModel> _cases = [];

  // Get all cases
  Future<List<CaseModel>> getCases() async {
    // Simulate network/database delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_cases);
  }

  // Add a new case
  Future<void> addCase(CaseModel newCase) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cases.add(newCase);
  }

  // Update an existing case
  Future<void> updateCase(CaseModel updatedCase) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _cases.indexWhere((c) => c.id == updatedCase.id);
    if (index != -1) {
      _cases[index] = updatedCase;
    }
  }

  // Delete a case
  Future<void> deleteCase(String caseId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cases.removeWhere((c) => c.id == caseId);
  }
}
