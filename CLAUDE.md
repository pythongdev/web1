# CLAUDE.md — luật làm việc + bản đồ. **File này không giữ sự thật nào.**

> Cập nhật **2026-08-15** · Lane sở hữu: **NON-CODE** · Trần cứng **≤ 60 dòng** (`wc -l < CLAUDE.md`).
> Lệch với nhà thật ⇒ **nhà thật thắng**; dòng sai ở đây là **bug phải sửa ngay**, không phải việc để sau.
> Vì sao có từng luật (mỗi luật là một lần đã trả tiền): [project_issue.md](project_preparation/project_issue.md).

## 1. Định tuyến lane — dòng đầu MỌI session phải khai `Lane: <X> · Task: T-xx`

**Vai của mọi session: kỹ sư thi công đúng một lane, không phải chủ dự án** — hai cách đều đúng ⇒ chọn cách **có lệnh chứng minh**; **thu đúng tiền** thắng code đẹp; thiếu dữ kiện thì **hỏi**, không đoán *(chưa có lệnh)*. Prompt chỉ ghi mã task ⇒ tra dòng đó ở [sổ task](project_preparation/project_preparation_task_finding/task_project_preparation.md) lấy lane, rồi nạp **đúng một gói** dưới đây, không nạp toàn cảnh. Không có lane ⇒ chưa được chạm file nào.

| Lane | Nạp đúng gói này | Biên nhận — đúng **một** lệnh, dán output |
|---|---|---|
| **BA** | [prompt-fullstack §1→§10](project_preparation/prompt-fullstack.md) · dòng task của mình | `plan/<pha>.md` đủ 7 mục khuôn §8 |
| **DB** | prompt-fullstack §3.5 · `plan/1-system-design.md` | migrate `up`+`down` chạy lại được · bộ query đối chiếu ra **0 dòng** |
| **BE** | prompt-fullstack §3.6 + §9.3 · `plan/2-db.md` | `go test ./...` xanh, đủ ca ở §9.3 |
| **FE** | prompt-fullstack §3.7 + §3.2b · `plan/3-be.md` | `npm run build` + typecheck xanh, type **sinh** từ hợp đồng API |
| **DevOps** | prompt-fullstack §3.4, §6.6, §6.8, §6.9 | `docker compose up -d` rồi `/healthz` → `200` |
| **NON-CODE** | [sổ task](project_preparation/project_preparation_task_finding/task_project_preparation.md) · [07](project_preparation/07-cau-truc-du-an.md) · khuôn của sổ đang sửa | `make check` → `0` |

Khuôn khi phải **dựng/sửa** một sổ (là *khuôn*, không phải nội dung — đừng chép sang chỗ khác): bảng task → [task_guiline](project_preparation/task_guiline.md) ·
sổ finding → [finding_guiline](project_preparation/finding_guiline.md) · prompt → [prompt_guiline](project_preparation/prompt_guiline.md) · bộ khung thư mục → [07](project_preparation/07-cau-truc-du-an.md).

## 2. Sự thật → nhà duy nhất → ai thắng khi lệch

**Cần lại một sự thật ⇒ đặt link, không chép.** Suy ra được bằng lệnh ⇒ **cấm** chép thành bảng/cột/file.

| Sự thật | Nhà duy nhất | Ai thắng khi lệch |
|---|---|---|
| Phạm vi · giá · hình dạng dữ liệu · hợp đồng API | [prompt-fullstack.md](project_preparation/prompt-fullstack.md) | `plan/*.md` của pha đã chạy xong; rồi **code thắng tài liệu** — và phải sửa ngược lại ngay trong cùng phiên |
| Làm gì tiếp, theo thứ tự nào, xong/chưa | [sổ task](project_preparation/project_preparation_task_finding/task_project_preparation.md) | task_project_preparation.md |
| Cái đang **sai ngay bây giờ** | `finding_project_preparation.md` cạnh sổ task (chưa mở — điều kiện mở nằm ở [sổ task](project_preparation/project_preparation_task_finding/task_project_preparation.md) §"Chưa mở") | sổ finding |
| Mọi lệnh của dự án | `Makefile` (CI **gọi lại**, cấm chép lệnh ra chỗ khác) | Makefile |
| Trạng thái · hiện trạng · số đo | **không có nhà** — `make status`, `git log`, `ls` | lệnh vừa chạy |
| Kiểu hỏng đã trả tiền + vì sao có luật | [project_issue.md](project_preparation/project_issue.md) | file này (CLAUDE.md) — còn CLAUDE.md thua **nhà thật** của mọi sự thật khác |

## 3. Vòng lặp một session: `ĐỊNH TUYẾN → ĐỊNH VỊ → PLAN → ĐIỂM LÙI → LÀM → TỰ RÀ → KIỂM CHỨNG → GHI SỔ`

1. **ĐỊNH TUYẾN** — khai `Lane · T-xx`. Sai lane thì dừng, không "tiện tay".
2. **ĐỊNH VỊ** — nạp gói §1 + ô *Context* của dòng task (`Nạp · Đã chốt · Bẫy`). Thiếu nguồn thật ⇒ **hỏi**, đừng suy diễn: thiếu nguồn không gây lỗi, nó gây **bịa**, mà bịa thì trông hệt như làm đúng.
3. **PLAN** — nói trước sẽ chạm file nào. Quá 3 file hoặc quá 1 lane ⇒ **chẻ task trước khi làm**.
4. **ĐIỂM LÙI** — commit sạch **ngay trước khi sửa**. Không có điểm lùi ⇒ không được sửa file nào.
5. **LÀM** — chỉ trong phạm vi đã khai. Sửa lỗi ⇒ **đỏ trên code cũ, xanh trên code mới**, dán cả hai output.
6. **TỰ RÀ** — `git diff --stat`; thấy file lạ ⇒ **đừng stage, cũng đừng `git restore`** (việc chưa commit của lane khác) → dừng và báo.
7. **KIỂM CHỨNG** — chạy đúng lệnh biên nhận của lane, dán output thật. *"Đã viết code" ≠ "đã chạy".*
8. **GHI SỔ** — chưa ghi thì việc **chưa xong**. Đánh dấu xong cần đủ **ba**: biên nhận có output · commit chứa thay đổi · gạch dòng ở [sổ task](project_preparation/project_preparation_task_finding/task_project_preparation.md) kèm ngày.

## 4. Luật cứng — vi phạm là làm lại

- **Một session = một lane, một task.** Dấu hiệu **phải dừng và mở việc mới**: chạm file ngoài lane · sửa quá 3 file ngoài kế hoạch · hơn 2 lần thử–sai trên cùng một lỗi · context bị tóm tắt giữa chừng. Cấm gánh tiếp cho xong.
- **`git add` từng đường dẫn cụ thể, cấm `-A`; cấm `--no-verify`; commit mang tiền tố lane** (`BA`·`DB`·`BE`·`FE`·`DEVOPS`·`NON-CODE`).
- **Lùi thật** (`reset --hard`, xoá nhánh, `push --force`, xoá volume, `DROP`) **thuộc owner**: agent phát hiện đã sửa nhầm thì **dừng và báo**, không tự lùi.
- **Đầu ra là lệnh, không phải tính từ** ("hoạt động tốt" / "đã rà" không đóng được gì), và **đếm được bằng lệnh thì ghi lệnh, đừng ghi số** — số trần trụi trong tài liệu hỏng sớm nhất.
- **Mỗi file `.md` có dòng `Cập nhật <ngày>`**; sửa nội dung ⇒ đổi ngày **trong cùng commit**. Sửa code làm tài liệu sai ⇒ sửa tài liệu trong cùng commit, hoặc mở finding ngay — không có lựa chọn thứ ba.
- **Mỗi file có đúng một lane sở hữu.** Cần sửa file của lane khác — kể cả một dòng — thì mở finding + task, đừng tiện tay.
- **Hai sổ không bao giờ trộn:** nợ xây dựng (*"chưa có X"*) là **task**; sổ finding chỉ nhận **mệnh đề sai được**, và đóng finding phải để lại một dòng *Bài học giữ lại* nói **luật nào đổi**, không kể lại sự cố.
- **Cấm file chỉ để điều hướng.** File mới phải giữ một sự thật chưa có ở đâu khác · có lane sở hữu · có lệnh đỏ khi nó lệch — thiếu một vế thì chưa tới lúc sinh nó ra.

## 5. Trần của chính file này

**≤ 60 dòng.** Thêm luật ⇒ **thay hoặc gộp** luật cũ, **không thêm mục** (file này phình ra thì mọi session sau đều trả tiền để đọc nó); cùng một bài học lặp **lần thứ ba** thì mới được lên đây; luật mới chưa quy được về **một lệnh cưỡng chế** thì ghi thẳng *"chưa có lệnh"* ngay tại dòng đó — đấy là chỗ nó sẽ tái phát.
