# task_project_preparation.md — hàng đợi "xong / chưa"

> Cập nhật **2026-08-16** · Lane sở hữu: **NON-CODE** · Khuôn: [task_guiline.md](../task_guiline.md) · Kế hoạch gốc: [prompt-fullstack.md](../prompt-fullstack.md)
> Sổ lỗi anh em: [finding_project_preparation.md](finding_project_preparation.md) — sổ này đo *xong/chưa*, sổ kia đo *đúng/sai*.

**Đây là hàng đợi liên lane duy nhất** (`T-xx`) — nhà của *"làm gì tiếp, theo thứ tự nào, xong/chưa"* theo [CLAUDE.md §2](../../CLAUDE.md).
Sổ task theo lane (`design/<lane>/task_<lane>.md`, dải mã `T-<LANE>-xx`) **không giao mã** với bảng này và không dòng nào được chép sang dòng nào.

**Làm gì tiếp — lấy ra bằng lệnh, đừng đọc từ trên xuống:**

```sh
T=project_preparation/project_preparation_task_finding/task_project_preparation.md   # chạy từ gốc repo
grep -n '^| \*\*T-' $T | grep '🔺' | head -1                      # 1. chờ người ngoài — gửi đi sớm nhất, KHÔNG phải làm trước mọi thứ
grep -n '^| \*\*T-' $T | grep '⛓' | head -1                       # 2. đường găng — task chưa gạch đầu tiên
grep -o '^| \*\*T-[0-9]*\*\* ⚑[0-9][0-9]' $T | sort -k3            # 3. việc ngoài đường găng, thứ tự owner chọn
awk -F'|' '/^\| (~~)?\*\*T-/ && NF != 8 { print $2 }' $T          # dòng lệch cột — phải rỗng (xem luật cấm '|' trong ô)
grep -c '^| \*\*T-\|^| ~~\*\*T-' $T                               # tổng số dòng task
```

**Đường găng:** T-05 → T-06 → T-07 → T-08 → T-09 → T-10 → T-11 (6 pha kế hoạch). Trượt là trượt ngày lên sóng.
Hết cả ba tầng trên mới đọc theo thứ tự file — **thứ tự file ≠ thứ tự ưu tiên**.

**Mốc chuyển trọng tâm — T-06.** Đóng xong T-06 (bảng bất biến) thì **bắt đầu code lát cắt A song song** với
T-07→T-10, không chờ trọn 6 bản kế hoạch. Lý do: pha 1 là pha duy nhất *hỏng ra tiền* nên phải trọn vẹn trước;
pha 4 và 5 viết trong lúc BE đã chạy được vẫn kịp. Đường găng hiện là **7 task giấy tờ liên tiếp** trước dòng
code nghiệp vụ đầu tiên — đúng thứ ngưỡng §"Ba ngưỡng" ở cuối file gọi là *lệch trọng tâm*.

---

## Bảng task

| # | Lane | Task | Context | Cần xong trước | Đầu ra kiểm chứng được |
|---|------|------|---------|----------------|------------------------|
| **T-04** 🔺 | BA | Soạn **6 câu hỏi** giá suất trứng / suất giò gửi chủ quán, xuất `plan/hoi-chu-quan.md`. Task này **không chạm** `prompt-fullstack.md` — dán số về là việc của T-16 | **Nạp:** prompt-fullstack §3.2 khối ⚠️ in nghiêng · **Đã chốt:** 6 số đó là **suy ra**, chủ quán chưa đọc thành lời; luật *giá = tổng thành phần* đã đúng 3/3 trên combo · **Bẫy:** chủ quán có quyền bán suất rẻ hơn tổng thành phần để kéo khách — hỏi, đừng suy ra. Hỏi **cả sáu**, kể cả hai cặp trùng số, vì trùng số vẫn là hai món khác nhau. Cặp T-04+T-16 **phụ thuộc người ngoài** nên **không được chặn Pha 0/1** (T-05, T-06); chờ chủ quán mà treo cả đường găng là tự đứng | — | `grep -c '^[0-9]\.' plan/hoi-chu-quan.md` → `6` · `grep -c '^Trả lời:' plan/hoi-chu-quan.md` → `6` (mỗi câu một chỗ trống chủ quán điền; chưa điền thì T-16 chưa được chạy) |
| **T-16** 🔺 | BA | Dán 6 số chủ quán **đã trả lời** vào [§3.2](../prompt-fullstack.md), thay khối ⚠️ `GIẢ ĐỊNH` bằng khối ✅ theo đúng khuôn khối *"Năm câu treo"* nằm ngay dưới nó | **Nạp:** `plan/hoi-chu-quan.md` đã có câu trả lời · prompt-fullstack §3.2 · **Đã chốt:** phạm vi **đúng một file** `prompt-fullstack.md`; giữ nguyên chữ `GIẢ ĐỊNH` ở §4.10 và §8 — đó là **ràng buộc** và **khuôn xuất**, không phải khối cần xoá (biên nhận cũ `grep -c 'GIẢ ĐỊNH'` → `0` bắt xoá cả hai, đã gỡ 2026-08-15) · **Bẫy:** chưa có số do người thật trả lời thì **dừng**, không được ghi `✅` — tự suy 6 số rồi đánh dấu chốt là bịa xác nhận của chủ quán | T-04 | `grep -c 'chưa đọc chúng thành lời' project_preparation/prompt-fullstack.md` → `0` · `grep -c '✅ chốt giá suất' project_preparation/prompt-fullstack.md` → `1` |
| **T-17** ⚑01 | NON-CODE | Sửa bảng định tuyến §1 [CLAUDE.md](../../CLAUDE.md): lane BA chỉ có **một** biên nhận `plan/<pha>.md`, không phủ loại task **sửa nhà sự thật** — T-16 sửa §3.2 và không đẻ file `plan/` nào | **Nạp:** `CLAUDE.md` §1 + §5 · dòng T-16 ở file này · **Đã chốt:** sửa bằng **thay hoặc gộp**, không thêm mục (§5 cấm); trần `≤ 60` dòng đang **vừa khít** nên chữ thêm phải lấy chỗ từ chữ cũ · **Bẫy:** session chạy T-16 mà đọc đúng bảng §1 sẽ nạp cả `prompt-fullstack.md` rồi đi tìm một file `plan/` không tồn tại. Đây là **bản đồ sai**, hạng *sửa ngay* theo chính dòng 3 của CLAUDE.md, không phải việc để sau | — | `wc -l < CLAUDE.md` ≤ `60` · `grep -c 'biên nhận ghi ở dòng task' CLAUDE.md` → `1` |
| **T-18** ⚑02 | NON-CODE | Thêm dòng `Lane sở hữu` vào header các file `project_preparation/` còn thiếu | **Nạp:** header 4 file đã có (`CLAUDE.md` · `07` · `task_guiline` · `finding_guiline`) làm mẫu · **Đã chốt:** danh sách file thiếu **lấy bằng lệnh ở cột Đầu ra**, đừng chép tên file vào dòng này; `task_project_preparation.md` đã tự khai 2026-08-15 nên không thuộc task này · **Bẫy:** đây là lần cuối NON-CODE được sửa nội dung `prompt-fullstack.md` — khai xong owner thì mọi sửa sau thuộc lane đó, kể cả một dòng. Chọn owner sai còn tệ hơn để trống, nên owner của `prompt-fullstack.md` phải là lane đang sửa §3.2 ở T-16 | — | `grep -rL 'Lane sở hữu' --include='*.md' project_preparation CLAUDE.md` → **rỗng** (đệ quy để phủ cả thư mục con) |
| **T-19** ⚑03 | NON-CODE | Sửa lệnh điều hướng ở §3 và §7 [prompt_guiline.md](../prompt_guiline.md): `grep -n '^## §'` chỉ liệt kê heading cấp 2 nên **không tới được** `### 3.2` — đúng mục T-04 và T-16 phải đọc | **Nạp:** prompt_guiline §3 (chống loãng context) + §7 · **Đã chốt:** thay bằng dạng bắt cả `##` lẫn `###`; đây là lệnh **file này tự dạy**, sai thì mọi session làm theo đều nạp thừa hoặc đọc hụt · **Bẫy:** đừng chữa bằng cách bảo `Read` cả file — cách đó phá chính luận điểm §3, và §3 là chỗ file này đắt giá nhất | — | `grep -c '\^## §' project_preparation/prompt_guiline.md` → `0` · chép **nguyên văn** lệnh mới ở §7 chạy lại phải in ra dòng `### 3.2 Menu và công thức giá` |
| **T-01** ⚑10 | NON-CODE | Viết `README.md`: cách chạy + **con trỏ** tới nhà của luật nghiệp vụ | **Nạp:** [07 §2, §8](../07-cau-truc-du-an.md) · **Đã chốt:** prompt-fullstack §3–§4 **là nhà của sự thật** cho phạm vi/giá/hợp đồng API cho tới khi pha tương ứng chạy xong · **Bẫy:** chép bảng giá hay 11 ràng buộc §4 vào README là đẻ nhà thứ hai — đặt link | — | `grep -c 'prompt-fullstack.md' README.md` ≥ 1 **và** `grep -c -e '3\.000' -e '4\.000' -e '26\.000' README.md` → `0` (không chép bảng giá) |
| **T-02** ⚑05 | DevOps | Viết `Makefile` với 3 target: `make check` (link chết + đếm cột bảng task) · `make status` · `make next-id` | **Nạp:** [07 §4](../07-cau-truc-du-an.md) phép 1 + 4 · **Đã chốt:** Makefile là **nhà duy nhất của mọi lệnh**, CI gọi lại chứ không chép · **Bẫy:** [07 §4](../07-cau-truc-du-an.md) — quét `0*.md`, **không** quét `*.md`, vì file hướng dẫn chứa đúng chuỗi đang tìm và sẽ tự bắt chính mình (`F-60` đời trước) | — | `make check; echo $?` → `0` · `make status` in ra: số commit · số file `.md` · số dòng task chưa gạch · `make next-id` in ra mã task kế tiếp |
| **T-03** ⚑06 | NON-CODE | Sửa con trỏ gãy trong `project_preparation/` (trỏ sang repo cũ) — số đích lấy bằng đầu ra `make check`, **đừng ghi số vào dòng này** | **Nạp:** đầu ra `make check` của T-02 · **Đã chốt:** `../finding.md` · `../design/data_base/README.md` · `06-lich-su-du-an.md` · `finding.md` **không tồn tại ở repo này**; `../CLAUDE.md` **đã có nhà thật**, không phải link gãy — còn `../task.md` thì **gãy thật từ 2026-08-15**, ngày sổ task dời vào `project_preparation_task_finding/` (dòng này từng ghi *"6 con trỏ"* rồi *"5 đích"* — cả hai đều hết đúng trong vòng một ngày, đúng bệnh §10 *ghi số thay vì ghi lệnh*; **đừng ghi số thứ ba**) · **Bẫy:** đừng tạo file rỗng cho khớp link — link nào trỏ tới bài học đời trước thì ghi thẳng *(repo cũ, không mang sang)*; link `../task.md` thì trỏ về [task_project_preparation.md](task_project_preparation.md) thật | T-02 | `make check` → **0 dòng link chết** |
| **T-05** ⛓ | BA | Chạy **Pha 0 · BA**, xuất `plan/0-ba.md` | **Nạp:** prompt-fullstack §1→§10 làm prompt hệ thống · **Đã chốt:** đầu ra là **kế hoạch, không phải code**; nhiệt độ 0.1–0.3; khuôn xuất ở §8 · **Bẫy:** §4.11 cấm nhảy pha — pha 0 **không** nhắc tên bảng. T-04 · T-16 **không chặn** dòng này: giữ nguyên khối `GIẢ ĐỊNH` là đúng luật §4.10, chốt số xong thì sửa ở T-16 | — | `plan/0-ba.md` có đủ 7 mục §8 (`grep -c -e '^PHA' -e '^CHỐT XONG' -e '^MASTER TASK' -e '^CỔNG CHẤT LƯỢNG' -e '^RỦI RO' -e '^CÒN LẠI' plan/0-ba.md` ≥ 6) **và** `grep -c '^. T-' plan/0-ba.md` ≤ 12 |
| **T-06** ⛓ | BA | Chạy **Pha 1 · System design**, xuất `plan/1-system-design.md` | **Nạp:** prompt-fullstack §6.2 (bảng bất biến I1–I10) + §10 · **Đã chốt:** I1 phải gồm cả trạng thái `billing`, thiếu là **thu thiếu tiền** · **Bẫy:** pha này hỏng ra tiền — chạy **riêng một session**, không ghép với pha khác (§11) | T-05 | `plan/1-system-design.md` có bảng bất biến **đủ 3 cột** cho I1–I10; bất biến nào chưa có cơ chế bảo vệ phải mang dấu ⚠️ ngay trong bảng |
| **T-07** ⛓ | DB | Chạy **Pha 2 · DB**, xuất `plan/2-db.md` | **Nạp:** prompt-fullstack §3.5 (16 bảng, 9 chi tiết không được bỏ) + bảng bất biến từ T-06 · **Đã chốt:** tiền lưu `INT` VND; migration chỉ thêm mới · **Bẫy:** §4.11 — pha 2 **không** nhắc endpoint | T-06 · **T-16** (dữ liệu mồi cần 6 số đã chốt) | `plan/2-db.md` có **query đối chiếu cho từng bất biến** I1–I10 (`grep -c 'I[0-9]' plan/2-db.md` ≥ 10) + thứ tự migration + dữ liệu mồi menu thật |
| **T-08** ⛓ | BE | Chạy **Pha 3 · BE**, xuất `plan/3-be.md` | **Nạp:** prompt-fullstack §3.6 (danh sách endpoint) + §9.3 (19 ca giá) · **Đã chốt:** giá tính ở **một hàm duy nhất** dùng chung cho `quote` và `create order`; FE không bao giờ gửi giá · **Bẫy:** hệ số phụ thu suất trứng là **×5**, không phải ×4 — hardcode ×4 là thu thiếu 1.000đ mỗi suất | T-07 · **T-16** (19 ca giá có 6 số suất) | `plan/3-be.md` có bảng ca test **đủ 19 ca §9.3**, trong đó **2 ca cuối phải LỖI** (`grep -c 'LỖI' plan/3-be.md` ≥ 2) |
| **T-09** ⛓ | FE | Chạy **Pha 4 · FE**, xuất `plan/4-fe.md` | **Nạp:** prompt-fullstack §3.7 (cây route + nguyên tắc UI) + §3.2b (bước chọn canh ở giỏ hàng) · **Đã chốt:** type **sinh từ hợp đồng API**, không gõ tay · **Bẫy:** §4.11 — pha 4 **không** đổi hợp đồng API; cần đổi ⇒ ghi thành một dòng lỗi gửi ngược về pha 3 | T-08 | `plan/4-fe.md` có cây route khớp §3.7 **và** nói rõ nguồn dữ liệu từng màn; ô nhập số cái của bánh cuốn lẻ là **ô gõ tự do**, không phải +/− |
| **T-10** ⛓ | DevOps | Chạy **Pha 5 · Deploy & vận hành**, xuất `plan/5-deploy.md` | **Nạp:** prompt-fullstack §6.6, §6.8, §6.9 · **Đã chốt:** BE chỉ **1 instance** (SSE giữ kết nối trong bộ nhớ process); **không deploy trong giờ bán 6h–11h** · **Bẫy:** backup chưa restore thử **không phải** backup | T-09 | `plan/5-deploy.md` có checklist trước deploy + **quy trình restore đã diễn tập** + quy trình sự cố kèm sổ giấy |
| **T-11** ⛓ | NON-CODE | Gom master task của cả 6 pha vào bảng này, mở thêm cột theo bảng kích hoạt | **Nạp:** `plan/*.md` mục `MASTER TASK` · **Đã chốt:** đây là **một** hàng đợi duy nhất; trả lời nằm trong khung chat thì pha sau không đọc lại được (§11) · **Bẫy:** mã `T-xx` **không bao giờ tái sử dụng** — mã kế tiếp lấy bằng `make next-id` (T-02), **đừng ghi số cứng vào đây** | T-10 · T-21 · [F-02](finding_project_preparation.md#f-02) đóng | Mọi mã task trong mục *MASTER TASK* của `plan/*.md` có mặt trong `task_project_preparation.md` (lệnh dò ra rỗng) **và** `make check` → `0` |
| **T-12** ⚑08 | DevOps | Dựng `docker-compose.yml` dev: MySQL 8.4 + Go 1.26 + Next.js 16 + Caddy 2.11, endpoint `/healthz` | **Nạp:** prompt-fullstack §3.4 (stack + cổng đã chốt) · **Đã chốt:** BE `8080` · MySQL `3306` · FE `3000`; `Asia/Ho_Chi_Minh` ở **cả 4 chỗ** · **Bẫy:** lệch múi giờ ⇒ logic 6h–11h sai 7 tiếng, và lỗi này không báo gì cả | — | `docker compose up -d && curl -s -o /dev/null -w '%{http_code}' localhost:8080/healthz` → `200` · `docker compose exec db mysql -Ne "SELECT @@time_zone"` → `+07:00` |
| **T-13** ⚑04 | DevOps | Thêm `.githooks/commit-msg` chặn commit không có tiền tố lane + `git config core.hooksPath .githooks` | **Nạp:** [07 §0](../07-cau-truc-du-an.md) lệnh đếm commit theo lane · **Đã chốt:** 6 lane `BA`·`DB`·`BE`·`FE`·`DEVOPS`·`NON-CODE`; commit duy nhất đang có (`adfg`) **không có tiền tố** ⇒ phép đo ngưỡng #1 ở cuối file đang vô nghĩa, và sẽ vô nghĩa vĩnh viễn nếu không chốt trước commit thứ hai · **Bẫy:** `core.hooksPath` không theo `git clone` ⇒ phải nằm trong `make setup`; [project_issue §2](../project_issue.md) **cấm `--no-verify`** | — | `git commit --allow-empty -m 'sai'` → **bị từ chối** · `git commit --allow-empty -m 'NON-CODE: thu'` → **đi qua**. Dán cả hai output |
| **T-14** ⚑07 | NON-CODE | Cắt `CLAUDE.md` xuống **đúng trần nó tự khai**, bằng **thay hoặc gộp** luật cũ — không xoá mục | **Nạp:** `CLAUDE.md` §4 + §5 · [07 §2](../07-cau-truc-du-an.md) · **Đã chốt:** 4 nội dung bắt buộc (định tuyến lane · bảng *sự thật → nhà → ai thắng* · vòng lặp session · luật cứng) **đã viết xong 2026-08-15**, không mở lại; phần còn nợ **chỉ là trần dòng** — file khai `≤ 60` mà `wc -l` ra `67`, tức nó vi phạm chính §5 của nó ngay dòng đầu tiên · **Bẫy:** cám dỗ là **nới trần lên 70**; [07 §7](../07-cau-truc-du-an.md) cấm — *vượt mà có lý do thì ghi lý do, đừng sửa ngưỡng*. Cắt ở mục 3 (vòng lặp 8 bước có thể gộp 6+7) chứ đừng cắt luật cứng ở mục 4 | T-02 | `wc -l < CLAUDE.md` ≤ `60` · `make check` → 0 link gãy · `grep -c -e '3\.000' -e 'open_key' -e 'I10' CLAUDE.md` → `0` (không chép sự thật của nhà khác) |
| **T-20** ⚑11 | NON-CODE | Thêm dòng phân xử *hình dạng dòng task* vào bảng §2 [CLAUDE.md](../../CLAUDE.md) — đóng [F-01](finding_project_preparation.md#f-01) | **Nạp:** [F-01](finding_project_preparation.md#f-01) · `CLAUDE.md` §2 + §5 · **Đã chốt:** nhà thắng là `task_guiline.md`, vì đó là khuôn **hai bảng thật đang dùng** và nó có cột `Context` mà §5.3 không có; trần `≤ 60` đang **vừa khít** nên phải **thay hoặc gộp**, không thêm dòng · **Bẫy:** vế sửa `prompt-fullstack §5.3` thành link **không** thuộc task này — file đó chưa có `Lane sở hữu` cho tới khi T-18 chạy, chạm trước là sửa file chưa ai nhận | — | `wc -l < CLAUDE.md` ≤ `60` · `grep -c 'hình dạng dòng task' CLAUDE.md` → `1` · `make check` → `0` |
| **T-21** ⚑12 | NON-CODE | Chốt số phận cột `Hỏng thì mất gì` giữa khuôn xuất `plan/*.md` và bảng này — đóng [F-02](finding_project_preparation.md#f-02) | **Nạp:** [F-02](finding_project_preparation.md#f-02) hai phương án · [prompt-fullstack §8](../prompt-fullstack.md) dòng 461 · **Đã chốt:** phải chốt **trước T-11**, vì T-11 gom 6 bảng 7 cột vào bảng 6 cột; T-11 chỉ nói *"mở thêm cột theo bảng kích hoạt"* mà bảng kích hoạt không có cột này · **Bẫy:** phương án mở cột thứ 7 phải đổi `check-task-cols` trong `command/Makefile` — **lane DevOps**, thư mục đang `??` chưa commit; mở task cho DevOps rồi chờ, đừng tiện tay sửa | T-20 · [F-01](finding_project_preparation.md#f-01) đóng | `make check` **đỏ trên bản cũ, xanh trên bản mới**, dán cả hai output · `grep -c 'Hỏng thì mất gì' project_preparation/prompt-fullstack.md` và trên bảng này cho kết quả **khớp phương án đã chốt** |
| **T-22** ⚑13 | NON-CODE | Khai lại nghĩa `⚑n` ở [task_guiline §4](../task_guiline.md) và đưa lệnh dò thứ tự vào `make check` — đóng [F-03](finding_project_preparation.md#f-03) | **Nạp:** [F-03](finding_project_preparation.md#f-03) kèm lệnh awk sẵn ở mục chi tiết · **Đã chốt:** giữ `⚑n`, chỉ hẹp nghĩa lại thành *thứ tự owner chọn **trong phạm vi phụ thuộc dữ liệu cho phép***; thứ tự hôm nay **chưa** vi phạm dòng nào nên đây là sửa luật lúc còn rẻ · **Bẫy:** đừng đóng chỉ bằng sửa chữ — luật không có lệnh cưỡng chế là luật tái phát, đúng thứ [finding_guiline §5](../finding_guiline.md) đo được ở dự án trước | T-21 · [F-02](finding_project_preparation.md#f-02) đóng | Lệnh awk của F-03 nằm trong `make check`, **đỏ trên một bảng cố tình xếp sai, xanh trên bảng thật** — dán cả hai output |
| **T-23** ⚑15 | DevOps | Thêm **phép đo 5** *"báo mà không giao"* vào `make check` — lệnh đã viết sẵn, chép nguyên văn từ [finding_guiline §6](../finding_guiline.md) | **Nạp:** [finding_guiline §6](../finding_guiline.md) phép đo 5 (lệnh đầy đủ) + §1 luật bàn giao chéo lane · **Đã chốt:** lệnh đã chạy thật và bắt đúng `8` dòng của `design/fe/finding_fe.md`, **không** bắt nhầm dòng nào của sổ NON-CODE — tức nó đỏ ngay lúc thêm, đó là đúng ý chứ không phải cần chỉnh · **Bẫy:** phải đòi **dòng task thật** (neo đầu dòng, dạng `^. **T-`), không `grep` cả file — một lần nhắc tên finding trong văn xuôi đủ làm lệnh im, mà nhắc tên không phải là giao việc. Và đọc lane sở hữu **từ header sổ**, đừng hardcode tên lane | T-24 (nếu không, cổng đỏ ngay lúc thêm) | `make check` **đỏ** khi còn dòng *báo mà không giao*, **xanh** sau khi T-24 dọn xong — dán cả hai output |
| **T-24** ⚑14 | NON-CODE | Mở dòng nhận ở hàng đợi này cho **các finding của lane FE đang chờ lane khác đóng** — danh sách lấy bằng phép đo 5, **đừng chép mã vào dòng này** | **Nạp:** [finding_guiline §6](../finding_guiline.md) phép đo 5 chạy lấy danh sách · [finding_fe.md](../../design/fe/finding_fe.md) cột *Lane* · **Đã chốt:** đây là **bước 2 còn thiếu** của luật bàn giao chéo lane — lane FE đã làm đúng bước 1 (ghi vào sổ của mình, cột *Lane* = lane đóng được) nhưng chưa có dòng nào ở hàng đợi liên lane, nên BA và BE không có đường nào biết mình đang nợ · **Bẫy:** **không** sửa `finding_fe.md` — file đó lane FE sở hữu; task này chỉ **thêm dòng ở đây**. Lật trạng thái dòng finding là việc của lane đóng nó, sau khi đóng | — | Phép đo 5 ở [finding_guiline §6](../finding_guiline.md) ra **rỗng**, dán output; và số dòng thêm vào bảng này **khớp** số dòng lệnh in ra trước đó |
| **T-15** ⚑09 | DevOps | Thêm phép 3 vào `make check`: số trần trụi trong `task_project_preparation.md` + `CLAUDE.md` không kèm lệnh sinh ra nó | **Nạp:** [07 §4](../07-cau-truc-du-an.md) phép 3 · **Đã chốt:** phạm vi quét là **đúng hai đường dẫn** — `project_preparation/project_preparation_task_finding/*.md` và `CLAUDE.md`; dấu hiệu kích hoạt **đã tới** — T-03 từng ghi *"6 con trỏ gãy"* trong khi lệnh đo ra 5 đích / 25 lần; đây là nhóm bệnh `F-13`/`F-40`/`F-55` đời trước · **Bẫy:** `F-60` — **không** quét `project_preparation/*.md` tầng trên, vì file hướng dẫn chứa đúng những chuỗi đang tìm và sẽ tự bắt chính mình; sổ task nằm trong thư mục con nên `*.md` không đệ quy là đúng ý, đừng đổi thành `-r` | T-02 · T-03 | `make check` **đỏ** trên bản sổ task còn số trần trụi, **xanh** sau khi thay bằng lệnh. Dán cả hai output |

---

## Luật đọc bảng này

- **Cột `#`**: `| **T-07** |` = đang mở · `| ~~**T-07**~~ ✅ |` = đã xong. Không có cột *Trạng thái* — nó suy ra được (`grep`).
  Mã task **không bao giờ tái sử dụng**, kể cả khi dòng bị huỷ.
- **Ba ký hiệu ở cột `#`**: `⛓` = trên đường găng · `⚑NN` = ngoài đường găng, `NN` là thứ tự owner chọn,
  **luôn hai chữ số** — `⚑1` và `⚑10` lẫn nhau khi sort, mà lỗi đó không báo gì, nó chỉ trả về sai thứ tự ·
  `🔺` = **chờ người ngoài repo** (chủ quán, nhà cung cấp): gửi đi **sớm nhất có thể** vì độ trễ không do mình,
  nhưng nó **không** đứng trước mọi thứ — nó chỉ chặn đúng những dòng ghi nó ở cột *Cần xong trước*.
  Trước 2026-08-15 dòng chú thích lệnh #1 đọc là *"làm trước mọi thứ"*, trái với chính thân dòng mang cờ.
- **Cột Context** đúng ba mẩu: `Nạp:` · `Đã chốt:` · `Bẫy:`. Cột này **không** được nói "thế nào là xong" — vế đó là của cột *Đầu ra*.
- **Cấm ký tự `|` bên trong một ô** — kể cả trong backtick, kể cả viết `\|`. `awk -F'|'` không phân biệt được pipe-trong-lệnh
  với pipe-ngăn-cột, nên **một ô có pipe làm phép đo "thiếu cột" nói dối cả hai chiều**. Bốn dòng của bảng này từng mắc
  (2026-08-15). Thay bằng: `grep -e A -e B` cho alternation · một target `make …` cho pipeline nhiều chặng · `^. T-` cho neo đầu dòng.
  Nghiệm thu: lệnh `awk` ở khối *Làm gì tiếp* đầu file phải in ra **rỗng** — dùng `NF != 8`, không phải `NF < 8`.
- **Cột *Cần xong trước*** nhận **cả** mã task và **finding phải đóng** — giống [task_fe.md](../../design/fe/task_fe.md).
  Đây là chỗ [task_guiline §1](../task_guiline.md) cảnh báo giết 8 task đời trước: finding mà **task này sẽ đóng**
  thì ghi ở cột *Đầu ra*, **không** ghi ở đây. Chọn cách này thay vì mở cột *Chặn bởi* vì cột thứ 7 sẽ làm
  `check-task-cols` (`NF != 8`) đỏ — mà ngưỡng đó là chuyện của [F-02](finding_project_preparation.md#f-02), không phải chuyện gánh kèm.
- **Cột Đầu ra** phải là **lệnh**, không phải tính từ. Sửa lỗi ⇒ **đỏ trên code cũ, xanh trên code mới**, dán cả hai output.
- **Kích cỡ một dòng:** 1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một session. Vượt ⇒ **chẻ trước khi làm**.
- **Đánh dấu xong cần đủ 3 thứ:** biên nhận chạy thật kèm output · commit chứa thay đổi · gạch dòng ở đây kèm ngày. Thiếu một ⇒ vẫn là *đang làm*.
- **Prompt mở session** — cố ý **không** làm thành cột (điền trước cả bảng là 78 ô phải sửa tay mỗi lần đổi luật). Dùng mẫu 1 dòng:
  `Nhiệm vụ: <ô Task>. Nạp: <ô Context>. Phạm vi: <file được chạm>. Xong khi: <ô Đầu ra>.`

## Vì sao bảng có 6 cột, không phải 3 và không phải 8

[07 §6](../07-cau-truc-du-an.md) nói ngày 1 chỉ cần 3 cột. Ba cột thêm vào đây đều có dấu hiệu kích hoạt **đã xảy ra**, ghi lại lý do để dự án sau khỏi chép mù:

| Cột thêm | Dấu hiệu đã kích hoạt |
|---|---|
| **Lane** | Kế hoạch có sẵn 5 lane từ ngày 1 (BA · DB · BE · FE · DevOps — prompt-fullstack §7), và biên nhận của 5 lane là 5 lệnh khác nhau |
| **Context** | Mỗi pha do một session **chưa từng đọc repo** chạy, và phải nạp đúng mục của một file 611 dòng |
| **Cần xong trước** | 6 pha có ranh giới cứng (§4.11 *không nhảy pha*) — làm sai thứ tự là phải làm lại |

**Đã mở (2026-08-15):** `CLAUDE.md` — **đã viết xong nội dung**, còn nợ trần dòng → **T-14**. Không mở vì "tới lúc đau"
mà vì **bản đồ đang sai**: 4 file trong `project_preparation/` khai *"lệch ⇒ CLAUDE.md thắng"* trong khi file đó chưa
tồn tại. Theo [project_issue §14.3](../project_issue.md) đó là bug phải sửa ngay, không phải hạng mục chờ kích hoạt.

**Đã mở (2026-08-16):** [finding_project_preparation.md](finding_project_preparation.md) — điều kiện mở ghi ở đây
(*"có dòng đang sai mà không ai nhận"*) **đã tới**: một session rà `prompt-fullstack §5` tìm ra 3 mệnh đề sai được
mà không mã task nào nhận. Ba dòng đầu tiên là F-01 · F-02 · F-03, và ba task đóng chúng là T-20 · T-21 · T-22.
Dòng *"chưa có dòng nào đang sai mà không ai nhận"* ở bản trước **hết đúng ngày 2026-08-16**, không phải sai từ đầu.

**Chưa mở** (chưa tới lúc đau, theo đúng bảng kích hoạt 07 §6):
Cột **Chặn bởi** — **không mở**, và đây là quyết định chứ không phải hoãn: `Cần xong trước` đã nhận cả finding
(xem *Luật đọc bảng này*), còn cột thứ 7 thì làm `check-task-cols` đỏ. Mở lại bàn khi [F-02](finding_project_preparation.md#f-02) chốt xong ngưỡng cột.

**Đã mở sớm hơn bản đồ, cần dọn:** `design/<lane>/` đã tồn tại và đang được dùng (`design/fe/`), trong khi mục này
từng khai nó *"chưa mở"* — [F-FE-08](../../design/fe/finding_fe.md) bắt đúng chỗ đó. Nửa liên quan tới sổ finding đã dọn ở bản này;
nửa `design/<lane>/` **và việc lật trạng thái F-FE-08** thuộc lane FE sở hữu `finding_fe.md`, không gánh sang đây.
Luật đã chốt vẫn nguyên: **từ lúc `design/<lane>/` có tài liệu thiết kế, tài liệu ấy thắng** prompt-fullstack, và phải sửa lại prompt-fullstack ngay trong cùng phiên.

**Ngoại lệ cố ý:** `make check` (T-02) được làm ở ngày 1 thay vì chờ "tài liệu lệch code lần thứ hai" — dấu hiệu đó **đã tới ngay hôm nay**: repo mới toanh mà đã có link gãy (đếm bằng `make check`, không ghi số ở đây). Đây là lane duy nhất không có compiler, để trôi thêm là nó dẫn đầu số finding như đời trước.

## Ba ngưỡng tự cảnh báo — vượt là **dừng làm sổ sách, quay về làm sản phẩm**

| Phép đo | Ngưỡng | Lệnh |
|---|---|---|
| commit `NON-CODE` / tổng commit | > 40% | `git log --format='%s' \| sed 's/[\/:].*//' \| sort \| uniq -c \| sort -rn` |
| dòng `.md` trên mỗi file code | > 100 | `find . -name '*.md' -not -path './.git/*' -print0 \| xargs -0 cat \| wc -l` ÷ `find be fe -type f 2>/dev/null \| wc -l` |
| finding đang MỞ | > 20 dòng | `grep -cE '^\[|] \[F-[0-9]+\].*🔓 MỞ' project_preparation/project_preparation_task_finding/finding_project_preparation.md` |

Vượt mà vẫn có lý do chính đáng thì **ghi lý do vào đây**, đừng sửa ngưỡng.

**Đang vượt, lý do ghi ở đây (2026-08-15):**

- **Phép đo 1 chưa tin được** — tiền tố lane đang là **tự giác**, không lệnh nào gác (commit gốc `adfg` không có tiền tố). **T-13** dựng hook để mọi commit sau đo được. Trước khi T-13 xong, đừng trích dẫn tỉ lệ này.
- **Phép đo 2 đang chia cho 0** — `find be fe` ra `0` file code. Đây **không** phải lỗi đo: dự án chưa có dòng code nào, và đó chính là cảnh báo. Đối trọng đã đặt vào kế hoạch: **T-12** (docker-compose, dòng code đầu tiên) nằm ở ⚑08 chứ không chờ hết 6 pha, và **mốc chuyển trọng tâm ở T-06** cho phép code lát cắt A song song với T-07→T-10. Đo lại phép này sau khi T-12 xong.
