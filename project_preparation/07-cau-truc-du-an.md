# Bộ khung dự án — file nào tồn tại, lane nào giữ, cắt cái gì

> Cập nhật **2026-08-14** · Lane sở hữu: **NON-CODE**. Nhà của **bộ khung thư mục cho một dự án mới**:
> *file nào được phép tồn tại, mỗi file giữ sự thật gì, lệnh nào bắt được khi nó trôi.*
> Bộ khung thật của dự án này ở [CLAUDE.md](../CLAUDE.md) §1–§2; lệch ⇒ **CLAUDE.md thắng**, dòng ở đây là bug.
>
> File này **không** giữ: khuôn bảng task ([task_guiline.md](task_guiline.md)) · khuôn sổ finding
> ([finding_guiline.md](finding_guiline.md)) · khuôn prompt ([prompt_guiline.md](prompt_guiline.md)) ·
> *vì sao sổ dự án này phình* ([06-lich-su-du-an.md](06-lich-su-du-an.md)). Bốn file đó là **nội dung của từng ô**;
> file này là **sơ đồ căn nhà**. Đọc file này trước, ba file kia khi dựng tới ô tương ứng.

**Luận điểm.** Bộ khung không phải bộ tài liệu. Mỗi file là **một nhà giữ sự thật**, và chi phí bảo trì tỉ lệ với
**số nhà**, không tỉ lệ với số dòng. Một file chỉ được sinh ra khi trả lời được cả ba câu:
**giữ sự thật nào chưa có ở đâu khác · lane nào sở hữu · lệnh nào đỏ khi nó lệch thực tế.**
Thiếu câu thứ ba là file sẽ trôi trong im lặng — đó là loại hỏng đắt nhất, vì nó không báo.

---

## 0. Lệnh sinh lại mọi con số dưới đây

Con số trong tài liệu hỏng sớm nhất ([CLAUDE.md §10](../CLAUDE.md), `F-13`). Chạy từ gốc repo:

```sh
git log --oneline | wc -l                                              # tổng commit
git log --format='%s' | sed 's/[\/:].*//' | sort | uniq -c | sort -rn  # commit theo lane
find . -name '*.md' -not -path './.git/*' | wc -l                      # số nhà tài liệu
find . -name '*.md' -not -path './.git/*' -print0 | xargs -0 cat | wc -l   # tổng dòng tài liệu
find be fe -type f 2>/dev/null | wc -l                                 # số file code
grep -c '^### F-' ../finding.md                                        # tổng finding
```

Ảnh chụp **2026-08-14**: 67 commit (48 mang tiền tố `NON-CODE`) · 37 file `.md` ≈ 7.900 dòng · 25 file code, `fe/` rỗng.
Đây là dữ liệu để thiết kế, không phải để trách: bộ khung đã dựng xong **trước khi có sản phẩm để nó quản lý**.

## 1. Sáu quy luật, mỗi cái có giá đã trả

| Quan sát đo được trên repo này | Quy luật mang sang dự án sau |
|---|---|
| 37 file `.md` / ~7.900 dòng cho 25 file code | **Mỗi nhà mới là một nguồn trôi.** Đếm nhà, đừng đếm dòng |
| Lane NON-CODE dẫn đầu số finding ([06 §3.4](06-lich-su-du-an.md)) | **Lane không có lệnh đỏ thì lane đó trôi.** Lỗi tài liệu nằm im tới lượt rà tay |
| ~1/3 sổ là dòng *"chưa có X"* ([06 §3.1](06-lich-su-du-an.md)) | **Sổ gánh hai việc thì mất khả năng báo động.** Gác ở cửa vào, không dọn ở cửa ra |
| `F-63`: 8 task vĩnh viễn không mở được | **Cột mang hai nghĩa là cột chết.** Một ô = một câu hỏi |
| 8 finding con trỏ gãy, cùng khuôn, 5 đợt `git mv` ([06 §3.2](06-lich-su-du-an.md)) | Luật *một file một lane chủ* **đẻ** finding theo thiết kế ⇒ phải có lệnh bắt, đừng để thành dòng sổ |
| 7 dòng số/phiên bản ghi cứng ([06 §3.5](06-lich-su-du-an.md)) | **Luật không có lệnh cưỡng chế vẫn tái phát.** §10 viết đúng từ đầu mà vẫn thua |

Gộp một câu: **thứ sống sót là luật quy được về lệnh; thứ mất tiền là sự thật bị chép sang nhà thứ hai, trong lane không có compiler.**

## 2. Cây thư mục đề xuất — ~20 nhà

```
CLAUDE.md              luật + bản đồ · trần dòng cứng · KHÔNG giữ sự thật nào
README.md              cách chạy + luật nghiệp vụ không được phá
task.md                hàng đợi "xong/chưa" — gồm cả nợ xây dựng
finding.md             sổ "đúng/sai" — không nhận dòng "chưa có X"
Makefile               nhà duy nhất của mọi lệnh (CI chỉ gọi lại, cấm chép)

design/
  README.md            1 bản dùng chung: câu mới viết vào file nào · lệch thì ai thắng
  <lane>/              db · be · fe · devops
    01-thiet-ke.md     ý định: SẼ có gì, vì sao mô hình như vậy
    02-luat.md         "đúng" nghĩa là gì — mỗi luật quy về đúng 1 lệnh
    03-yeu-cau.md      agent phải biết gì TRƯỚC khi chạm code: gói nạp · biên nhận · bẫy

quality/
  00-bat-bien.md       bất biến xuyên lane + ADR — thứ không lane nào sở hữu một mình
  01-dinh-nghia-xong.md  định nghĩa XONG, checklist trước deploy / sau sự cố

scripts/check-docs.sh  compiler của lane giấy tờ (§4)
```

Mỗi nhà, ba câu hỏi bắt buộc trả lời được:

| Nhà | Giữ sự thật gì chưa có ở đâu khác | Ai thắng khi lệch | Lệnh gác |
|---|---|---|---|
| `CLAUDE.md` | Luật làm việc + con trỏ | nhà thật của từng sự thật | `wc -l` ≤ trần |
| `task.md` | Làm gì tiếp, theo thứ tự nào | task.md | phép đo ở [task_guiline §5](task_guiline.md) |
| `finding.md` | Cái đang **sai ngay bây giờ** | finding.md | phép đo ở [finding_guiline §6](finding_guiline.md) |
| `design/<lane>/01` | Ý định thiết kế | code, trừ chỗ **cố ý khác** đã khai trong header | `check-docs` phép 1–3 |
| `design/<lane>/02` | Ngưỡng, ràng buộc, "đúng" là gì | quality/ + 02 | biên nhận lane |
| `design/<lane>/03` | Hợp đồng với agent: nạp gì, chứng minh bằng gì | 03 (nói với agent, không nói về schema) | dòng khai lane của session |
| `Makefile` | Mọi lệnh | Makefile | CI gọi lại chính nó |

**Hiện trạng không có nhà** — nó là thứ *derive được từ code*, xem §3.

## 3. Bốn thứ phải cắt, kèm giá đã trả

| Cắt | Vì sao | Thay bằng |
|---|---|---|
| File `03-hien-trang.md` (×n lane) + cả thư mục `status/` | Ảnh chụp code là thứ **derive được** ⇒ giữ thành file là **bảo đảm** sẽ trôi. Đây đúng là nhóm bệnh [06 §3.5](06-lich-su-du-an.md) | `make status` in ra từ `git` / `ls` / `SHOW TABLES`. Muốn biết hiện trạng thì **chạy lệnh** |
| `step.md` tách rời `task.md` | Kế hoạch-không-thứ-tự và hàng đợi-có-thứ-tự là hai nửa của **một** sự thật; tách ra buộc mọi session mở hai file, rồi hai file lệch nhau | `01-thiet-ke.md` giữ *xây gì*, `task.md` giữ *thứ tự* |
| `README.md` riêng cho từng thư mục lane | Ba bản gần trùng của cùng một luật định tuyến (~240 dòng ở dự án này) | Một `design/README.md`; phần khác nhau giữa lane gói vào **một bảng "ai thắng khi lệch"** |
| Cột *Finding phải đóng* trong bảng task | Hai nghĩa ngược nhau ⇒ 8 task chết (`F-63`) | Hai ô riêng: **Chặn bởi** (phải đóng **trước**) · finding task này **đóng** ghi ở ô *Đầu ra* |

**Giữ nguyên vì đã chứng minh có lãi:** định tuyến lane + biên nhận là lệnh · bộ 3 file/lane tách bạch
*ý định ↔ thước ↔ hợp đồng với agent* · ID `F-xx`/`T-xx` cố định, **không tái sử dụng** · trần dòng cho file luật ·
luật **code thắng tài liệu**.

## 4. Mảnh còn thiếu — `make check-docs`, thứ đáng làm nhất

Lane giấy tờ là lane duy nhất không có lệnh đỏ, và nó dẫn đầu số finding. Một script ~40 dòng bắt được
**phần lớn nhóm bệnh 3.2 + 3.5** ngay tại commit sinh ra chúng, tức là chúng **không bao giờ kịp thành dòng sổ**:

```sh
# 1. link chết               → chặn trọn nhóm con trỏ gãy, ngay trong commit `git mv`
# 2. ngày header vs `git log -1 --format=%ad -- <file>`   → chặn tài liệu cũ âm thầm
# 3. số trần trụi không kèm lệnh sinh ra nó               → chặn nhóm F-13 / F-40 / F-55
# 4. dòng task thiếu cột bắt buộc      (awk -F'|' NF)
# 5. finding MỞ không mã task nào nhận → lỗi của task.md, không phải của sổ finding
# 6. wc -l file luật ≤ trần đã khai
```

Bản mẫu chạy được của phép 1–3 đã có ở [design/data_base/README.md §3](../design/data_base/README.md) — việc còn
lại là nâng từ *một thư mục* lên *toàn repo* rồi gắn vào `make check`. **Giữ nguyên cái bẫy đã trả tiền ở `F-60`:**
lệnh phải quét `0*.md`, **không** quét `*.md`, vì file hướng dẫn chứa đúng những chuỗi đang tìm và sẽ tự bắt chính mình.

Hai target nhỏ đi kèm, cùng một nguyên tắc *derive chứ không chép*: **`make status`** (thay cả thư mục `status/`)
và **`make prompt T=T-xx`** (thay việc điền tay cột prompt cho mọi dòng — [task_guiline §6](task_guiline.md)).

## 5. Hai luật đặt ở khâu **nhập**, không phải khâu dọn

Hai nguyên nhân lớn nhất của dự án này đều là lỗi *nhận vào*, nên dọn bao nhiêu lượt cũng tái phát:

1. **Phép thử finding↔task chạy trước khi gõ dòng đầu tiên**, viết ngay đầu sổ như điều kiện nhập
   (đầy đủ ở [finding_guiline §1](finding_guiline.md)). Dòng mở đầu bằng *"chưa có X"* đi thẳng sang `task.md`.
   Nếu luật này có từ ngày 1, sổ finding ở đây nhỏ hơn khoảng một phần ba và tỉ lệ đóng đọc được.
2. **Dời/đổi tên file: `grep` con trỏ TRƯỚC khi `git mv`, và mở sẵn task dọn cho từng lane bị ảnh hưởng
   trong cùng commit dời.** Khuôn này lặp 5 lần ⇒ theo [CLAUDE.md §7](../CLAUDE.md) nó phải lên thành luật.
   Có phép 1 của §4 thì luật này tự cưỡng chế, không cần ai nhớ.

## 6. Dựng theo giai đoạn — đừng dựng đủ từ ngày 1

Bài học đắt nhất không nằm trong sổ finding mà nằm ở tỉ lệ **48/67 commit là `NON-CODE` trong khi `fe/` còn rỗng**.
Thêm mỗi lớp **đúng lúc nó bắt đầu đau**, và ghi lại lý do thêm:

| Dấu hiệu kích hoạt | Thêm gì |
|---|---|
| Ngày 1 | `README.md` · `task.md` 3 cột (`#` · Task · **Đầu ra kiểm chứng được**) · `Makefile` |
| Hai session chạm hai vùng code khác nhau | + cột **Lane** · `design/<lane>/03-yeu-cau.md` (chỉ file này, chưa cần 01/02) |
| Một quyết định bị **quyết lại** lần thứ hai | + `01-thiet-ke.md` của lane đó · + cột **Context** |
| Xây tiếp lên một chỗ đã biết là hỏng | + `finding.md` · + cột **Chặn bởi** |
| Tài liệu lệch code **lần thứ hai** | + `scripts/check-docs.sh` — đúng lúc này, không sớm hơn |
| Luật đã đủ nhiều để tự mâu thuẫn | + `CLAUDE.md` có trần dòng; thêm luật ⇒ **thay hoặc gộp**, không thêm mục |

## 7. Ba ngưỡng tự cảnh báo — in ra ở `make status`

Vượt ngưỡng nghĩa là **dừng làm sổ sách, quay về làm sản phẩm**:

| Phép đo | Ngưỡng | Số của dự án này (2026-08-14) |
|---|---|---|
| commit `NON-CODE` / tổng commit | > **40%** | 48/67 ≈ 72% |
| finding đang MỞ | > **20 dòng** | 47 — nhưng ~1/3 là nợ ghi sai nhà ([06 §3.1](06-lich-su-du-an.md)) |
| dòng `.md` trên mỗi file code | > **100** | ~7.900 / 25 ≈ 320 |

Ba ngưỡng này **không phải chất lượng**, chúng là **cảnh báo lệch trọng tâm**. Vượt mà vẫn còn lý do chính đáng thì
ghi lý do vào [task.md](../task.md), đừng sửa ngưỡng.

## 8. Bản mẫu cho dự án mới

Ngày 1 chỉ cần đúng chừng này, và **không** cần thư mục nào:

```
README.md    cách chạy + luật nghiệp vụ không được phá
task.md      | # | Task | Đầu ra kiểm chứng được |
Makefile     make check
```

Mọi thứ trong §2 mọc lên từ ba file đó theo bảng kích hoạt §6. Nếu một file được sinh ra mà không trả lời được
ba câu ở đầu file này, nó chưa tới lúc — hoặc nội dung của nó thuộc về một nhà đã có.

**Cái giá, nói thẳng.** Bộ khung đầy đủ ở §2 chỉ có lãi khi dự án **nhiều lane, nhiều session, sống lâu** — nó mua
được: mọi thay đổi có điểm lùi, mọi việc xong có biên nhận, không lane nào âm thầm sửa file lane khác, và một
session chưa từng đọc repo vẫn mở việc được. Nó bán đi: thời gian. Dự án một người, một tuần, một lane thì
ba file ở §8 là đủ — dựng cả §2 lúc đó chỉ tạo ra sổ sách để bảo trì, và đó chính là điều đã xảy ra ở đây.
