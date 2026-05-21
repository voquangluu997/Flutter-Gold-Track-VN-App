import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_group.dart';
import 'widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: isEthereal
              ? const BoxDecoration(
                  gradient: AppColors.etherealGradient,
                )
              : null,
          child: AppBar(
            title: const Text('Cài đặt'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            const ProfileHeader(),
            const SizedBox(height: 24),
            
            // Cài đặt thông báo
            SettingsGroup(
              title: 'Thông báo',
              icon: Icons.notifications_active,
              children: [
                SettingsItem(
                  title: 'Thông báo đẩy',
                  subtitle: 'Nhận thông báo về biến động giá',
                  type: SettingsItemType.switch_,
                ),
                SettingsItem(
                  title: 'Báo cáo hàng ngày',
                  subtitle: 'Nhận báo cáo giá lúc 8:00 sáng',
                  type: SettingsItemType.switch_,
                  initialValue: true,
                ),
                SettingsItem(
                  title: 'Cảnh báo biến động',
                  subtitle: 'Thông báo khi giá thay đổi >1%',
                  type: SettingsItemType.switch_,
                  initialValue: true,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Cài đặt hiển thị
            SettingsGroup(
              title: 'Hiển thị',
              icon: Icons.palette,
              children: [
                SettingsItem(
                  title: 'Chủ đề',
                  subtitle: '',
                  type: SettingsItemType.themeToggle,
                ),
                SettingsItem(
                  title: 'Đơn vị tiền tệ',
                  subtitle: 'Việt Nam Đồng (VND)',
                  type: SettingsItemType.dropdown,
                  dropdownItems: ['VND', 'USD'],
                  dropdownValue: 'VND',
                ),
                SettingsItem(
                  title: 'Ngôn ngữ',
                  subtitle: 'Tiếng Việt',
                  type: SettingsItemType.dropdown,
                  dropdownItems: ['Tiếng Việt', 'English'],
                  dropdownValue: 'Tiếng Việt',
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Cài đặt vị trí
            SettingsGroup(
              title: 'Vị trí',
              icon: Icons.location_on,
              children: [
                SettingsItem(
                  title: 'Sử dụng vị trí hiện tại',
                  subtitle: 'Tự động xác định thành phố',
                  type: SettingsItemType.switch_,
                  initialValue: false,
                ),
                SettingsItem(
                  title: 'Khu vực mặc định',
                  subtitle: 'Hà Nội',
                  type: SettingsItemType.dropdown,
                  dropdownItems: ['Hà Nội', 'TP. Hồ Chí Minh', 'Đà Nẵng'],
                  dropdownValue: 'Hà Nội',
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Cài đặt khác
            SettingsGroup(
              title: 'Khác',
              icon: Icons.more_horiz,
              children: [
                SettingsItem(
                  title: 'Xóa cache',
                  subtitle: 'Xóa dữ liệu tạm thời',
                  type: SettingsItemType.action,
                  onTap: () => _showClearCacheDialog(context),
                ),
                SettingsItem(
                  title: 'Phiên bản',
                  subtitle: '1.0.0 (26)',
                  type: SettingsItemType.info,
                ),
                SettingsItem(
                  title: 'Chính sách bảo mật',
                  type: SettingsItemType.navigation,
                  onTap: () => _openPrivacyPolicy(context),
                ),
                SettingsItem(
                  title: 'Điều khoản sử dụng',
                  type: SettingsItemType.navigation,
                  onTap: () => _openTermsOfService(context),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Nút đăng xuất
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                label: const Text('ĐĂNG XUẤT'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Footer
            Column(
              children: [
                Icon(
                  Icons.workspace_premium,
                  size: 32,
                  color: isEthereal ? AppColors.lavender : AppColors.goldMain,
                ),
                const SizedBox(height: 8),
                Text(
                  'GoldTrack Vietnam',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '© 2026 GoldTrack. All rights reserved.',
                  style: AppTypography.caption.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Dữ liệu được cập nhật từ 24h.com.vn và giavang.org',
                  style: AppTypography.caption.copyWith(color: Colors.grey.shade400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa cache'),
        content: const Text('Bạn có chắc chắn muốn xóa dữ liệu tạm thời?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Xóa cache
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa cache thành công')),
              );
            },
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Đăng xuất
              Navigator.pop(context);
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    // TODO: Mở trang chính sách bảo mật
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang phát triển')),
    );
  }

  void _openTermsOfService(BuildContext context) {
    // TODO: Mở trang điều khoản sử dụng
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đang phát triển')),
    );
  }
}