# 📱 MVP App: Mẹ Bầu Thông Thái

## 🎯 Mục tiêu Phase 1
Xây dựng ứng dụng Flutter cơ bản cho mẹ bầu với 3 tính năng:
1. Tính tuần thai hiện tại từ ngày dự sinh
2. Cẩm nang theo tuần thai
3. Checklist chuẩn bị đi sinh

Mục tiêu là hoàn thiện và đưa lên AppStore (TestFlight hoặc Production).

---

## ✅ Danh sách công việc (Kanban)

### To Do
- [ ] Khởi tạo Flutter project + cấu trúc thư mục
- [ ] Cài đặt các thư viện cần thiết (Hive, Google Fonts, v.v.)
- [ ] Thiết kế UI màn hình chính (Home)
- [ ] Tạo form nhập ngày dự sinh (DatePicker)
- [ ] Tính toán tuần thai hiện tại từ ngày dự sinh
- [ ] Thiết kế màn hình Cẩm nang theo tuần
- [ ] Tạo file JSON chứa nội dung cẩm nang theo tuần (0–40)
- [ ] Load nội dung cẩm nang từ JSON
- [ ] Thiết kế màn hình Checklist chuẩn bị đi sinh
- [ ] Tạo danh sách đồ dùng mẫu (file local hoặc model)
- [ ] Lưu trạng thái checklist bằng Hive
- [ ] Tối ưu giao diện toàn bộ app (UI dịu nhẹ, màu pastel)
- [ ] Tạo icon app + splash screen
- [ ] Cấu hình iOS build + upload TestFlight

### In Progress
- [ ] _(di chuyển task đang làm vào đây)_

### Done
- [ ] _(di chuyển task hoàn thành vào đây)_

---

## 🔧 Công nghệ & thư viện
- Flutter (Material 3)
- Hive (lưu local)
- Google Fonts
- `flutter_local_notifications` (nâng cấp sau)
- `intl` (format ngày giờ)

---

## 📁 Cấu trúc thư mục đề xuất
```
lib/
├── main.dart
├── models/
│   ├── pregnancy_info.dart
│   └── checklist_item.dart
├── screens/
│   ├── home_screen.dart
│   ├── week_detail_screen.dart
│   └── checklist_screen.dart
├── widgets/
│   └── info_card.dart
├── services/
│   └── local_storage_service.dart
├── data/
│   └── week_data.json
└── utils/
    └── date_utils.dart
```

---

## 📆 Timeline đề xuất (10–14 ngày)
| Ngày      | Công việc chính                        |
|-----------|----------------------------------------|
| Day 1–2   | Setup Flutter + UI màn hình chính      |
| Day 3–4   | Logic tính tuần thai + lưu ngày        |
| Day 5–6   | Tạo và hiển thị cẩm nang tuần thai     |
| Day 7–8   | Checklist đồ đi sinh + Hive lưu trạng thái |
| Day 9–10  | Tối ưu UI + thêm icon, splash          |
| Day 11–12 | Build iOS + thử nghiệm TestFlight      |

---

## 💡 Ghi chú mở rộng sau MVP
- [ ] Thêm push notification nhắc khám thai
- [ ] Theo dõi cân nặng, cảm xúc, nhật ký
- [ ] Đồng bộ cloud (Firebase hoặc Supabase)
