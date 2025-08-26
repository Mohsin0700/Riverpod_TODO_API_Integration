// File: lib/src/utils/validators.dart
/// Common small validators used across the app.
/// Return null when the value is valid, otherwise return a String error message.

String? nonEmpty(String? v) =>
    (v == null || v.trim().isEmpty) ? 'Required' : null;

String? minLength(String? v, int min) {
  if (v == null) return 'Required';
  return v.trim().length < min ? 'Minimum $min characters required' : null;
}

String? maxLength(String? v, int max) {
  if (v == null) return null;
  return v.trim().length > max ? 'Maximum $max characters allowed' : null;
}

String? email(String? v) {
  if (v == null || v.trim().isEmpty) return 'Required';
  final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final reg = RegExp(pattern);
  return reg.hasMatch(v.trim()) ? null : 'Invalid email address';
}

// Small helper to validate optional fields (returns null for empty)
String? optionalMaxLength(String? v, int max) {
  if (v == null || v.trim().isEmpty) return null;
  return v.trim().length > max ? 'Maximum $max characters allowed' : null;
}
