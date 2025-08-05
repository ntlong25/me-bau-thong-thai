// Dữ liệu giả định cho cẩm nang theo tuần thai
// Trong MVP này, chúng ta sẽ hardcode dữ liệu. Sau này có thể tải từ file JSON hoặc API.
final Map<int, Map<String, String>> weeklyHandbookData = {
  1: {
    'title': 'Tuần 1: Khởi đầu một hành trình mới',
    'baby':
        'Em bé của bạn chỉ là một nhóm nhỏ các tế bào, chưa được hình thành rõ ràng.',
    'mom':
        'Đây là tuần đầu tiên của chu kỳ kinh nguyệt cuối cùng của bạn. Bạn chưa thực sự mang thai, nhưng đây là cách tính tuần thai thông thường.',
    'tip':
        'Bắt đầu uống bổ sung axit folic ngay bây giờ nếu bạn chưa làm! Nó rất quan trọng cho sự phát triển của bé.',
  },
  2: {
    'title': 'Tuần 2: Chuẩn bị cho sự thụ tinh',
    'baby':
        'Trứng đang phát triển trong buồng trứng và chuẩn bị cho quá trình rụng trứng.',
    'mom':
        'Cơ thể bạn đang chuẩn bị cho quá trình rụng trứng. Hãy theo dõi chu kỳ của mình để tăng khả năng thụ thai.',
    'tip': 'Tiếp tục duy trì chế độ ăn uống lành mạnh và lối sống tích cực.',
  },
  3: {
    'title': 'Tuần 3: Thụ thai và bắt đầu cuộc sống',
    'baby':
        'Trứng đã được thụ tinh và bắt đầu di chuyển xuống tử cung, phân chia thành nhiều tế bào hơn.',
    'mom':
        'Bạn có thể chưa cảm nhận được gì, nhưng một cuộc sống mới đã bắt đầu bên trong bạn!',
    'tip':
        'Tránh rượu, thuốc lá và các chất kích thích khác. Bắt đầu tìm hiểu về những điều nên và không nên làm khi mang thai.',
  },
  4: {
    'title': 'Tuần 4: Làm tổ và phát triển',
    'baby':
        'Phôi thai đã làm tổ trong tử cung của bạn. Các tế bào đang phát triển nhanh chóng để hình thành các cơ quan.',
    'mom':
        'Bạn có thể bắt đầu cảm thấy mệt mệt, buồn nôn hoặc đau ngực. Đây là những dấu hiệu sớm của thai kỳ.',
    'tip':
        'Đặt lịch hẹn khám thai đầu tiên với bác sĩ. Bắt đầu theo dõi các triệu chứng của mình.',
  },
  5: {
    'title': 'Tuần 5: Tim đập đầu tiên',
    'baby':
        'Tim của bé bắt đầu đập! Não, tủy sống và các cơ quan khác đang hình thành.',
    'mom':
        'Các triệu chứng thai nghén có thể trở nên rõ rệt hơn. Cố gắng ăn các bữa nhỏ và thường xuyên để giảm buồn nôn.',
    'tip':
        'Nghỉ ngơi đầy đủ. Tránh các loại thực phẩm có thể gây hại cho thai kỳ.',
  },
  6: {
    'title': 'Tuần 6: Khuôn mặt và chi hình thành',
    'baby':
        'Khuôn mặt và các chi của bé bắt đầu hình thành. Ống thần kinh đang đóng lại.',
    'mom':
        'Buồn nôn và mệt mỏi có thể đạt đỉnh điểm. Cố gắng giữ cho mình đủ nước.',
    'tip': 'Bắt đầu nghĩ về việc chọn bác sĩ hoặc bệnh viện cho việc sinh nở.',
  },
  7: {
    'title': 'Tuần 7: Phát triển não bộ',
    'baby':
        'Não của bé đang phát triển nhanh chóng. Các ngón tay và ngón chân bắt đầu xuất hiện.',
    'mom':
        'Bạn có thể cảm thấy thèm ăn hoặc ghét bỏ một số loại thực phẩm. Ngực có thể sưng và đau hơn.',
    'tip':
        'Tìm hiểu về các bài tập thể dục an toàn cho bà bầu. Đi bộ nhẹ nhàng là một lựa chọn tốt.',
  },
  8: {
    'title': 'Tuần 8: Bé đã có kích thước bằng quả mâm xôi',
    'baby':
        'Bé đã có kích thước bằng quả mâm xôi. Các cơ quan chính đã hình thành và bắt đầu hoạt động.',
    'mom': 'Bạn có thể cảm thấy mệt mỏi hơn bình thường. Cố gắng ngủ đủ giấc.',
    'tip':
        'Bắt đầu ghi lại nhật ký thai kỳ của bạn. Chụp ảnh bụng bầu hàng tuần để theo dõi sự thay đổi.',
  },
  // Thêm dữ liệu cho các tuần khác nếu bạn muốn mở rộng trong MVP
  // ...
  40: {
    'title': 'Tuần 40: Em bé sẵn sàng chào đời!',
    'baby': 'Em bé đã phát triển đầy đủ và sẵn sàng chào đời bất cứ lúc nào.',
    'mom':
        'Bạn có thể cảm thấy rất nặng nề và khó chịu. Hãy sẵn sàng cho việc chuyển dạ.',
    'tip':
        'Hãy giữ bình tĩnh và chuẩn bị tinh thần cho cuộc gặp gỡ đầu tiên với bé yêu!',
  },
};
