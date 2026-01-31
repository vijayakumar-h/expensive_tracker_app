import 'package:expensive_tracker_app/utils/common_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PrimaryButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        foregroundColor: Colors.white,
        backgroundColor: AppTheme().light.primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: kAppPadding,
          horizontal: kAppPadding * 1.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kAppBorderRadius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

