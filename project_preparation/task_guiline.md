# Bảng task — form nào, cột gì, vì sao có cột đó

> Cập nhật **2026-08-15** · Lane sở hữu: **NON-CODE**. Nhà của **cách dựng bảng task cho một dự án mới**.
> Bảng task thật của dự án này ở [task_project_preparation.md](project_preparation_task_finding/task_project_preparation.md); luật làm việc ở [CLAUDE.md](../CLAUDE.md).
> File này **không giữ trạng thái task nào** — nó giữ *vì sao khuôn có dạng đó* và **cái giá đã trả để biết**.
> Lệch ⇒ task.md / CLAUDE.md thắng. Số liệu dựng lại bằng lệnh ở §5, thống kê gốc ở [06-lich-su-du-an.md](06-lich-su-du-an.md).

**Luận điểm.** Bảng task **không phải danh sách việc**. Nó là **hợp đồng mở session**: một dòng phải đủ để
một session *chưa từng đọc repo* bắt đầu và kết thúc mà không hỏi lại câu nào. Mỗi dòng trả lời đúng ba câu —
**lấy gì để bắt đầu · làm cái gì · lệnh nào chứng minh đã xong**. Cột không phục vụ ba câu đó là cột phải cắt.

---

## 1. Khuôn 8 cột

| Cột | Câu hỏi nó trả lời | Bỏ đi thì hỏng thế nào |
|-----|--------------------|------------------------|
| **`#`** — mã `T-xx` + dấu xong | Dòng này tên gì, xong chưa | Finding/commit không có gì để trỏ tới; không lệnh nào lọc được "chưa xong" |
| **Lane** | Ai làm, nạp gói nào, biên nhận là lệnh nào | Mỗi session tự chọn file để đọc, tự chọn cách chứng minh |
| **Task** | Làm **một** việc gì — động từ + tên file | Dòng nở thành đề tài, không session nào đóng nổi |
| **Context** | **Đầu vào**: nạp gì · đã chốt gì · bẫy ở đâu | Session điều tra lại từ đầu, và **quyết lại** thứ đã quyết |
| **Cần xong trước** | Mở được chưa, theo thứ tự nào | Làm đúng việc sai lúc: FE mock BE, đo trong lúc nguồn nhiễu vẫn chạy |
| **Finding phải đóng** | Có gì đang **sai** chặn task này không | Xây tiếp lên trên một chỗ đã biết là hỏng |
| **Đầu ra kiểm chứng được** | **Lệnh nào** chứng minh xong + đóng finding nào | "Đã viết code" thay cho "đã chạy" |
| **Prompt mở session** | Dòng owner dán vào session mới | Session tự chế cách mở, dòng khai lane biến mất ([F-49](../finding.md#f-49)) |

Ba cột dễ làm sai nhất, nói kỹ:

**Cột `#` — cú pháp phải `grep` được.** Dùng `| **T-07** |` cho đang mở và `| ~~**T-07**~~ ✅ |` cho đã xong,
để `grep '^| \*\*T-'` tự bỏ qua dòng xong mà không cần cột *Trạng thái*. Mã task **không bao giờ tái sử dụng**,
kể cả khi dòng bị huỷ — mọi commit và finding cũ đang trỏ vào nó.

**Cột Context — đúng ba mẩu, không hơn.** `Nạp:` file + **đúng mục** phải đọc · `Đã chốt:` quyết định **đã có nhà**
(đặt link, chép lại là đẻ nhà thứ hai) · `Bẫy:` chỗ đã cắn hoặc chắc chắn sẽ cắn. Cột này **không** được nói
"thế nào là xong" — vế đó là của cột đầu ra. Đầu vào và đầu ra là hai sự thật, mỗi cái một ô.

**Cột Finding — một nghĩa, không hai.** Đây là chỗ dự án này trả giá đắt nhất trong bảng
([F-63](../finding.md#f-63)): cột được định nghĩa là *"finding phải ✅ ĐÓNG **trước khi** bắt đầu"*, nhưng
8 dòng lại điền vào đó **chính finding mà task ấy sẽ đóng** — đọc đúng luật thì cả 8 vĩnh viễn không mở được.
Bẫy nằm ở **khuôn chứ không ở người viết**: khi một dòng vừa bị finding chặn vừa đóng finding, ô trống duy nhất
trông hợp lý là ô này. Dự án sau đặt tên cột là **Chặn bởi** và ghi ngay dưới bảng: *finding task này đóng
thì ghi ở cột **Đầu ra**, không ghi ở đây.*

## 2. Bốn cột **không** nên có

| Cột hay bị thêm | Vì sao bỏ | Dùng gì thay |
|---|---|---|
| **Ưu tiên** (cao/vừa/thấp) | Chữ không sắp xếp được; 3 tháng sau mọi dòng đều "cao" | Ba tầng ở §4: cờ chặn · đường găng · số thứ tự owner tự chọn |
| **Ước lượng giờ** | Không ai đo lại nên không ai sửa; đã có ràng buộc mạnh hơn là *vừa một session* (§9) | Vượt kích cỡ ⇒ **chẻ dòng**, không ⇒ ước lượng to hơn |
| **Người làm** | Cột **Lane** đã trả lời rồi — và lane mới là thứ quyết định gói nạp + biên nhận | Lane |
| **Trạng thái / % xong** | Suy ra được từ cột `#` và cột đầu ra ⇒ chép là đẻ nhà thứ hai; đúng thứ [F-39](../finding.md#f-39) bắt được | Dấu `~~ ✅` + `make status` |

Luật chung đứng sau bảng này: **suy ra được bằng lệnh thì cấm chép thành cột.** Mỗi cột thêm vào là một cột
phải sửa tay ở **mọi** dòng mỗi lần đổi luật.

## 3. Bảy luật viết một dòng task

1. **Kích cỡ:** 1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một session. Vượt ⇒ **chẻ trước khi làm**.
   Task chạm 2 lane là hai task, vì biên nhận của hai lane là hai lệnh khác nhau.
2. **Phép thử task hay finding** (hỏi *trước* khi viết dòng nào): chạy hết kế hoạch **y như nó viết** — dòng này còn không?
   Còn ⇒ **finding** (đang sai bây giờ). Mất ⇒ **task** (chưa tới lượt xây). Câu mở đầu bằng *"chưa có X"* gần như luôn là task.
3. **Đầu ra là lệnh, không phải tính từ.** "Hoạt động tốt", "đã rà" không đóng được task. Sửa lỗi thì đầu ra
   phải **đỏ trên code cũ, xanh trên code mới**, dán cả hai output.
4. **Đếm được bằng lệnh thì ghi lệnh, đừng ghi số.** Con số trong dòng task hỏng sớm nhất — version, số test, số bảng.
5. **Đóng một phần ⇒ ghi rõ phần còn lại và mã task sẽ đóng nốt.** Bóp nhỏ phạm vi cho vừa cái đã làm là cấm.
6. **Dòng dời/đổi tên file phải mở sẵn task dọn con trỏ cho từng lane bị ảnh hưởng, trong cùng commit dời** —
   khuôn này đã lặp 5 lần và đẻ 8 finding ([06 §3.2](06-lich-su-du-an.md)).
7. **Trạng thái chỉ ghi một nơi.** Dấu ✅ + biên nhận ⇒ dòng task. Trạng thái finding ⇒ sổ finding. Ảnh chụp hệ thống ⇒ `status/`.

## 4. Dòng đầu file phải trả lời "làm gì tiếp" **bằng lệnh**

Khối mở đầu từng dài 39 dòng kể lại session trước; cắt còn 5 dòng lệnh (`T-50`, [F-39](../finding.md#f-39)).
Chuyện session trước đã nằm ở sổ finding + `git log`, chép lại là nhà thứ hai. Ba tầng ưu tiên, đúng thứ tự:

| Tầng | Nghĩa | Lấy ra bằng |
|---|---|---|
| **🔺 cờ chặn** | Hỏng thứ này thì mọi session sau đều sai | `grep -n '^| \*\*T-' task.md \| grep '🔺' \| head -1` |
| **Đường găng** | Trượt là trượt ngày lên sóng | dòng `**Đường găng` + dò task đầu tiên chưa gạch |
| **⚑n** | Thứ tự owner tự chọn cho việc ngoài đường găng | `grep -o '^| \*\*T-[0-9]*\*\* ⚑[0-9]' task.md \| sort -k3` |

Hết cả ba mới đọc theo thứ tự file — và phải ghi rõ ngay đó: **thứ tự file ≠ thứ tự ưu tiên**.
Giai đoạn 0 xếp trước vì nó là nền, không phải vì nó gấp hơn.

## 5. Bốn phép đo sức khoẻ của bảng task

Lane NON-CODE không có compiler, nên bảng task phải tự kiểm bằng lệnh. Chạy từ gốc repo:

```sh
grep -c '^| \*\*T-\|^| ~~\*\*T-' task.md                       # 1. tổng số dòng task
grep '^| \*\*T-\|^| ~~\*\*T-' task.md | grep -c '⚠️+'          # 2. task 2 lane — phải là 0 (§9)
awk -F'|' '/^\| (~~)?\*\*T-/ && NF < 9 { print $2 }' task.md    # 3. dòng thiếu cột bắt buộc — phải rỗng
for f in $(grep '^| \[F-' finding.md | grep -v '✅ ĐÓNG' | grep -o 'F-[0-9]*' | sort -u); do
  grep -q "finding.md#$(echo $f | tr 'A-Z' 'a-z'))" task.md || echo "BỎ RƠI: $f"
done                                                            # 4. finding không task nào đóng
```

Ngưỡng của phép đo 3 là **7 cột bắt buộc** (`NF < 9`), không phải 8 — cột *Prompt mở session* cố ý điền muộn (§6).
Phép đo 4 quan trọng nhất và hay bị hiểu ngược: ra tên finding là **lỗi của task.md**, không phải của sổ finding.
Cả bốn lệnh thay cho một bảng đối chiếu 32 dòng chép tay đã bỏ (`T-49`).

## 6. Bảy bài học đã trả tiền để biết

| Triệu chứng | Nguyên nhân thật | Luật rút ra |
|---|---|---|
| 23/65 dòng sổ finding là *"chưa có X"*, không bao giờ đóng được | Sổ lỗi bị dùng làm backlog ⇒ mọi thứ đều kêu, mất khả năng báo động | Nợ xây dựng vào **task.md** ngay từ dòng đầu tiên (§3.2) |
| 8 task vĩnh viễn không mở được | Một cột mang hai nghĩa ngược nhau ([F-63](../finding.md#f-63)) | Mỗi cột **một** nghĩa, viết định nghĩa ngay dưới bảng |
| Sửa luật một lần ⇒ phải sửa tay 78 ô *Prompt* | Điền trước cả bảng thứ suy ra được | Điền cột prompt **khi task sắp được giao**; xong thì sinh bằng `make prompt T=T-xx` |
| Khối mở đầu 39 dòng kể chuyện session trước | Tường thuật thay cho lệnh chọn | Dòng đầu file là **lệnh**, không phải nhật ký (§4) |
| Bảng đối chiếu finding→task 32 dòng luôn lệch | Chép thứ suy ra được | Thay bảng bằng lệnh dò (§5) |
| 8 finding con trỏ gãy, cùng một khuôn, lặp 5 lần | Lane dời file **bị cấm** sửa file lane khác — đây là **giá phải trả**, không phải sơ suất | §3.6: mở sẵn task dọn cùng commit dời |
| Số/version trong dòng task lệch code sau vài giờ | Ghi số thay vì ghi lệnh sinh ra số | §3.4 |

## 7. Bản mẫu cho dự án mới

Ngày 1 **không** dựng đủ 8 cột — thêm cột vào đúng lúc nó bắt đầu đau, và ghi lại lý do thêm:

| Lúc nào | Cột tối thiểu |
|---|---|
| Dòng task đầu tiên | `#` · Task · **Đầu ra kiểm chứng được** |
| Khi có > 1 lane (DB/BE/FE/DevOps/giấy tờ) | + Lane |
| Khi một session phải hỏi lại "lấy gì để bắt đầu" | + Context |
| Khi có task làm sai thứ tự, hoặc xây lên chỗ đã biết hỏng | + Cần xong trước · Chặn bởi |
| Khi owner phải gõ lại cùng một đoạn mở session | + Prompt mở session |

```markdown
| # | Lane | Task | Context | Cần xong trước | Chặn bởi | Đầu ra kiểm chứng được | Prompt mở session |
|---|------|------|---------|----------------|----------|------------------------|-------------------|
| **T-01** | BE | <động từ> `<file>` | **Nạp:** … · **Đã chốt:** … · **Bẫy:** … | — | [F-xx](finding.md#f-xx) | `<lệnh>` → `<kết quả mong đợi>` → đóng **[F-yy]** | Lane: BE · task T-01 · … · dừng khi … |
```

**Cái giá, nói thẳng.** Bảng này không miễn phí: ở dự án này phần lớn commit mang tiền tố `NON-CODE`
(48/67 ngày 2026-08-14 — đếm lại bằng `git log --format='%s' | sed 's/[\/:].*//' | sort | uniq -c | sort -rn`
và `git log --oneline | wc -l`). Đổi lại là mỗi thay đổi đều có
điểm lùi, có biên nhận, và không lane nào âm thầm sửa file lane khác. Dự án một người, một tuần, một lane
thì 3 cột đầu là đủ — dựng cả 8 cột lúc đó chỉ tạo ra sổ sách để bảo trì.
