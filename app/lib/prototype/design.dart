import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract final class Design {
  static const background = Color(0xff121214);
  static const acousticBackground = Color(0xff121212);
  static const surface = Color(0xff1e1e22);
  static const acousticSurface = Color(0xff1c1c1e);
  static const border = Color(0xff38383a);
  static const muted = Color(0xff8e8e93);
  static const acousticMuted = Color(0xff9a9a9f);
  static const purple = Color(0xff7b2fbe);
  static const magenta = Color(0xffcb30e0);
  static const green = Color(0xff34c759);
  static const yellow = Color(0xffffcc00);
  static const red = Color(0xffff383c);
  static const blue = Color(0xff0088ff);
  static TextStyle text(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
  }) => TextStyle(
    fontFamily: 'Inter',
    letterSpacing: 0,
    wordSpacing: 0,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height ?? 1.2,
  );
}

class FigmaAsset extends StatelessWidget {
  const FigmaAsset(
    this.file, {
    super.key,
    this.size = 22,
    this.width,
    this.height,
    this.color,
  });
  final String file;
  final double size;
  final double? width, height;
  final Color? color;
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/figma/$file',
    width: width ?? size,
    height: height ?? size,
    fit: BoxFit.contain,
    excludeFromSemantics: true,
    colorFilter: color == null
        ? null
        : ColorFilter.mode(color!, BlendMode.srcIn),
  );
}

class TapTarget extends StatelessWidget {
  const TapTarget({
    super.key,
    required this.label,
    required this.onTap,
    required this.child,
    this.selected,
  });
  final String label;
  final VoidCallback? onTap;
  final Widget child;
  final bool? selected;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    selected: selected,
    child: Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    ),
  );
}

class DemoButton extends StatelessWidget {
  const DemoButton(
    this.label, {
    super.key,
    required this.onPressed,
    this.blue = false,
    this.destructive = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool blue, destructive;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 51,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: destructive
            ? Colors.transparent
            : blue
            ? Design.blue
            : Design.purple,
        foregroundColor: destructive ? Design.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(blue ? 100 : 12),
          side: destructive
              ? const BorderSide(color: Design.red)
              : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        textStyle: Design.text(
          blue ? 18 : 16,
          weight: blue ? FontWeight.w500 : FontWeight.w700,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}

class DemoCard extends StatelessWidget {
  const DemoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 16,
    this.bordered = false,
    this.acoustic = false,
    this.height,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool bordered, acoustic;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: height,
      padding: bordered
          ? padding.resolve(Directionality.of(context)) -
                const EdgeInsets.all(1)
          : padding,
      decoration: BoxDecoration(
        color: dark
            ? acoustic
                  ? Design.acousticSurface
                  : Design.surface
            : const Color(0xfff0edf4),
        borderRadius: BorderRadius.circular(radius),
        border: bordered
            ? Border.all(color: dark ? Design.border : const Color(0xffd5cfdc))
            : null,
      ),
      child: child,
    );
  }
}

class DemoSegments extends StatelessWidget {
  const DemoSegments({
    super.key,
    required this.labels,
    required this.selected,
    required this.onChanged,
  });
  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => Container(
    height: 50,
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? Design.acousticSurface
          : const Color(0xffe7e2eb),
      borderRadius: BorderRadius.circular(100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        labels.length,
        (i) => Expanded(
          child: Semantics(
            selected: selected == i,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: selected == i
                    ? Colors.white
                    : Colors.transparent,
                foregroundColor: selected == i
                    ? Colors.black
                    : Theme.of(context).colorScheme.onSurface,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                shape: const StadiumBorder(),
                textStyle: Design.text(
                  12,
                  weight: selected == i ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              onPressed: () => onChanged(i),
              child: Text(
                labels[i],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class DemoField extends StatelessWidget {
  const DemoField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.password = false,
    this.email = false,
    this.labelSize = 13,
    this.multiline = false,
    this.onSubmitted,
  });
  final String label, hint;
  final TextEditingController controller;
  final bool password, email, multiline;
  final double labelSize;
  final ValueChanged<String>? onSubmitted;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: Design.text(
          labelSize,
          weight: FontWeight.w500,
          color: Design.muted,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        height: 52,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black)),
        ),
        child: TextField(
          controller: controller,
          obscureText: password,
          enableSuggestions: !password,
          autocorrect: !password,
          maxLines: multiline ? 2 : 1,
          keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
          style: Design.text(17),
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            semanticCounterText: label,
            hintStyle: Design.text(17, color: Design.muted),
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    ],
  );
}

class DbBadge extends StatelessWidget {
  const DbBadge(this.value, {super.key, this.color = Design.red});
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      value,
      style: Design.text(13, weight: FontWeight.w700, color: Colors.white),
    ),
  );
}

Color noiseColor(num value) => value < 50
    ? Design.green
    : value <= 70
    ? Design.yellow
    : Design.red;
