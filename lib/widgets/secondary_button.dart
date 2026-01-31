import 'package:expensive_tracker_app/utils/common_exports.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        foregroundColor: AppTheme().light.primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: kAppPadding,
          horizontal: kAppPadding * 1.1,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2),
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