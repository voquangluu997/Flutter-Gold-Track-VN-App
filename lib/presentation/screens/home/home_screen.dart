import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_track_app/presentation/screens/settings/setting.screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/gold_repository.dart';
import '../../blocs/gold/gold_bloc.dart';
import '../../blocs/gold/gold_event.dart';
import '../../blocs/gold/gold_state.dart';
import '../gold_detail/gold_detail_screen.dart';
import 'widgets/location_header.dart';
import 'widgets/gold_price_card.dart';
import 'widgets/shimmer_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoldBloc(GoldRepository())..add(const LoadGoldPrices(city: 'Hanoi')),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final RefreshController _refreshController = RefreshController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isEthereal = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration:const BoxDecoration(gradient: AppColors.etherealGradient),
          child: AppBar(
            title: const Text('GoldTrack'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  final state = context.read<GoldBloc>().state;
                  if (state is GoldLoaded) {
                    context.read<GoldBloc>().add(RefreshGoldPrices(city: state.currentCity));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<GoldBloc, GoldState>(
        listener: (context, state) {
          if (state is GoldLoaded) _refreshController.refreshCompleted();
          if (state is GoldError) _refreshController.refreshFailed();
        },
        builder: (context, state) {
          if (state is GoldLoading) return const ShimmerLoading();
          if (state is GoldLoaded) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                context.read<GoldBloc>().add(RefreshGoldPrices(city: state.currentCity));
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LocationHeader(
                      city: state.currentCity,
                      lastUpdated: state.lastUpdated,
                      onCityTap: () => _showCityPicker(context),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => GoldPriceCard(
                          price: state.goldPrices[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GoldDetailScreen(
                                  brand: state.goldPrices[index].brand,
                                  city: state.currentCity,
                                ),
                              ),
                            );
                          },
                        ),
                        childCount: state.goldPrices.length,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is GoldError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<GoldBloc>().add(const LoadGoldPrices(city: 'Hanoi')),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.show_chart, 1),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.notifications, 2),
              label: 'Alert',
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person, 3),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    final isEthereal = Theme.of(context).brightness == Brightness.dark;
    
    if (isEthereal && isSelected) {
      return ShaderMask(
        shaderCallback: (bounds) => AppColors.etherealGradient.createShader(bounds),
        child: Icon(icon, color: Colors.white),
      );
    }
    return Icon(icon, color: isSelected ? Theme.of(context).primaryColor : Colors.grey);
  }

  void _showCityPicker(BuildContext context) {
    final goldBloc = context.read<GoldBloc>();
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (BuildContext sheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Chọn khu vực',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildCityOption(sheetContext, goldBloc, 'Hanoi', 'Hà Nội'),
              _buildCityOption(sheetContext, goldBloc, 'HCMC', 'TP. Hồ Chí Minh'),
              _buildCityOption(sheetContext, goldBloc, 'Danang', 'Đà Nẵng'),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCityOption(BuildContext context, GoldBloc goldBloc, String code, String name) {
    return ListTile(
      leading: Icon(Icons.location_city, color: Theme.of(context).primaryColor),
      title: Text(name),
      onTap: () {
        goldBloc.add(ChangeCity(code));
        Navigator.pop(context);
      },
    );
  }
}