# Đồng Hành Thai Kỳ - Flutter App

Ứng dụng hỗ trợ theo dõi thai kỳ cho các bà mẹ, cung cấp thông tin chi tiết về sự phát triển của thai nhi và checklist chuẩn bị đi sinh.

## 🏗️ Cấu trúc dự án

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── screens/                  # Các màn hình chính
│   ├── home_screen.dart      # Màn hình chính
│   ├── weekly_handbook_screen.dart  # Cẩm nang theo tuần thai
│   └── checklist_screen.dart # Checklist chuẩn bị đi sinh
├── models/                   # Các model dữ liệu
│   └── checklist_item.dart   # Model cho checklist item
├── services/                 # Business logic và services
│   └── pregnancy_service.dart # Service xử lý logic thai kỳ
├── data/                     # Dữ liệu tĩnh
│   └── weekly_handbook_data.dart # Dữ liệu cẩm nang tuần thai
├── widgets/                  # Custom widgets (để phát triển)
└── utils/                    # Utility functions (để phát triển)
```

## 🚀 Tính năng chính

### 1. Theo dõi tuần thai

- Nhập và lưu ngày dự sinh
- Tự động tính toán tuần thai hiện tại
- Hiển thị số ngày còn lại đến ngày dự sinh

### 2. Cẩm nang theo tuần thai

- Thông tin chi tiết cho từng tuần (1-40 tuần)
- Mỗi tuần có 3 phần: Em bé, Mẹ, Lời khuyên
- Navigation giữa các tuần với animation

### 3. Checklist chuẩn bị đi sinh

- Danh sách 12 mục cần chuẩn bị
- Khả năng đánh dấu hoàn thành
- Thêm/sửa ghi chú cho từng mục

## 🛠️ Công nghệ sử dụng

- **Framework**: Flutter 3.8.1+
- **Language**: Dart
- **State Management**: StatefulWidget
- **Local Storage**: SharedPreferences
- **Architecture**: Feature-based folder structure

## 📱 Cài đặt và chạy

1. **Clone repository**

```bash
git clone <repository-url>
cd me-bau
```

2. **Cài đặt dependencies**

```bash
flutter pub get
```

3. **Chạy ứng dụng**

```bash
flutter run
```

## 🎨 UI/UX

- **Theme**: Material Design với màu hồng làm chủ đạo
- **Font**: Inter (nếu có) hoặc font mặc định
- **Design**: Card-based layout với bo tròn và elevation

## 🔧 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.1
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 📊 Lưu trữ dữ liệu

- **SharedPreferences**: Lưu ngày dự sinh và checklist
- **JSON Serialization**: Cho việc lưu/đọc checklist
- **Hardcoded Data**: Dữ liệu cẩm nang (có thể chuyển sang API sau)

## 🚀 Roadmap

### Phase 1 (Hiện tại) ✅

- [x] Cấu trúc project clean architecture
- [x] Tính năng theo dõi tuần thai
- [x] Cẩm nang theo tuần thai
- [x] Checklist chuẩn bị đi sinh

### Phase 2 (Tương lai)

- [ ] Thêm tính năng nhật ký thai kỳ
- [ ] Lịch khám thai
- [ ] Theo dõi cân nặng và huyết áp
- [ ] Thông báo và reminders
- [ ] Chia sẻ với gia đình

### Phase 3 (Mở rộng)

- [ ] Backend API
- [ ] Đồng bộ đa thiết bị
- [ ] Cộng đồng và chia sẻ kinh nghiệm
- [ ] Tích hợp với thiết bị IoT

## 🤝 Đóng góp

1. Fork project
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Dự án này được phát hành dưới MIT License.

## 👥 Team

- **Developer**: [Your Name]
- **Design**: [Designer Name]
- **Product Manager**: [PM Name]

---

**Lưu ý**: Đây là phiên bản MVP (Minimum Viable Product). Các tính năng sẽ được phát triển thêm theo thời gian.
