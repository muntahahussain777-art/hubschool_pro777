import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

class AddStudentScreen extends ConsumerStatefulWidget {
  final Student? student;
  const AddStudentScreen({super.key, this.student});

  @override
  ConsumerState<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends ConsumerState<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _fatherCtrl = TextEditingController();
  final _admNoCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _prevSchoolCtrl = TextEditingController();
  DateTime? _dob;
  int? _selectedClassId;
  String? _gender; // 'male' or 'female'
  bool _saving = false;
  List<Classroom> _classes = [];

  @override
  void initState() {
    super.initState();
    _loadClasses();
    if (widget.student != null) {
      final s = widget.student!;
      _nameCtrl.text = s.fullName;
      _fatherCtrl.text = s.fatherName;
      _admNoCtrl.text = s.admissionNo;
      _phoneCtrl.text = s.phone ?? '';
      _addressCtrl.text = s.address ?? '';
      _feeCtrl.text = s.monthlyFee > 0 ? (s.monthlyFee ~/ 100).toString() : '';
      _prevSchoolCtrl.text = s.previousSchool ?? '';
      _dob = s.dob;
      _selectedClassId = s.classroomId;
      _gender = s.gender;
    }
  }

  Future<void> _loadClasses() async {
    final dao = ref.read(settingsDaoProvider);
    final list = await dao.getAllClassrooms();
    setState(() => _classes = list);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _fatherCtrl.dispose();
    _admNoCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _feeCtrl.dispose();
    _prevSchoolCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final dao = ref.read(studentsDaoProvider);
      final fee = int.tryParse(_feeCtrl.text.trim()) ?? 0;

      if (widget.student != null) {
        await dao.updateStudent(widget.student!.toCompanion(true).copyWith(
          fullName: Value(_nameCtrl.text.trim()),
          fatherName: Value(_fatherCtrl.text.trim()),
          admissionNo: Value(_admNoCtrl.text.trim()),
          phone: Value(_phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim()),
          address: Value(_addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim()),
          dob: Value(_dob),
          classroomId: Value(_selectedClassId),
          monthlyFee: Value(fee * 100),
          previousSchool: Value(_prevSchoolCtrl.text.trim().isEmpty ? null : _prevSchoolCtrl.text.trim()),
          gender: Value(_gender),
        ));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student updated!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
          context.pop();
        }
      } else {
        final qrToken = const Uuid().v4();
        await dao.insertStudent(StudentsCompanion.insert(
          fullName: _nameCtrl.text.trim(),
          fatherName: _fatherCtrl.text.trim(),
          admissionNo: _admNoCtrl.text.trim(),
          qrToken: qrToken,
          phone: Value(_phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim()),
          address: Value(_addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim()),
          dob: Value(_dob),
          classroomId: Value(_selectedClassId),
          monthlyFee: Value(fee * 100),
          previousSchool: Value(_prevSchoolCtrl.text.trim().isEmpty ? null : _prevSchoolCtrl.text.trim()),
          gender: Value(_gender),
        ));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student added!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
          context.pop();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error, behavior: SnackBarBehavior.floating));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.student != null ? 'Edit Student' : 'New Admission')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.person_add_rounded, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            _field('Full Name *', _nameCtrl, Icons.person_rounded, required: true),
            const SizedBox(height: 12),
            _field('Father\'s Name *', _fatherCtrl, Icons.family_restroom_rounded, required: true),
            const SizedBox(height: 12),
            _field('Admission No *', _admNoCtrl, Icons.badge_rounded, required: true),
            const SizedBox(height: 12),
            _genderDropdown(),
            const SizedBox(height: 12),

            // Class Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _selectedClassId,
                  isExpanded: true,
                  dropdownColor: AppColors.card,
                  hint: const Row(children: [
                    Icon(Icons.class_rounded, color: AppColors.primary, size: 20),
                    SizedBox(width: 12),
                    Text('Select Class', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                  ]),
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  items: _classes.map((c) => DropdownMenuItem(value: c.id, child: Text('${c.name} - ${c.section}'))).toList(),
                  onChanged: (v) => setState(() => _selectedClassId = v),
                ),
              ),
            ),
            const SizedBox(height: 12),

            _field('Monthly Fee (Rs)', _feeCtrl, Icons.payments_rounded, keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            _field('Phone Number', _phoneCtrl, Icons.phone_rounded, keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            _field('Previous School', _prevSchoolCtrl, Icons.history_edu_rounded),
            const SizedBox(height: 12),
            _field('Address', _addressCtrl, Icons.location_on_rounded, maxLines: 2),
            const SizedBox(height: 12),

            GestureDetector(
              onTap: _pickDob,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
                child: Row(children: [
                  const Icon(Icons.cake_rounded, color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    _dob == null ? 'Date of Birth (optional)' : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                    style: TextStyle(color: _dob == null ? AppColors.textMuted : AppColors.textPrimary, fontSize: 13),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(widget.student != null ? 'Update Student' : 'Save Student'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, IconData icon, {bool required = false, TextInputType? keyboardType, int maxLines = 1}) {
    return TextFormField(
      controller: ctrl, keyboardType: keyboardType, maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, color: AppColors.primary, size: 20)),
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? '$label required' : null : null,
    );
  }

  Widget _genderDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _gender,
          isExpanded: true,
          dropdownColor: AppColors.card,
          hint: const Row(children: [
            Icon(Icons.wc_rounded, color: AppColors.primary, size: 20),
            SizedBox(width: 12),
            Text('Gender (Male/Female)', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ]),
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
          items: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onChanged: (v) => setState(() => _gender = v),
        ),
      ),
    );
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context, initialDate: DateTime(2010), firstDate: DateTime(1990), lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!),
    );
    if (picked != null) setState(() => _dob = picked);
  }
}
