import 'package:expensive_tracker_app/common_exports.dart';

class AppIconButton extends StatelessWidget {
  final String? tooltip;
  final IconData icon;
  final double? containerSize;
  final double? iconSize;
  final Color? color;
  final VoidCallback? buttonCallback;

  const AppIconButton({
    required this.icon,
    this.buttonCallback,
    this.containerSize,
    this.iconSize,
    this.tooltip,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = color ?? AppTheme().light.primaryColor;
    return Container(
      width: containerSize ?? 36,
      height: containerSize ?? 36,
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
          size: iconSize ?? 24,
          color: primaryColor,
        ),
        onPressed: () {
          if (buttonCallback != null) {
            buttonCallback?.call();
          }
        },
      ),
    );
  }
}
