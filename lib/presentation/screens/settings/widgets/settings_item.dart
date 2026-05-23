import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_provider.dart';

enum SettingsItemType {
  switch_,
  navigation,
  action,
  info,
  dropdown,
  themeToggle,
}

class SettingsItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final SettingsItemType type;
  final bool? initialValue;
  final VoidCallback? onTap;
  final List<String>? dropdownItems;
  final String? dropdownValue;

  const SettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.type,
    this.initialValue,
    this.onTap,
    this.dropdownItems,
    this.dropdownValue,
  });

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  late bool _switchValue;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.initialValue ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: widget.type == SettingsItemType.navigation || widget.type == SettingsItemType.action
          ? widget.onTap
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTypography.bodyMedium.copyWith(
                      color: isEthereal ? AppColors.etherealTextPrimary : null,
                    ),
                  ),
                  if (widget.subtitle != null && widget.subtitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        widget.subtitle!,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (widget.type == SettingsItemType.dropdown && widget.dropdownItems != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _buildDropdown(),
                    ),
                ],
              ),
            ),
            _buildTrailing(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    switch (widget.type) {
      case SettingsItemType.switch_:
        return Switch(
          value: _switchValue,
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
            widget.onTap?.call();
          },
          activeThumbColor: isEthereal ? AppColors.lavender : Theme.of(context).primaryColor,
        );
      case SettingsItemType.navigation:
        return Icon(Icons.chevron_right, color: isEthereal ? AppColors.etherealTextHint : Colors.grey);
      case SettingsItemType.themeToggle:
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    themeProvider.setTheme(AppThemeType.gold);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldPrimaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: themeProvider.currentTheme == AppThemeType.gold
                            ? AppColors.goldMain
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    themeProvider.setTheme(AppThemeType.ethereal);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.etherealGradient,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: themeProvider.currentTheme == AppThemeType.ethereal
                            ? AppColors.lavender
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      case SettingsItemType.action:
        return const Icon(Icons.delete_outline, color: Colors.red);
      case SettingsItemType.info:
        return const SizedBox.shrink();
      case SettingsItemType.dropdown:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDropdown() {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: isEthereal ? AppColors.etherealSurfaceVariant : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: widget.dropdownValue,
        underline: const SizedBox(),
        isExpanded: false,
        dropdownColor: isEthereal ? AppColors.etherealSurface : Colors.white,
        items: widget.dropdownItems?.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: AppTypography.bodySmall.copyWith(
                color: isEthereal ? AppColors.etherealTextPrimary : null,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          widget.onTap?.call();
        },
      ),
    );
  }
}