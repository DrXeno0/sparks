class ForumValidationController {
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\d{11}$');
    return phoneRegex.hasMatch(phone);
  }

  bool validateName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name);
  }

  bool validateAddress(String address) {
    final addressRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
    return addressRegex.hasMatch(address);
  }

  bool validateID(String id) {
    final idRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return idRegex.hasMatch(id);
  }

  bool validateReference(String password) {
    final referenceRegex = RegExp(r'^\d{4}$');
    final referenceRegex2 = RegExp(r'^\d{3}\/\d{4}$');
    return referenceRegex.hasMatch(password) ||
        referenceRegex2.hasMatch(password);
  }

  bool validateDate(DateTime startDate, DateTime endDate) {
    return startDate.isBefore(endDate);
  }

  bool validateSupervisor(List<int> supervisors) {
    return supervisors.isNotEmpty;
  }

  bool validateDivision(String division) {
    return division.isNotEmpty;
  }

  bool validateDepartment(String department) {
    return department.isNotEmpty;
  }
}
