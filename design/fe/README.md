# design/fe — sổ kiểm kê màn hình FE

> Cập nhật **2026-08-15** · Lane sở hữu: **FE** · Khuôn thư mục: [07 §2](../../project_preparation/07-cau-truc-du-an.md)
> Nhà **duy nhất** của: *dự án này có bao nhiêu màn hình FE, mỗi màn ở route nào, dòng task nào dựng nó*.
> **Không** giữ: mô tả chi tiết từng màn (nhà thật ở [wireframes/](../../wireframes/)) · hợp đồng API và phạm vi route
> (nhà thật ở [prompt-fullstack §3.6 · §3.7](../../project_preparation/prompt-fullstack.md) **cho tới khi** `plan/4-fe.md` chạy xong,
> từ lúc đó `plan/4-fe.md` thắng và phải sửa ngược `prompt-fullstack.md` ngay trong cùng phiên).

**Ai thắng khi lệch — đọc trước khi dùng bảng dưới.** Cột *Route* là **route trong wireframe**, không phải route đã chốt.
Pha 4 chưa chạy (`T-09` ở [task.md](../../task.md)) ⇒ **§3.7 đang thắng wireframe**. Chỗ hai bên nói ngược nhau đã mở
finding — xem [finding_fe.md](finding_fe.md). **Đừng tự chọn bên** khi dựng.

**Lệnh đỏ khi file này lệch** (chạy từ gốc repo, cả ba phải rỗng):

```sh
grep -oE '\]\(\.\./\.\./wireframes/[^)]+\)' design/fe/README.md | sed 's#^](\.\./\.\./##; s#)$##' \
  | while read p; do [ -f "$p" ] || echo "GÃY: $p"; done                       # 1. link tới wireframe đã chết
grep -oE 'T-FE-[0-9]+' design/fe/README.md | sort -u \
  | while read t; do grep -q "\*\*$t\*\*" design/fe/task_fe.md || echo "THIẾU DÒNG: $t"; done   # 2. mã task khai ở đây mà không có dòng thật
grep -oE '^\| (~~)?\*\*T-FE-[0-9]+' design/fe/task_fe.md | grep -oE 'T-FE-[0-9]+' \
  | while read t; do grep -q "$t" design/fe/README.md || echo "MỒ CÔI: $t"; done # 3. dòng task không màn hình nào nhận
```

Phép đo 3 bắt cả `T-FE-01` (gửi ngược dòng lỗi phạm vi, nhắc ở §2) và **`T-FE-02`** (dựng nền FE: sinh type,
api client, guard, hai layout). Hai dòng đó **không phải màn hình** nên không có hàng ở §1 — chúng được nhắc ở
đây để phép đo vẫn có nghĩa cho 18 dòng còn lại. Thêm dòng task không-phải-màn-hình thứ ba ⇒ nhắc nó ở đây luôn.

---

## 1. Kiểm kê — 21 màn hình trên 20 route

Cột *Chức năng lõi* cố ý **một dòng**: đủ để chọn việc, không đủ để thay wireframe. Cần chi tiết ⇒ mở cột *Nhà thật*.

### 1.1 Client — 8 màn (mobile-first, vai: khách)

| # | Màn hình | Route (wireframe) | Chức năng lõi | Nhà thật | Task dựng |
|---|---|---|---|---|---|
| 1 | Menu | `/(shop)/menu` | Catalog và cart builder; vào bằng quét QR; đọc 4 query, ghi đúng 1 mutation `POST /orders` | [menu_spec.md](../../wireframes/client_menu_page_v2/menu_spec.md) | T-FE-03 |
| 2 | Chi tiết sản phẩm | `/(shop)/menu/product/[id]` | 5 zone 0 modal; topping nhiều lựa chọn, stepper số lượng, nút thêm giỏ sticky đáy | [client_product_detail_wireframe_v1.md](../../wireframes/client_product_detail/client_product_detail_wireframe_v1.md) | T-FE-04 |
| 3 | Yêu thích | `/(shop)/menu/favourites` | Lọc Tất cả · Món lẻ · Combo, chỉnh số lượng inline, thêm tất cả vào giỏ | [client_favourite_page_wireframe_v1.md](../../wireframes/client_favourite_page/client_favourite_page_wireframe_v1.md) | T-FE-05 |
| 4 | Lưu thành set | `/(shop)/menu/favourites/save` | Đặt tên cho tổ hợp món vừa chỉnh, tạo shortcut đặt lại | [client_favourite_page_wireframe_v1.md](../../wireframes/client_favourite_page/client_favourite_page_wireframe_v1.md) | T-FE-05 |
| 5 | Các set của tôi | `/(shop)/menu/favourites/sets` | Liệt kê set đã lưu, đổi tên, xoá, Áp dụng để đổ cả set vào giỏ | [client_favourite_page_wireframe_v1.md](../../wireframes/client_favourite_page/client_favourite_page_wireframe_v1.md) | T-FE-05 |
| 6 | Theo dõi đơn hàng | `/(shop)/order/[id]` | 3 zone realtime SSE: từng món đã ra và còn chờ · bảng tổng hợp · tiền đã dùng so với còn lại; huỷ từng món | [client_order_page_wireframe_v1.md](../../wireframes/client_order_page/client_order_page_wireframe_v1.md) | T-FE-06 |
| 7 | Restaurant Monitor | `/(shop)/tracking` | Bối cảnh chờ: vị trí hàng chờ và ETA · full receipt để soát đơn · hàng chờ chung · sơ đồ bàn | [client_tracking_wireframe_v1.md](../../wireframes/client_tracking/client_tracking_wireframe_v1.md) | T-FE-07 |
| 8 | Thông tin khách hàng | `/(shop)/profile` | Form 4 trường RHF và Zod, badge thành viên, shortcut sang menu và yêu thích | [client_info_page_wireframe_v1.md](../../wireframes/client_info_page/client_info_page_wireframe_v1.md) | T-FE-08 |

### 1.2 Admin — 13 màn trên 12 route (desktop, vai: admin · manager · bếp · phục vụ)

| # | Màn hình | Route (wireframe) | Chức năng lõi | Nhà thật | Task dựng |
|---|---|---|---|---|---|
| 9 | Tổng quan (desktop) | `/admin/overview` | Dashboard điều phối sàn realtime: 4 KPI 30s và WS · prep queue theo bàn · serving tracker tổng-ra-còn · lưới bàn | [admin_overview_wireframe_v1.md](../../wireframes/admin_main/admin_overview/admin_overview_wireframe_v1.md) | T-FE-09 |
| 10 | Tổng quan (mobile) | `/admin/overview` | Biến thể responsive của số 9, không phải route riêng | [admin-overview-mobile.excalidraw](../../wireframes/admin_main/admin_overview/admin-overview-mobile.excalidraw) | T-FE-09 |
| 11 | Tổng kết ngày | `/admin/summary` | 8 khối báo cáo ngày, mọi khối do **một** date picker điều khiển, chặn ngày tương lai | [admin_summary_wireframe_v1.md](../../wireframes/admin_main/admin_summary/admin_summary_wireframe_v1.md) | T-FE-10 |
| 12 | Sản phẩm | `/admin/products` | CRUD món; form dùng chung add và edit; trạng thái Hết hàng là cách tạm ngưng bán | [admin_main_product_wireframe_v1.md](../../wireframes/admin_main/admin_main_product/admin_main_product_wireframe_v1.md) | T-FE-11 |
| 13 | Danh mục | `/admin/categories` | CRUD 2 cột Tên và Thứ tự; Thứ tự quyết định thứ tự hiển thị trên menu khách | [admin_main_categories_wireframe_v1.md](../../wireframes/admin_main/admin_main_categories/admin_main_categories_wireframe_v1.md) | T-FE-12 |
| 14 | Topping | `/admin/toppings` | CRUD món thêm; công tắc Có sẵn và Hết thay cho xoá; giá 0 hiện nhãn Miễn phí | [admin_main_topping_wireframe_v1.md](../../wireframes/admin_main/admin_main_topping/admin_main_topping_wireframe_v1.md) | T-FE-13 |
| 15 | Combo | `/admin/combos` | CRUD combo, tự tính mức tiết kiệm so giá lẻ, tối thiểu 2 món, chỉ admin được xoá | [admin_main_combos_wireframe_v1.md](../../wireframes/admin_main/admin_main_combos/admin_main_combos_wireframe_v1.md) | T-FE-14 |
| 16 | Nhân viên | `/admin/staff` | CRUD tài khoản, 4 KPI suy ra từ chính list, lọc client-side, vô hiệu hoá thay vì xoá | [admin_main_staff_wireframe_v1.md](../../wireframes/admin_main/admin_main_staff/admin_main_staff_wireframe_v1.md) | T-FE-15 |
| 17 | Staff Task Board | `/admin/staff/task-board` | Bảng nhiệm vụ theo người, tỉ lệ hoàn thành và điểm chất lượng, Assign từng dòng, tự làm mới 60s | [admin_main_staff_task_boad_wireframe_v1.md](../../wireframes/admin_main/admin_main_staff_task_boad/admin_main_staff_task_boad_wireframe_v1.md) | T-FE-16 |
| 18 | Staff Task List | `/admin/todo-list` | Checklist theo ngày, staff chỉ thấy việc của mình, tick là lưu ngay, quá hạn tô đỏ | [admin_main_todo_list_wireframe_v1.md](../../wireframes/admin_main/admin_main_todo_list/admin_main_todo_list_wireframe_v1.md) | T-FE-17 |
| 19 | Đào tạo nhân viên | `/admin/training` | Guide card theo vai trò, video YouTube, bảng completion, lịch sử quiz, ghi chú quản lý | [admin_staff_training_wireframe_v1.md](../../wireframes/admin_main/admin_main_training/admin_staff_training_wireframe_v1.md) | T-FE-18 |
| 20 | Kho nguyên liệu | `/admin/storage` | Bảng tồn kho 8 cột, badge Còn hàng và Sắp hết hạn, ngưỡng cảnh báo tự đổi trạng thái | [admin_main_storage_wireframe_v1.md](../../wireframes/admin_main/admin_main_storage/admin_main_storage_wireframe_v1.md) | T-FE-19 |
| 21 | Marketing | `/admin/marketing` | Ngân sách khai trương: 4 KPI, 5 hạng mục chi có thanh tiến độ, donut phân bổ, lộ trình 5 tuần | [admin_main_marketing_wireframe_v1.md](../../wireframes/admin_main/admin_main_marketing/admin_main_marketing_wireframe_v1.md) | T-FE-20 |

---

## 2. Đối chiếu wireframe ↔ prompt-fullstack §3.7 — **đọc trước khi dựng bất kỳ màn nào**

§3.7 khai cây route bằng 4 nhóm. Đặt cạnh 21 màn ở §1, ba nhóm hiện ra:

| Nhóm | Nội dung | Xử lý |
|---|---|---|
| **Khớp cả hai bên** | `(shop)/menu` · `admin/products` · `admin/staff` | Dựng được ngay khi pha 3 xong — đây là lát cắt A |
| **Wireframe có, §3.7 không có** | `menu/favourites` và 2 route con · `order/[id]` · `tracking` · `profile` · `admin/overview` · `admin/summary` · `admin/categories` · `admin/toppings` · `admin/combos` · `admin/staff/task-board` · `admin/todo-list` · `admin/training` · `admin/storage` · `admin/marketing` | **Chưa được dựng** — [F-FE-01](finding_fe.md#f-fe-01). Vẽ xong không có nghĩa là đã chốt phạm vi |
| **§3.7 có, wireframe không có** | `(shop)/` trang chủ · `menu/[slug]` · `cart` · `checkout` · `orders/[code]` · `t/[token]/page` · `t/[token]/bill` · `staff/login` · `staff/pos` · `staff/station/[code]` · `staff/cleaning` · `admin/orders` · `admin/tables` · `admin/reports` · `admin/settings` | Thiếu wireframe ⇒ là **task**, không phải finding — gom vào `T-FE-01` |

Số cụ thể của từng nhóm **cố ý không ghi ở đây** — chúng đổi ngay khi pha 4 chạy.
Dựng lại bằng: `awk '/^### 3\.7/,/^## §4/' project_preparation/prompt-fullstack.md`.

Ba màn ở nhóm *§3.7 có mà wireframe không có* đáng chú ý riêng: `staff/station/[code]` là **màn hình trạm bếp**
và `staff/pos` là **POS quầy** — cả hai đã có flow vẽ sẵn (`admin_kds/flow-kds.excalidraw`, `admin_pos/flow-pos-payment.excalidraw`
theo index) nhưng **thư mục chứa chúng không tồn tại**, xem [F-FE-05](finding_fe.md#f-fe-05).
§3.7 mô tả khá chi tiết hai màn này (cỡ chữ tối thiểu, màu theo thời gian chờ, 3 lần chạm) — dựng được mà chưa cần vẽ lại.

---

## 3. Thư mục con

`admin/` và `client/` giữ **tài liệu thiết kế của từng màn**, sinh ra **khi task dựng màn đó bắt đầu**, không sớm hơn —
file rỗng dựng sẵn là file phải bảo trì mà chưa giữ sự thật nào ([CLAUDE.md §4](../../CLAUDE.md)).
Đặt tên đúng bằng route, thay `/` bằng `-`: `client/menu.md` · `client/order-id.md` · `admin/products.md`.
