# task.md — hàng đợi "xong / chưa"

> Cập nhật **2026-08-15** · Khuôn: [task_guiline.md](project_preparation/task_guiline.md) · Kế hoạch gốc: [prompt-fullstack.md](project_preparation/prompt-fullstack.md)

**Làm gì tiếp — lấy ra bằng lệnh, đừng đọc từ trên xuống:**

```sh
grep -n '^| \*\*T-' task.md | grep '🔺' | head -1                      # 1. cờ chặn — làm trước mọi thứ
grep -n '^| \*\*T-' task.md | grep '⛓' | head -1                       # 2. đường găng — task chưa gạch đầu tiên
grep -o '^| \*\*T-[0-9]*\*\* ⚑[0-9]' task.md | sort -k3                # 3. việc ngoài đường găng, thứ tự owner chọn
awk -F'|' '/^\| (~~)?\*\*T-/ && NF < 8 { print $2 }' task.md           # dòng thiếu cột bắt buộc — phải rỗng
grep -c '^| \*\*T-\|^| ~~\*\*T-' task.md                               # tổng số dòng task
```

**Đường găng:** T-05 → T-06 → T-07 → T-08 → T-09 → T-10 (6 pha kế hoạch). Trượt là trượt ngày lên sóng.
Hết cả ba tầng trên mới đọc theo thứ tự file — **thứ tự file ≠ thứ tự ưu tiên**.

---

## Bảng task

| # | Lane | Task | Context | Cần xong trước | Đầu ra kiểm chứng được |
|---|------|------|---------|----------------|------------------------|
| **T-04** 🔺 | BA | Đọc to 6 số suất trứng / suất giò cho chủ quán xác nhận, rồi thay khối `GIẢ ĐỊNH` ở [§3.2](project_preparation/prompt-fullstack.md) bằng số đã chốt | **Nạp:** prompt-fullstack §3.2 (khối ⚠️ in nghiêng) · **Đã chốt:** luật *giá = tổng thành phần* đã đúng 3/3 trên combo · **Bẫy:** chủ quán có quyền bán suất rẻ hơn tổng thành phần để kéo khách — hỏi, đừng suy ra | — | `grep -c 'GIẢ ĐỊNH' project_preparation/prompt-fullstack.md` → `0`, và 6 số trong §3.2 kèm dòng `✅ chốt <ngày>` |
| **T-01** ⚑1 | NON-CODE | Viết `README.md`: cách chạy + **con trỏ** tới nhà của luật nghiệp vụ | **Nạp:** [07 §2, §8](project_preparation/07-cau-truc-du-an.md) · **Đã chốt:** prompt-fullstack §3–§4 **là nhà của sự thật** cho phạm vi/giá/hợp đồng API cho tới khi pha tương ứng chạy xong · **Bẫy:** chép bảng giá hay 11 ràng buộc §4 vào README là đẻ nhà thứ hai — đặt link | — | `grep -c 'prompt-fullstack.md' README.md` ≥ 1 **và** `grep -c '3\.000\|4\.000\|26\.000' README.md` → `0` (không chép bảng giá) |
| **T-02** ⚑2 | DevOps | Viết `Makefile` với 2 target: `make check` (link chết + đếm cột `task.md`) và `make status` | **Nạp:** [07 §4](project_preparation/07-cau-truc-du-an.md) phép 1 + 4 · **Đã chốt:** Makefile là **nhà duy nhất của mọi lệnh**, CI gọi lại chứ không chép · **Bẫy:** [07 §4](project_preparation/07-cau-truc-du-an.md) — quét `0*.md`, **không** quét `*.md`, vì file hướng dẫn chứa đúng chuỗi đang tìm và sẽ tự bắt chính mình (`F-60` đời trước) | — | `make check; echo $?` → `0` · `make status` in ra: số commit · số file `.md` · số dòng task chưa gạch |
| **T-03** ⚑3 | NON-CODE | Sửa 6 con trỏ gãy trong `project_preparation/` (trỏ sang repo cũ) | **Nạp:** đầu ra `make check` của T-02 · **Đã chốt:** `../CLAUDE.md` · `../task.md` · `../finding.md` · `../design/data_base/README.md` · `06-lich-su-du-an.md` · `finding.md` **không tồn tại ở repo này** · **Bẫy:** đừng tạo file rỗng cho khớp link — link nào trỏ tới bài học đời trước thì ghi thẳng *(repo cũ, không mang sang)*; link `../task.md` thì trỏ về [task.md](task.md) thật | T-02 | `make check` → **0 dòng link chết** |
| **T-05** ⛓ | BA | Chạy **Pha 0 · BA**, xuất `plan/0-ba.md` | **Nạp:** prompt-fullstack §1→§10 làm prompt hệ thống · **Đã chốt:** đầu ra là **kế hoạch, không phải code**; nhiệt độ 0.1–0.3; khuôn xuất ở §8 · **Bẫy:** §4.11 cấm nhảy pha — pha 0 **không** nhắc tên bảng | T-04 | `plan/0-ba.md` có đủ 7 mục §8 (`grep -c '^\(PHA\|CHỐT XONG\|MASTER TASK\|CỔNG CHẤT LƯỢNG\|RỦI RO\|CÒN LẠI\)' plan/0-ba.md` ≥ 6) **và** `grep -c '^| T-' plan/0-ba.md` ≤ 12 |
| **T-06** ⛓ | BA | Chạy **Pha 1 · System design**, xuất `plan/1-system-design.md` | **Nạp:** prompt-fullstack §6.2 (bảng bất biến I1–I10) + §10 · **Đã chốt:** I1 phải gồm cả trạng thái `billing`, thiếu là **thu thiếu tiền** · **Bẫy:** pha này hỏng ra tiền — chạy **riêng một session**, không ghép với pha khác (§11) | T-05 | `plan/1-system-design.md` có bảng bất biến **đủ 3 cột** cho I1–I10; bất biến nào chưa có cơ chế bảo vệ phải mang dấu ⚠️ ngay trong bảng |
| **T-07** ⛓ | DB | Chạy **Pha 2 · DB**, xuất `plan/2-db.md` | **Nạp:** prompt-fullstack §3.5 (16 bảng, 9 chi tiết không được bỏ) + bảng bất biến từ T-06 · **Đã chốt:** tiền lưu `INT` VND; migration chỉ thêm mới · **Bẫy:** §4.11 — pha 2 **không** nhắc endpoint | T-06 | `plan/2-db.md` có **query đối chiếu cho từng bất biến** I1–I10 (`grep -c 'I[0-9]' plan/2-db.md` ≥ 10) + thứ tự migration + dữ liệu mồi menu thật |
| **T-08** ⛓ | BE | Chạy **Pha 3 · BE**, xuất `plan/3-be.md` | **Nạp:** prompt-fullstack §3.6 (danh sách endpoint) + §9.3 (19 ca giá) · **Đã chốt:** giá tính ở **một hàm duy nhất** dùng chung cho `quote` và `create order`; FE không bao giờ gửi giá · **Bẫy:** hệ số phụ thu suất trứng là **×5**, không phải ×4 — hardcode ×4 là thu thiếu 1.000đ mỗi suất | T-07 | `plan/3-be.md` có bảng ca test **đủ 19 ca §9.3**, trong đó **2 ca cuối phải LỖI** (`grep -c 'LỖI' plan/3-be.md` ≥ 2) |
| **T-09** ⛓ | FE | Chạy **Pha 4 · FE**, xuất `plan/4-fe.md` | **Nạp:** prompt-fullstack §3.7 (cây route + nguyên tắc UI) + §3.2b (bước chọn canh ở giỏ hàng) · **Đã chốt:** type **sinh từ hợp đồng API**, không gõ tay · **Bẫy:** §4.11 — pha 4 **không** đổi hợp đồng API; cần đổi ⇒ ghi thành một dòng lỗi gửi ngược về pha 3 | T-08 | `plan/4-fe.md` có cây route khớp §3.7 **và** nói rõ nguồn dữ liệu từng màn; ô nhập số cái của bánh cuốn lẻ là **ô gõ tự do**, không phải +/− |
| **T-10** ⛓ | DevOps | Chạy **Pha 5 · Deploy & vận hành**, xuất `plan/5-deploy.md` | **Nạp:** prompt-fullstack §6.6, §6.8, §6.9 · **Đã chốt:** BE chỉ **1 instance** (SSE giữ kết nối trong bộ nhớ process); **không deploy trong giờ bán 6h–11h** · **Bẫy:** backup chưa restore thử **không phải** backup | T-09 | `plan/5-deploy.md` có checklist trước deploy + **quy trình restore đã diễn tập** + quy trình sự cố kèm sổ giấy |
| **T-11** ⛓ | NON-CODE | Gom master task của cả 6 pha vào bảng này, mở thêm cột theo bảng kích hoạt | **Nạp:** `plan/*.md` mục `MASTER TASK` · **Đã chốt:** đây là **một** hàng đợi duy nhất; trả lời nằm trong khung chat thì pha sau không đọc lại được (§11) · **Bẫy:** mã `T-xx` **không bao giờ tái sử dụng** — đánh tiếp từ T-13 | T-10 | Mọi dòng `^| T-` trong `plan/*.md` có mặt trong `task.md` (lệnh dò ra rỗng) **và** `make check` → `0` |
| **T-12** ⚑4 | DevOps | Dựng `docker-compose.yml` dev: MySQL 8.4 + Go 1.26 + Next.js 16 + Caddy 2.11, endpoint `/healthz` | **Nạp:** prompt-fullstack §3.4 (stack + cổng đã chốt) · **Đã chốt:** BE `8080` · MySQL `3306` · FE `3000`; `Asia/Ho_Chi_Minh` ở **cả 4 chỗ** · **Bẫy:** lệch múi giờ ⇒ logic 6h–11h sai 7 tiếng, và lỗi này không báo gì cả | — | `docker compose up -d && curl -s -o /dev/null -w '%{http_code}' localhost:8080/healthz` → `200` · `docker compose exec db mysql -Ne "SELECT @@time_zone"` → `+07:00` |

---

## Luật đọc bảng này

- **Cột `#`**: `| **T-07** |` = đang mở · `| ~~**T-07**~~ ✅ |` = đã xong. Không có cột *Trạng thái* — nó suy ra được (`grep`).
  Mã task **không bao giờ tái sử dụng**, kể cả khi dòng bị huỷ.
- **Cột Context** đúng ba mẩu: `Nạp:` · `Đã chốt:` · `Bẫy:`. Cột này **không** được nói "thế nào là xong" — vế đó là của cột *Đầu ra*.
- **Cột Đầu ra** phải là **lệnh**, không phải tính từ. Sửa lỗi ⇒ **đỏ trên code cũ, xanh trên code mới**, dán cả hai output.
- **Kích cỡ một dòng:** 1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một session. Vượt ⇒ **chẻ trước khi làm**.
- **Đánh dấu xong cần đủ 3 thứ:** biên nhận chạy thật kèm output · commit chứa thay đổi · gạch dòng ở đây kèm ngày. Thiếu một ⇒ vẫn là *đang làm*.
- **Prompt mở session** — cố ý **không** làm thành cột (điền trước cả bảng là 78 ô phải sửa tay mỗi lần đổi luật). Dùng mẫu 1 dòng:
  `Nhiệm vụ: <ô Task>. Nạp: <ô Context>. Phạm vi: <file được chạm>. Xong khi: <ô Đầu ra>.`

## Vì sao bảng có 6 cột, không phải 3 và không phải 8

[07 §6](project_preparation/07-cau-truc-du-an.md) nói ngày 1 chỉ cần 3 cột. Ba cột thêm vào đây đều có dấu hiệu kích hoạt **đã xảy ra**, ghi lại lý do để dự án sau khỏi chép mù:

| Cột thêm | Dấu hiệu đã kích hoạt |
|---|---|
| **Lane** | Kế hoạch có sẵn 5 lane từ ngày 1 (BA · DB · BE · FE · DevOps — prompt-fullstack §7), và biên nhận của 5 lane là 5 lệnh khác nhau |
| **Context** | Mỗi pha do một session **chưa từng đọc repo** chạy, và phải nạp đúng mục của một file 611 dòng |
| **Cần xong trước** | 6 pha có ranh giới cứng (§4.11 *không nhảy pha*) — làm sai thứ tự là phải làm lại |

**Chưa mở** (chưa tới lúc đau, theo đúng bảng kích hoạt 07 §6):
`finding.md` — mọi thứ đang sai hôm nay đều đã có mã task nhận (6 link gãy → T-03), chưa có dòng nào *"đang sai mà không ai nhận"*.
`design/<lane>/` — mở khi pha tương ứng chạy xong và đẻ ra tài liệu thiết kế riêng; **từ lúc đó tài liệu thiết kế thắng** prompt-fullstack, và phải sửa lại prompt-fullstack ngay trong cùng phiên.
Cột **Chặn bởi** — mở cùng lúc với `finding.md`. Khi mở: finding task này **đóng** thì ghi ở cột *Đầu ra*, **không** ghi ở cột *Chặn bởi* (đây là chỗ đời trước giết 8 task).

**Ngoại lệ cố ý:** `make check` (T-02) được làm ở ngày 1 thay vì chờ "tài liệu lệch code lần thứ hai" — dấu hiệu đó **đã tới ngay hôm nay**: repo mới toanh mà đã có 6 con trỏ gãy. Đây là lane duy nhất không có compiler, để trôi thêm là nó dẫn đầu số finding như đời trước.

## Ba ngưỡng tự cảnh báo — vượt là **dừng làm sổ sách, quay về làm sản phẩm**

| Phép đo | Ngưỡng | Lệnh |
|---|---|---|
| commit `NON-CODE` / tổng commit | > 40% | `git log --format='%s' \| sed 's/[\/:].*//' \| sort \| uniq -c \| sort -rn` |
| dòng `.md` trên mỗi file code | > 100 | `find . -name '*.md' -not -path './.git/*' -print0 \| xargs -0 cat \| wc -l` ÷ `find be fe -type f 2>/dev/null \| wc -l` |
| finding đang MỞ | > 20 dòng | (chưa có `finding.md`) |

Vượt mà vẫn có lý do chính đáng thì **ghi lý do vào đây**, đừng sửa ngưỡng.
