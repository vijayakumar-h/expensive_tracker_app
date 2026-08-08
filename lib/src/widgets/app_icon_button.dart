import 'package:expensive_tracker_app/common_exports.dart';

class AppIconButton extends StatelessWidget {
  final String? tooltip;
  final IconData icon;
  final VoidCallback buttonCallback;

  const AppIconButton({
    required this.icon,
    required this.buttonCallback,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppTheme().light.primaryColor;
    return Container(
      width: 36,
      height: 36,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        tooltip: tooltip,
        icon: Icon(
          icon,
          size: 24,
          color: primaryColor,
        ),
        onPressed: buttonCallback,
      ),
    );
  }
}
