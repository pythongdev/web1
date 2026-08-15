# finding_fe.md — sổ lỗi chặn việc dựng FE

> Cập nhật **2026-08-15** · Lane sở hữu: **FE** · Khuôn: [finding_guiline.md](../../project_preparation/finding_guiline.md)
> Hàng đợi của lane: [task_fe.md](task_fe.md) · Kiểm kê màn hình: [README.md](README.md)

**Cửa vào.** Sổ này nhận **mệnh đề sai được đang chặn việc dựng FE**. Phép thử trước khi viết dòng nào:
chạy hết kế hoạch **y như nó viết** — dòng này còn không? Còn ⇒ vào đây. Mất ⇒ nó là **task**, sang [task_fe.md](task_fe.md).
Câu mở đầu bằng *"chưa có X"* gần như luôn là task: *"15 route trong §3.7 chưa có wireframe"* đã bị đẩy sang `T-FE-01`,
không nằm ở sổ này.

**Cột `Lane`** ghi lane **đóng được** dòng đó, không phải lane phát hiện. Sáu trong tám dòng dưới đây do lane khác đóng —
FE chỉ được **báo và chờ**, chạm file lane khác kể cả một dòng là vi phạm [CLAUDE.md §4](../../CLAUDE.md).

**Phép đo sức khoẻ sổ** (chạy từ gốc repo, cả hai phải rỗng):

```sh
for f in $(grep -E '^\| \[F-FE-[0-9]+\]' design/fe/finding_fe.md | grep 'ĐÓNG' | awk -F'|' '{print $2}' | grep -oE 'F-FE-[0-9]+'); do
  awk -v id="### $f" '$0==id{p=1;next} /^### F-FE-/{p=0} p' design/fe/finding_fe.md | grep -q 'Bài học giữ lại' || printf '%s ' "$f"
done; echo                                                    # đóng mà không để lại bài học
awk '/^### F-FE-/{getline; if (/✅ ĐÓNG|🔓 MỞ|⚠️ MỞ LẠI/) print NR}' design/fe/finding_fe.md   # trạng thái ghi ngoài cột
```

---

## Bảng tổng hợp

| ID | Mức | Finding | Lane | Trạng thái | Chặn việc gì | Context |
|---|---|---|---|---|---|---|
| [F-FE-01](#f-fe-01) | 🟠 | `prompt-fullstack §3.7` và `wireframes/` khai **hai cây route khác nhau** cho cùng một sản phẩm | BA | 🔓 MỞ | 14 trên 20 dòng `task_fe.md` | **Nạp:** [README §2](README.md) · prompt-fullstack §3.7 · **Đã chốt:** §3.7 thắng cho tới khi `plan/4-fe.md` chạy xong, nên bên thua là wireframe · **Đóng đúng:** §3.7 và README §2 khai cùng một tập route, dò bằng lệnh ở README rồi dán output · **Bẫy:** đóng bằng cách chép cây route wireframe đè lên §3.7 là chốt phạm vi mà chủ quán chưa đọc thành lời |
| [F-FE-02](#f-fe-02) | 🟡 | Màn chi tiết món được khai **hai route**: §3.7 ghi `menu/[slug]`, wireframe ghi `/(shop)/menu/product/[id]` | BA | 🔓 MỞ | `T-FE-04` | **Nạp:** §3.7 · [client_product_detail_wireframe_v1.md](../../wireframes/client_product_detail/client_product_detail_wireframe_v1.md) · **Đã chốt:** `slug` và `id` là hai khoá tra khác nhau, không phải khác cách viết · **Đóng đúng:** một route duy nhất còn lại ở cả hai nơi, `grep -c 'menu/\[slug\]' project_preparation/prompt-fullstack.md` và `grep -rc 'menu/product' wireframes` không cùng khác 0 · **Bẫy:** chọn `slug` thì phải chốt nguồn sinh slug cho món tiếng Việt có dấu, đó mới là phần đắt |
| [F-FE-03](#f-fe-03) | 🟠 | `/admin/staff/task-board` và `/admin/todo-list` là **hai màn cho một nghiệp vụ** — cùng đọc `GET /admin/tasks`, cùng khai phân công và theo dõi nhiệm vụ | BA | 🔓 MỞ | `T-FE-16` · `T-FE-17` | **Nạp:** hai `business_description.md` của hai thư mục · **Đã chốt:** cả hai đều khai vai Quản lý tạo việc và Nhân viên tự tick, khác nhau ở dạng bảng có điểm chất lượng so với checklist · **Đóng đúng:** một trong hai bị gỡ khỏi kiểm kê README §1, hoặc hai bên có mô tả nói rõ **vì sao cần cả hai** và ai dùng cái nào · **Bẫy:** giữ cả hai vì *"đã vẽ rồi"* là lý do rẻ nhất và đắt nhất — nó nhân đôi vĩnh viễn chi phí sửa nghiệp vụ task |
| [F-FE-04](#f-fe-04) | 🟡 | Cùng một endpoint được viết **hai dạng** trong cùng thư mục wireframe: `:id` so với `{id}`, có so với không có tiền tố `/api/v1` | BE | 🔓 MỞ | `T-FE-02` | **Nạp:** lệnh trích endpoint ở mục chi tiết · **Đã chốt:** hợp đồng thật là `plan/3-be.md`, wireframe chỉ là **đề xuất** · **Đóng đúng:** `plan/3-be.md` khai đúng một dạng, và type FE **sinh** từ đó chứ không gom từ wireframe · **Bẫy:** đừng đi sửa wireframe cho khớp — đó là chữa triệu chứng ở nhà không phải nhà của sự thật này |
| [F-FE-05](#f-fe-05) | 🟡 | `wireframes/shared/WIREFRAME_INDEX.md` trỏ tới **những đích không tồn tại** và khai `Pages (21)` trong khi bảng của nó có ít dòng hơn thế | NON-CODE | 🔓 MỞ | Mọi session dùng index để định vị | **Nạp:** [WIREFRAME_INDEX.md](../../wireframes/shared/WIREFRAME_INDEX.md) · **Đã chốt:** danh sách đích gãy **lấy bằng lệnh** ở mục chi tiết, đừng chép vào dòng này; số 21 là **số trần trụi** đúng loại `T-15` đang dựng phép đo để bắt · **Đóng đúng:** lệnh dò link ra rỗng, và dòng `Pages (N)` thay bằng lệnh đếm · **Bẫy:** đừng tạo thư mục rỗng cho khớp link — link trỏ tới thứ không mang sang thì ghi thẳng là không mang sang |
| [F-FE-06](#f-fe-06) | 🟡 | `client_menu_page_v2/README.md` khai hai file ảnh và excalidraw **vẫn nằm ở thư mục cũ**, nhưng thư mục cũ không còn tồn tại | NON-CODE | 🔓 MỞ | `T-FE-03` khi cần bản vẽ UX mới nhất | **Nạp:** [README.md của v2](../../wireframes/client_menu_page_v2/README.md) mục *Visual assets* · **Đã chốt:** hai file được nêu đích danh là `menu_ver3_ux.excalidraw` và `menu_ver1_done.png` · **Đóng đúng:** hoặc hai file có mặt và lệnh dò ra rỗng, hoặc dòng khai được sửa thành *(không mang sang)* · **Bẫy:** `menu_spec.md` tự khai `assets:` trỏ cùng hai file ở frontmatter — sửa một chỗ mà quên chỗ kia thì lệnh vẫn đỏ |
| [F-FE-07](#f-fe-07) | 🟡 | Toàn bộ `wireframes/` **chưa được git theo dõi**, trong khi `design/fe/` vừa đặt link cứng vào nó | NON-CODE | 🔓 MỞ | Mọi dòng `task_fe.md` có link tới wireframe | **Nạp:** `git status --short` · **Đã chốt:** thư mục đang ở trạng thái `??`, tức **không có điểm lùi** — sửa hỏng là mất, và [CLAUDE.md §3](../../CLAUDE.md) bắt có điểm lùi trước khi sửa · **Đóng đúng:** `git ls-files wireframes` in ra khác rỗng · **Bẫy:** thư mục có `.excalidraw` và `.png` nặng — commit mù cả cụm là chuyện một chiều, phải xem `du -sh` trước |
| [F-FE-08](#f-fe-08) | 🟠 | [task.md](../../task.md) khai `design/<lane>/` và sổ finding là **"Chưa mở"**, trong khi cả hai đã tồn tại và đang được dùng | NON-CODE | 🔓 MỞ | Độ tin của bản đồ, không chặn task nào | **Nạp:** `task.md` mục *Chưa mở* · **Đã chốt:** mở sớm là **quyết định của owner**, không phải lỗi; dòng sai là dòng bản đồ chưa chạy theo · **Đóng đúng:** mục *Chưa mở* không còn nhắc `design/<lane>/` và sổ finding, và [CLAUDE.md §2](../../CLAUDE.md) trỏ đúng nhà mới · **Bẫy:** `task.md` và `CLAUDE.md` **đang `M` chưa commit** — sửa lúc này là sửa chồng lên việc dở của session khác. Chờ commit sạch rồi mới chạm |

---

## Chi tiết

### F-FE-01

**Mệnh đề:** `prompt-fullstack §3.7` và `wireframes/` khai hai cây route khác nhau cho cùng một sản phẩm — 🟠 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
awk '/^### 3\.7/,/^## §4/' project_preparation/prompt-fullstack.md | sed -n '3,8p'
#   (shop)/  page · menu · menu/[slug] · cart · checkout · orders/[code]
#   t/[token]/  page · bill
#   staff/   login (PIN) · pos · station/[code] · cleaning
#   admin/   orders · products · tables · staff · reports · settings
find wireframes -name '*wireframe_v1.md' -o -name 'menu_spec.md' | wc -l   # số màn có wireframe
```

Đặt cạnh nhau: §3.7 khai nhóm `admin/` gồm `orders` · `tables` · `reports` · `settings` — **không thư mục
wireframe nào** mang bốn tên đó. Ngược lại wireframe có `overview` · `summary` · `categories` · `toppings` ·
`combos` · `staff/task-board` · `todo-list` · `training` · `storage` · `marketing` — **không tên nào** có trong §3.7.
Bên khách cũng vậy: §3.7 có `cart` · `checkout` · `orders/[code]` · `t/[token]`, wireframe có
`menu/favourites` · `tracking` · `profile`. Danh sách đầy đủ ở [README §2](README.md).

**Vì sao là lỗi hệ thống, không phải lỗi người vẽ:** wireframe được vẽ theo từng màn, mỗi màn một thư mục,
và **không có bước nào bắt đối chiếu ngược lên cây route**. Khuôn thư mục [FOLDER_STANDARD.md](../../wireframes/template/FOLDER_STANDARD.md)
định nghĩa *một thư mục cần những file gì*, không định nghĩa *tập thư mục phải khớp với cái gì*. Thiếu đúng
một phép đối chiếu ở giữa, nên hai bên trôi xa nhau mà không lệnh nào đỏ.

**Hậu quả thật:** 14 trên 20 dòng ở [task_fe.md](task_fe.md) đang trỏ vào màn **chưa được phép dựng**. Dựng theo
wireframe rồi pha 4 chốt khác là **vứt cả 14 màn**; dựng theo §3.7 thì vứt phần lớn công vẽ. Đây là loại lỗi
chỉ đắt lên theo thời gian, và nó **đang** đắt lên.

**Cách sửa đề xuất:** chạy `T-FE-01` — gửi ngược một dòng lỗi phạm vi về pha 3 theo đúng cơ chế §3.7 tự khai
(*"cần đổi ⇒ ghi thành một dòng lỗi gửi ngược về pha 3"*), liệt kê từng route kèm câu hỏi chốt. BA quyết,
FE không tự chọn.

**Đóng đúng + Bẫy:** đóng khi §3.7 và [README §2](README.md) khai cùng một tập route và lệnh dò ở README ra rỗng.
Bẫy: chép cây route của wireframe đè lên §3.7 cho nhanh — làm thế là **chốt phạm vi thay chủ quán**, y hệt kiểu hỏng
mà `T-04` và `T-16` đang cẩn thận tránh với 6 con số giá.

---

### F-FE-02

**Mệnh đề:** màn chi tiết món được khai hai route khác nhau — 🟡 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
grep -o 'menu/\[slug\]' project_preparation/prompt-fullstack.md          # → menu/[slug]
grep -rho '(shop)/menu/product/\[id\]' wireframes | sort -u              # → (shop)/menu/product/[id]
```

**Vì sao là lỗi hệ thống:** hai tài liệu được viết ở hai thời điểm cho hai mục đích (kế hoạch so với bản vẽ
as-built của repo khác), và **không có nơi nào giữ danh sách route đã chốt** để cả hai cùng trỏ về. Kiểm kê
[README §1](README.md) vừa dựng chính là chỗ trống đó.

**Hậu quả thật:** `slug` và `id` là hai khoá tra khác nhau — chọn sai thì hợp đồng API, kiểu dữ liệu và mọi link
đã phát ra ngoài đều phải làm lại. Link đã in lên tờ rơi hay mã QR thì **không thu về được**.

**Cách sửa đề xuất:** gộp vào `T-FE-01` như một dòng câu hỏi riêng, đừng mở task thứ hai cho cùng một lần gửi ngược.

**Đóng đúng + Bẫy:** đóng khi chỉ còn một dạng route sống ở cả hai nơi. Bẫy: chọn `slug` là chọn thêm việc —
phải chốt cách sinh slug cho tên món tiếng Việt có dấu và cách xử lý trùng tên, phần đó đắt hơn bản thân việc đổi route.

---

### F-FE-03

**Mệnh đề:** `/admin/staff/task-board` và `/admin/todo-list` là hai màn cho một nghiệp vụ — 🟠 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
grep -rho 'GET /admin/tasks' wireframes/admin_main/admin_main_staff_task_boad wireframes/admin_main/admin_main_todo_list | sort | uniq -c
grep -l 'phân công' wireframes/admin_main/admin_main_staff_task_boad/business_description.md wireframes/admin_main/admin_main_todo_list/business_description.md
```

Cả hai `business_description.md` đều khai đúng một cặp vai: **Quản lý tạo và giao việc**, **Nhân viên tự đánh dấu
hoàn thành**. Khác biệt thật chỉ là hình thức trình bày — bảng có tỉ lệ hoàn thành và điểm chất lượng, so với
checklist có checkbox và cảnh báo quá hạn.

**Vì sao là lỗi hệ thống:** hai thư mục được mở cách nhau một ngày (`created: 2026-05-26` và `2026-05-27`) và
khuôn thư mục **không có ô nào hỏi "nghiệp vụ này đã có màn chưa"**. Thiếu bước đó thì mỗi lần vẽ thêm một màn
là một lần có thể trùng, và không ai biết cho tới khi ngồi đếm endpoint.

**Hậu quả thật:** dựng cả hai là **hai lần chi phí dựng và vĩnh viễn hai lần chi phí sửa** cho mọi thay đổi nghiệp vụ
task về sau. Tệ hơn: hai màn cùng ghi vào một nguồn thì trạng thái hiển thị có thể lệch nhau, và người dùng
sẽ tin màn nào họ mở gần nhất.

**Cách sửa đề xuất:** BA chọn một trong hai làm màn chính và hạ màn kia xuống thành **một chế độ xem** của nó
(hoặc gỡ hẳn). Ghi quyết định vào `T-FE-01` cùng lần gửi ngược, đừng mở kênh thứ hai.

**Đóng đúng + Bẫy:** đóng khi một trong hai bị gỡ khỏi kiểm kê [README §1](README.md), hoặc cả hai có dòng
nói rõ **ai dùng cái nào và vì sao cần cả hai**. Bẫy: giữ cả hai vì *"đã vẽ rồi"* — công vẽ là chi phí đã chìm,
chi phí bảo trì thì chưa.

---

### F-FE-04

**Mệnh đề:** cùng một endpoint được viết hai dạng trong cùng thư mục wireframe — 🟡 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
grep -rhoE '(GET|POST|PATCH|PUT|DELETE) /[a-zA-Z0-9/_:{}.-]+' wireframes/client_order_page --include='*.md' | sort -u
#   DELETE /orders/items/:id      và  DELETE /orders/items/{id}
#   GET /orders/:id/events        và  GET /orders/{id}/events
grep -rhoE 'GET /(api/v1/)?admin/staff' wireframes/admin_main/admin_main_staff --include='*.md' | sort -u
```

**Vì sao là lỗi hệ thống:** wireframe được phép ghi endpoint **đề xuất**, nhưng không file nào trong `wireframes/`
khai rằng chúng là đề xuất — nên chúng đọc như hợp đồng. Nhà thật của hợp đồng (`plan/3-be.md`) **chưa tồn tại**,
và khoảng trống đó hút mọi người về phía nguồn cụ thể nhất đang có.

**Hậu quả thật:** nếu `T-FE-02` gom type từ wireframe, FE sẽ có hai kiểu cho một endpoint và lỗi chỉ lộ ra lúc
chạy thật. Đây đúng loại lỗi mà biên nhận *"type sinh từ hợp đồng API"* của lane FE sinh ra để chặn.

**Cách sửa đề xuất:** không sửa wireframe. Chốt một dạng ở `plan/3-be.md` (`T-08`), sinh type từ đó, và thêm
một dòng ở đầu mỗi `tech_description.md` khai rõ endpoint trong wireframe là **đề xuất**.

**Đóng đúng + Bẫy:** đóng khi `plan/3-be.md` khai đúng một dạng và type FE sinh ra từ đó. Bẫy: đi sửa 18 thư mục
wireframe cho khớp — sửa ở nhà không phải nhà của sự thật này, và sẽ lệch lại ngay lần đổi hợp đồng đầu tiên.

---

### F-FE-05

**Mệnh đề:** `WIREFRAME_INDEX.md` trỏ tới những đích không tồn tại và khai số trang sai so với chính bảng của nó — 🟡 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được** (output dưới đây chụp lúc `git status` còn báo `?? wireframes/`, xem [F-FE-07](#f-fe-07)):

```sh
cd wireframes && grep -oE '\]\([^)]+\)' shared/WIREFRAME_INDEX.md | sed 's#^](##; s#)$##' \
  | while read p; do [ -e "$p" ] || echo "GÃY: $p"; done
#   GÃY: client_menu_page/menu_wireframe_v1.md
#   GÃY: client_menu_page/menu_ver3_ux.excalidraw
#   GÃY: admin_kds/flow-kds.excalidraw
#   GÃY: admin_pos/flow-pos-payment.excalidraw
#   GÃY: full_system_jounery/flow-full-system-journey.excalidraw
grep -c '^| [0-9]* | ' shared/WIREFRAME_INDEX.md      # số dòng thật, so với chữ "Pages (21)" ở đầu file
```

Đích thứ năm là loại khác ba đích đầu: file **có tồn tại** nhưng ở `shared/flow-full-system-journey.excalidraw`,
index trỏ nhầm thư mục. Đích thứ nhất và thứ hai cùng một nguyên nhân với [F-FE-06](#f-fe-06).

**Vì sao là lỗi hệ thống:** index là **nhà thứ hai** của một sự thật suy ra được (*"repo có những màn nào"*).
Thư mục đổi tên hoặc bị gỡ thì index không có cách nào biết — đúng khuôn *dời file đẻ con trỏ gãy* mà
[task_guiline §6](../../project_preparation/task_guiline.md) ghi là đã lặp 5 lần ở dự án trước.

**Hậu quả thật:** session mới định vị bằng index sẽ mở file không tồn tại rồi tự suy diễn, và bịa thì trông
hệt như làm đúng. Con số `21` trong khi bảng có 19 dòng làm mọi phép kiểm dựa vào nó nói dối cả hai chiều.

**Cách sửa đề xuất:** sửa từng đích lệnh dò in ra; thay dòng `Pages (21)` bằng **lệnh đếm**, không phải bằng số mới.
Khi `make check` (`T-02`) có mặt thì gắn lệnh dò trên vào đó.

**Đóng đúng + Bẫy:** đóng khi lệnh dò ra rỗng và không còn số trần trụi trong file. Bẫy: `mkdir admin_kds`
cho khớp link — thư mục rỗng làm lệnh xanh trong khi sự thật vẫn thiếu, tức là làm hỏng chính phép đo.

---

### F-FE-06

**Mệnh đề:** `client_menu_page_v2/README.md` khai hai asset nằm ở thư mục cũ, nhưng thư mục cũ không còn — 🟡 *(session đọc wireframes, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
ls wireframes/client_menu_page 2>&1                  # → No such file or directory
grep -n 'client_menu_page/' wireframes/client_menu_page_v2/README.md wireframes/client_menu_page_v2/menu_spec.md
```

**Vì sao là lỗi hệ thống:** đợt gộp v2 cố ý **không nhân bản binary** (lý do đúng: file nặng), nhưng quyết định đó
biến thư mục cũ thành **phụ thuộc cứng** mà không dòng nào ghi *"cấm xoá"*. Phụ thuộc không được khai thì sớm muộn bị dọn.

**Hậu quả thật:** bản vẽ UX mới nhất của màn Menu — màn đắt nhất và là màn duy nhất có spec canonical — hiện
**không mở được**. `T-FE-03` sẽ phải dựng theo mô tả chữ.

**Cách sửa đề xuất:** tìm lại hai file trong lịch sử git hoặc bản sao ngoài repo; không còn thì sửa cả hai dòng khai
(`README.md` mục *Visual assets* và frontmatter `assets:` của `menu_spec.md`) thành *(không mang sang)*.

**Đóng đúng + Bẫy:** đóng khi lệnh `grep -n 'client_menu_page/'` ở trên không còn trỏ tới đích không tồn tại.
Bẫy: hai chỗ khai, sửa một chỗ thì lệnh vẫn đỏ — và người sửa hay chỉ nhớ `README.md`.

---

### F-FE-07

**Mệnh đề:** `wireframes/` chưa được git theo dõi trong khi `design/fe/` vừa đặt link cứng vào nó — 🟡 *(session dựng design/fe, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
git status --short | grep wireframes        # → ?? wireframes/
git ls-files wireframes | wc -l             # → 0
du -sh wireframes                           # xem trước khi commit, thư mục có .excalidraw và .png
```

**Vì sao là lỗi hệ thống:** thư mục được thả vào repo và dùng ngay như nguồn tra cứu, nhưng bước *đưa vào theo dõi*
không nằm trong quy trình nào cả — [CLAUDE.md §3](../../CLAUDE.md) bắt có điểm lùi trước khi **sửa**, không nói gì
về nội dung **chưa từng được commit lần nào**.

**Hậu quả thật:** [README.md](README.md) và [task_fe.md](task_fe.md) vừa đặt hàng chục link cứng vào nội dung
không có điểm lùi. Một lệnh dọn nhầm là mất cả 18 thư mục bản vẽ, và toàn bộ lane FE mất nguồn.

**Cách sửa đề xuất:** NON-CODE xem `du -sh` trước, quyết định đưa `.md` vào theo dõi ngay và xử lý binary riêng
(theo dõi luôn, hoặc để ngoài repo kèm một dòng khai chỗ để). Commit `git add` từng đường dẫn, cấm `-A`.

**Đóng đúng + Bẫy:** `git ls-files wireframes | wc -l` khác `0`. Bẫy: `git add wireframes/` một phát cho xong —
kéo theo `.DS_Store` và cả thư mục `trash/` vào lịch sử vĩnh viễn.

---

### F-FE-08

**Mệnh đề:** `task.md` khai `design/<lane>/` và sổ finding là *"Chưa mở"*, trong khi cả hai đã tồn tại và đang được dùng — 🟠 *(session dựng design/fe, 2026-08-15)*

**Bằng chứng chạy được:**

```sh
grep -n 'Chưa mở' -A 4 task.md              # còn khai design/<lane>/ và finding.md chưa mở
ls design/fe/*.md                           # → README.md  finding_fe.md  task_fe.md
```

**Vì sao là lỗi hệ thống:** mục *Chưa mở* mô tả **ý định**, và ý định không tự cập nhật khi owner đổi ý.
`task.md` khai điều kiện mở là *"pha tương ứng chạy xong"*; owner mở sớm hơn — hợp lệ, nhưng bản đồ chưa chạy theo.

**Hậu quả thật:** [CLAUDE.md](../../CLAUDE.md) dòng 3 xếp *lệch với nhà thật* là **bug phải sửa ngay**. Session sau
đọc `task.md` sẽ kết luận lane FE chưa có sổ nào, rồi dựng sổ thứ hai — đúng kiểu hỏng mà cả hai guiline cảnh báo.
Thêm một vế: `CLAUDE.md §2` vẫn khai `finding.md (chưa mở)` là nhà của *cái đang sai bây giờ*.

**Cách sửa đề xuất:** NON-CODE sửa **hai** chỗ trong **cùng một** commit — mục *Chưa mở* của `task.md` và dòng
`finding.md` ở bảng §2 của `CLAUDE.md` — trỏ sang sổ theo lane. Kèm một dòng khai luật: `task.md` giữ đường găng
liên lane, `design/<lane>/task_<lane>.md` giữ task trong lane, không dòng nào chép sang dòng nào.

**Đóng đúng + Bẫy:** `grep -c 'design/<lane>/' task.md` ra `0` ở mục *Chưa mở*, và `CLAUDE.md §2` trỏ đúng nhà mới,
với `wc -l < CLAUDE.md` vẫn `≤ 60`. Bẫy: **cả hai file đang `M` chưa commit** — sửa lúc này là chồng lên việc dở
của session khác. Chờ commit sạch. Và `CLAUDE.md §5` cấm thêm mục: phải **thay hoặc gộp** chữ cũ.
