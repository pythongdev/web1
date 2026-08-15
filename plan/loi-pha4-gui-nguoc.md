# Dòng lỗi phạm vi route — pha 4 gửi ngược về pha 3

> Cập nhật **2026-08-15** · Lane sở hữu: **FE** · Task: [T-FE-01](../design/fe/task_fe.md) · Đóng: [F-FE-01](../design/fe/finding_fe.md#f-fe-01) · [F-FE-02](../design/fe/finding_fe.md#f-fe-02) · [F-FE-03](../design/fe/finding_fe.md#f-fe-03)
> Gửi tới: **lane BA** (owner của `prompt-fullstack.md`). FE **không tự trả lời** dòng nào trong file này.

**Vì sao có file này.** `prompt-fullstack §3.7` tự khai cơ chế: *"pha 4 **không** đổi hợp đồng API; cần đổi ⇒ ghi
thành một dòng lỗi gửi ngược về pha 3"*. Đây là dòng lỗi đó. Nội dung: cây route ở §3.7 và tập màn hình trong
`wireframes/` **không khớp nhau ở cả hai chiều** — bảng đối chiếu ở [design/fe/README.md §2](../design/fe/README.md).

**Trạng thái hôm nay:** pha 4 chưa chạy ⇒ **§3.7 thắng** ⇒ 16 màn ở §1 dưới đây **chưa được phép dựng**, kể cả
khi chúng đã có wireframe hoàn chỉnh. 14 trên 20 dòng ở [task_fe.md](../design/fe/task_fe.md) đang chờ file này.

**Cách trả lời.** Mỗi dòng kết bằng `Trả lời:` — viết ngay sau dấu hai chấm, **trên cùng dòng đó**.
Ba giá trị được nhận: `GIỮ` · `BỎ` · `GỘP vào <route>`. Kèm một câu lý do nếu khác `GIỮ`.
Đọc **§3 trước §1 và §2** — §3 có thể gộp nhiều dòng lại thành một quyết định.

---

## §1. Wireframe đã vẽ, §3.7 không có — giữ hay bỏ?

Mỗi dòng đã tốn công vẽ (bản vẽ, mô tả nghiệp vụ, mô tả kỹ thuật). Công đó là **chi phí đã chìm** — không phải lý do để giữ.

- `(shop)/menu/favourites` — danh sách món khách đã thả tim, lọc Tất cả / Món lẻ / Combo, chỉnh số lượng inline. **Chốt:** quán bán tại bàn qua QR, khách có quay lại đủ nhiều để tính năng này sinh lời không? Trả lời:
- `(shop)/menu/favourites/save` — đặt tên cho tổ hợp món vừa chỉnh, tạo shortcut đặt lại. **Chốt:** phụ thuộc dòng trên; bỏ dòng trên thì dòng này tự mất. Trả lời:
- `(shop)/menu/favourites/sets` — liệt kê set đã lưu, đổi tên, xoá, Áp dụng để đổ cả set vào giỏ. **Chốt:** phụ thuộc hai dòng trên. Trả lời:
- `(shop)/order/[id]` — khách xem realtime từng món đã ra / còn chờ, huỷ từng món, bảng tiền đã dùng và còn lại. **Chốt:** xem §3 — nhiều khả năng đây chính là `orders/[code]` của §3.7, khác tên chứ không khác màn. Trả lời:
- `(shop)/tracking` — vị trí hàng chờ và ETA, hàng chờ chung của quán, sơ đồ bàn. **Chốt:** khách có cần thấy hàng chờ của **bàn khác** không, hay chỉ cần đơn của mình? Đây là màn duy nhất lộ dữ liệu bàn khác ra ngoài. Trả lời:
- `(shop)/profile` — hồ sơ khách: họ tên, số điện thoại, địa chỉ, email. **Chốt:** bán tại bàn thì có cần hồ sơ khách không, hay chỉ cần khi có giao hàng? Giữ dòng này là mở ra nghĩa vụ dữ liệu cá nhân. Trả lời:
- `admin/overview` — điều phối sàn realtime: 4 KPI, prep queue theo bàn, serving tracker, lưới bàn. **Chốt:** xem §3 — có thể là `admin/orders` cộng `admin/tables` của §3.7 gộp làm một. Trả lời:
- `admin/summary` — báo cáo ngày: doanh thu, giờ cao điểm, kênh đặt, top món, hiệu suất bếp và nhân viên. **Chốt:** xem §3 — nhiều khả năng chính là `admin/reports`. Trả lời:
- `admin/categories` — CRUD danh mục menu, trường Thứ tự quyết định thứ tự tab trên menu khách. **Chốt:** menu quán có đủ nhiều nhóm để cần màn quản trị riêng, hay khai cứng trong dữ liệu mồi là đủ? Trả lời:
- `admin/toppings` — CRUD topping, công tắc Có sẵn / Hết, giá 0 hiện nhãn Miễn phí. **Chốt:** topping là **nguồn phụ thu**, §3.2 đang giữ giá — quản trị nó ở màn riêng hay nằm trong màn Sản phẩm? Trả lời:
- `admin/combos` — CRUD combo, tự tính mức tiết kiệm so tổng giá lẻ, tối thiểu 2 món. **Chốt:** combo có đổi thường xuyên không? Không đổi thì nó thuộc dữ liệu mồi, không cần màn. Trả lời:
- `admin/staff/task-board` — bảng nhiệm vụ theo người, tỉ lệ hoàn thành và điểm chất lượng, Assign từng dòng. **Chốt:** xem §3 — trùng nghiệp vụ với dòng ngay dưới, phải bỏ một. Trả lời:
- `admin/todo-list` — checklist việc theo ngày, nhân viên tự tick, quá hạn tô đỏ. **Chốt:** xem §3 — trùng nghiệp vụ với dòng ngay trên. Trả lời:
- `admin/training` — guide theo vai trò, nhúng video YouTube, bảng completion, lịch sử quiz. **Chốt:** đào tạo nhân viên có thuộc phạm vi phần mềm bán hàng không, hay là việc ngoài hệ thống? Nhúng YouTube kéo theo CSP và nguồn ngoài. Trả lời:
- `admin/storage` — tồn kho nguyên liệu, hạn sử dụng, ngưỡng cảnh báo tự đổi trạng thái. **Chốt:** có ai thật sự nhập số liệu kho mỗi ngày không? Kho không được cập nhật thì tệ hơn không có kho. Trả lời:
- `admin/marketing` — ngân sách khai trương, 5 hạng mục chi, donut phân bổ, lộ trình 5 tuần. **Chốt:** đây là việc **một lần** lúc khai trương — có cần nằm trong sản phẩm không, hay một bảng tính là đủ? Trả lời:

## §2. §3.7 đã khai, chưa ai vẽ — vẫn giữ trong phạm vi chứ?

Không dòng nào ở đây là finding: *"chưa có wireframe"* là **task**, không phải lỗi. Câu hỏi là **có còn trong phạm vi không**.

- `(shop)/` — trang chủ của khách trước khi vào menu. **Chốt:** khách vào bằng quét QR tại bàn thì có bao giờ thấy trang này không? Trả lời:
- `(shop)/menu/[slug]` — chi tiết món. **Chốt:** xem §3 — cùng màn với `menu/product/[id]` của wireframe, chỉ khác khoá tra. Trả lời:
- `(shop)/cart` — giỏ hàng dạng trang riêng. **Chốt:** wireframe làm giỏ bằng **drawer** ngay trên màn menu, không phải route. Giữ route hay chuyển thành drawer? §3.2b đặt bước chọn canh ở giỏ nên chỗ này quan trọng. Trả lời:
- `(shop)/checkout` — xác nhận và đặt đơn. **Chốt:** wireframe rẽ nhánh: có `tableId` thì mở modal xác nhận bàn, không có thì mới sang checkout. Giữ nhánh nào? Trả lời:
- `(shop)/orders/[code]` — xem đơn theo mã. **Chốt:** xem §3 — nhiều khả năng cùng màn với `order/[id]`, khác nhau ở tra bằng `code` hay `id`. Trả lời:
- `t/[token]/page` — trang mở từ token của bàn, không vào index tìm kiếm. **Chốt:** đây là đích thật của mã QR dán trên bàn; có phải nó redirect sang `/menu` như wireframe mô tả không? Trả lời:
- `t/[token]/bill` — hoá đơn của bàn. **Chốt:** khách tự xem hoá đơn để đối chiếu trước khi trả tiền — giữ, hay gộp vào màn theo dõi đơn? Trả lời:
- `staff/login` — đăng nhập nhân viên bằng PIN. **Chốt:** PIN hay tài khoản mật khẩu? Màn `admin/staff` của wireframe đang tạo **tên đăng nhập và mật khẩu**, không phải PIN. Trả lời:
- `staff/pos` — POS quầy: sơ đồ bàn xanh trống / cam có khách / đỏ cần dọn, đặt hộ 1 suất trong 3 lần chạm, banner đỏ khi có đơn QR chờ duyệt. **Chốt:** đây là màn **thu tiền** — không có nó thì bán hàng bằng gì? Ưu tiên số mấy? Trả lời:
- `staff/station/[code]` — màn hình trạm bếp: tên món ≥ 24px, một task một thẻ một nút Xong, màu theo thời gian chờ, Hoàn tác 10 giây. **Chốt:** cùng câu hỏi với dòng trên — bếp nhận đơn bằng gì nếu không có màn này? Trả lời:
- `staff/cleaning` — màn dọn bàn. **Chốt:** có tách vai dọn bàn riêng không, hay gộp vào POS? Trả lời:
- `admin/orders` — danh sách đơn. **Chốt:** xem §3 — có thể `admin/overview` của wireframe đã phủ. Trả lời:
- `admin/tables` — quản trị bàn: số bàn, số chỗ, mã QR. **Chốt:** bàn và mã QR phải khai ở đâu đó **trước khi** quét được — không màn nào của wireframe làm việc này. Trả lời:
- `admin/reports` — báo cáo. **Chốt:** xem §3 — có thể `admin/summary` của wireframe đã phủ. Trả lời:
- `admin/settings` — cấu hình quán: giờ bán, thuế, thông tin in hoá đơn. **Chốt:** logic giờ bán 6h–11h nằm ở đây hay hardcode? Nếu hardcode thì bỏ được màn này. Trả lời:

## §3. Bảy cặp có thể là **cùng một màn khác tên** — đọc trước, quyết ở đây thì §1 và §2 tự rút gọn

Nếu một cặp được xác nhận là một, hai dòng tương ứng ở §1 và §2 trả lời `GỘP vào <route>` chứ không phải `GIỮ` hai lần.

| Cặp | §3.7 gọi là | Wireframe gọi là | Điểm khác thật sự, không phải khác tên |
|---|---|---|---|
| 1 | `(shop)/menu/[slug]` | `(shop)/menu/product/[id]` | Khoá tra: `slug` cần nguồn sinh cho tên tiếng Việt có dấu và luật xử lý trùng; `id` thì không. Đây là [F-FE-02](../design/fe/finding_fe.md#f-fe-02) |
| 2 | `(shop)/orders/[code]` | `(shop)/order/[id]` | `code` hàm ý mã khách đọc được và gõ lại được; `id` hàm ý chỉ tới từ link. Ai gõ mã, gõ ở đâu? |
| 3 | `admin/orders` | `admin/overview` | Wireframe làm dashboard điều phối realtime, không phải danh sách đơn. Cần cả hai hay chỉ một? |
| 4 | `admin/reports` | `admin/summary` | Wireframe khoá mọi khối vào **một** date picker và chặn ngày tương lai. §3.7 không nói gì về phạm vi báo cáo |
| 5 | `admin/tables` | (không có) | Wireframe **không có** màn khai bàn và mã QR, trong khi cả luồng khách bắt đầu từ đó |
| 6 | `staff/pos` và `staff/station/[code]` | (không có) | Hai màn vận hành cốt lõi, §3.7 mô tả khá chi tiết nên dựng được mà chưa cần vẽ lại |
| 7 | `admin/staff/task-board` và `admin/todo-list` | cả hai đều là wireframe | Cùng đọc `GET /admin/tasks`, cùng khai quản lý giao việc và nhân viên tự tick. Đây là [F-FE-03](../design/fe/finding_fe.md#f-fe-03) — phải bỏ một |

## §4. Một câu hỏi không thuộc route, nhưng chặn cùng chỗ

`wireframes/` viết endpoint **hai dạng** trong cùng một thư mục (`:id` so với `{id}`, có so với không có tiền tố
`/api/v1`) — [F-FE-04](../design/fe/finding_fe.md#f-fe-04). Câu hỏi cho pha 3: hợp đồng ở `plan/3-be.md` chốt **một**
dạng nào? FE sinh type từ đó, không gom từ wireframe. Trả lời:

---

## Biên nhận của T-FE-01

```sh
awk -F'|' '/Wireframe có, §3.7 không có|§3.7 có, wireframe không có/{print $3}' design/fe/README.md \
  | grep -oE '`[^`]+`' | tr -d '`' | grep -v '^T-FE' | sort -u \
  | while read r; do grep -qF "$r" plan/loi-pha4-gui-nguoc.md || echo "THIẾU: $r"; done   # 1. phải rỗng
grep -c 'Trả lời:$' plan/loi-pha4-gui-nguoc.md    # 2. số dòng CHƯA có người trả lời; khác 0 ⇒ F-FE-01 chưa đóng được
```

Phép 1 bắt **route bị bỏ sót** khi gửi đi — không đếm số, mà dò từng route khai ở [README §2](../design/fe/README.md)
xem có mặt trong file này không. Nó cũng đỏ ngược lại khi README §2 được sửa mà file này thì không.

Lệnh thứ hai là cổng của [F-FE-01](../design/fe/finding_fe.md#f-fe-01): còn khác `0` thì **chưa lane nào được dựng**
16 màn ở §1. Tự điền hộ để lệnh về `0` là bịa xác nhận của owner — đúng kiểu hỏng mà `T-04` và `T-16` đang tránh
với 6 con số giá.
