lib/
├── main.dart                          # Điểm khởi đầu, khởi tạo app
│
├── core/                              # CỐT LÕI - Dùng chung toàn app
│   ├── constants/                     # Hằng số
│   │   ├── app_constants.dart         # URL API, timeout, tên app
│   │   └── api_constants.dart         # Endpoints
│   │
│   ├── theme/                         # Giao diện
│   │   ├── app_colors.dart            # Màu sắc (Pastel Petal)
│   │   ├── app_typography.dart        # Font chữ
│   │   └── app_theme.dart             # Theme tổng hợp
│   │
│   ├── utils/                         # Hàm tiện ích
│   │   ├── price_formatter.dart       # Định dạng giá (16.980.000 ₫)
│   │   └── string_utils.dart          # Xử lý chuỗi
│   │
│   ├── extensions/                    # Mở rộng chức năng
│   │   └── context_extensions.dart    # showSnackBar, showLoading
│   │
│   └── widgets/                       # Widget dùng chung
│       ├── loading_widget.dart        # Vòng tròn loading
│       └── error_widget.dart          # Hiển thị lỗi
│
├── data/                              # TẦNG DỮ LIỆU
│   ├── models/                        # DTO - Định nghĩa cấu trúc dữ liệu
│   │   ├── gold_price_model.dart      # Giá vàng
│   │   └── exchange_rate_model.dart   # Tỷ giá
│   │
│   ├── datasources/                   # Nguồn dữ liệu
│   │   ├── remote/
│   │   │   ├── dio_client.dart        # Cấu hình Dio (HTTP client)
│   │   │   └── gold_api_service.dart  # Gọi API
│   │   └── local/
│   │       └── gold_local_service.dart # Cache (chưa dùng)
│   │
│   ├── repositories/                  # Kho lưu trữ
│   │   └── gold_repository.dart       # Xử lý dữ liệu từ nhiều nguồn
│   │
│   └── services/                      # Dịch vụ
│       └── location_service.dart      # Lấy vị trí GPS
│
├── domain/                            # TẦNG BUSINESS LOGIC
│   ├── entities/                      # Thực thể - Không phụ thuộc API
│   │   └── gold_price.dart            # GoldPrice entity thuần
│   │
│   ├── repositories/                  # Interface repository
│   │   └── gold_repository_interface.dart
│   │
│   └── usecases/                      # Use cases - Logic nghiệp vụ
│       └── get_gold_prices.dart       # "Lấy giá vàng"
│
└── presentation/                      # TẦNG GIAO DIỆN
    ├── blocs/                         # State Management
    │   └── gold/
    │       ├── gold_bloc.dart         # Xử lý logic
    │       ├── gold_event.dart        # Sự kiện (Load, Refresh, ChangeCity)
    │       └── gold_state.dart        # Trạng thái (Loading, Loaded, Error)
    │
    ├── screens/                       # Màn hình
    │   └── home/
    │       ├── home_screen.dart       # Màn hình chính
    │       └── widgets/               # Widget của riêng màn hình này
    │           ├── location_header.dart
    │           ├── gold_price_card.dart
    │           └── shimmer_loading.dart
    │
    └── widgets/                       # Widget dùng chung
        └── bottom_navigation.dart

        ┌─────────────────────────────────────────────────────────────────────────────┐
│ 1. Người dùng mở app                                                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 2. HomeScreen khởi tạo → BlocProvider tạo GoldBloc                         │
│    → GoldBloc tự động gửi event LoadGoldPrices                             │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 3. GoldBloc nhận event → emit(GoldLoading) → UI hiển thị shimmer loading   │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 4. GoldBloc gọi GetGoldPricesUseCase.execute(city: 'Hanoi')                │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 5. Use Case gọi GoldRepository.getLatestGoldPrices()                       │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 6. Repository gọi GoldApiService.getLatestGoldPrices()                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 7. DioClient gửi GET request đến https://be-gold-track-vn.onrender.com/... │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 8. API trả về JSON: {"data": [...], "pagination": {...}}                   │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 9. GoldApiService chuyển JSON → GoldListResponse                           │
│    Repository lấy response.data.data → List<GoldPriceModel>                │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 10. Use Case chuyển List<GoldPriceModel> → List<GoldPrice> (Entity)        │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 11. GoldBloc nhận kết quả → emit(GoldLoaded(goldPrices, city, timestamp))  │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ 12. UI rebuild → hiển thị danh sách giá vàng                               │
└─────────────────────────────────────────────────────────────────────────────┘