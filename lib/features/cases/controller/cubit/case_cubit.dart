import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamy/features/cases/controller/models/case_model.dart';
import 'package:mohamy/features/cases/controller/repository/case_repository.dart';

// States
abstract class CaseState {}

class CaseInitial extends CaseState {}

class CaseLoading extends CaseState {}

class CaseLoaded extends CaseState {
  final List<CaseModel> cases;
  CaseLoaded(this.cases);
}

class CaseError extends CaseState {
  final String message;
  CaseError(this.message);
}

// Cubit
class CaseCubit extends Cubit<CaseState> {
  final CaseRepository _repository;

  CaseCubit(this._repository) : super(CaseInitial());

  // Load all cases
  Future<void> loadCases() async {
    try {
      emit(CaseLoading());
      final cases = await _repository.getCases();
      emit(CaseLoaded(cases));
    } catch (e) {
      emit(CaseError('Failed to load cases: $e'));
    }
  }

  // Add a new case
  Future<void> addCase(CaseModel newCase) async {
    try {
      emit(CaseLoading());
      await _repository.addCase(newCase);
      final cases = await _repository.getCases();
      emit(CaseLoaded(cases));
    } catch (e) {
      emit(CaseError('Failed to add case: $e'));
      // Re-emit the previous state to maintain consistency
      if (state is CaseLoaded) {
        emit(CaseLoaded((state as CaseLoaded).cases));
      } else {
        emit(CaseError('Failed to recover from error'));
      }
    }
  }

  // Update an existing case
  Future<void> updateCase(CaseModel updatedCase) async {
    try {
      emit(CaseLoading());
      await _repository.updateCase(updatedCase);
      final cases = await _repository.getCases();
      emit(CaseLoaded(cases));
    } catch (e) {
      emit(CaseError('Failed to update case: $e'));
      if (state is CaseLoaded) {
        emit(CaseLoaded((state as CaseLoaded).cases));
      } else {
        emit(CaseError('Failed to recover from error'));
      }
    }
  }

  // Delete a case
  Future<void> deleteCase(String caseId) async {
    try {
      emit(CaseLoading());
      await _repository.deleteCase(caseId);
      final cases = await _repository.getCases();
      emit(CaseLoaded(cases));
    } catch (e) {
      emit(CaseError('Failed to delete case: $e'));
      if (state is CaseLoaded) {
        emit(CaseLoaded((state as CaseLoaded).cases));
      } else {
        emit(CaseError('Failed to recover from error'));
      }
    }
  }
}
