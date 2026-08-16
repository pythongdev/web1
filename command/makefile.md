# Đọc `command/Makefile` — từng lệnh giải quyết kiểu hỏng nào

> Cập nhật **2026-08-15** · Lane sở hữu: **DevOps** · Giải thích cho [command/Makefile](Makefile).
> File này **không giữ lệnh nào** — lệnh thật nằm ở [Makefile](Makefile) ([CLAUDE.md §2](../CLAUDE.md)).
> Lệch với Makefile ⇒ **Makefile thắng**; dòng sai ở đây là bug phải sửa ngay.

## Bản đồ 5 target

**Target** = một cái tên gõ sau `make`, ví dụ `make status`. Gõ `make` trống thì chạy `check`
(do dòng `.DEFAULT_GOAL := check`, xem [§5](#5-ba-dòng-khai-báo-ở-đầu-file)).
Gõ ở **gốc repo**: `./Makefile` `include command/Makefile`, nên mọi đường dẫn bên trong tính từ gốc, không phải từ `command/`.

### Hai loại target — đừng lẫn

|  | **Cổng** (`check`, `check-links`, `check-task-cols`) | **Tra cứu** (`status`, `next-id`) |
|---|---|---|
| Trả về gì | Mã thoát: `0` = xanh, `≠0` = đỏ | Chỉ in ra màn hình |
| Đỏ được không | Có — và đỏ nghĩa là **đang có thứ lệch ngay bây giờ** | Không bao giờ |
| Đóng được task không | **Có** — output của nó là biên nhận, dán vào [sổ task](../project_preparation/project_preparation_task_finding/task_project_preparation.md) | **Không** — chỉ để bạn nhìn trước khi quyết |
| Ai đọc | CI + người duyệt | Bạn, lúc đang làm |

Chỗ dễ hiểu sai nhất: **đỏ ≠ "cần rà lại"**. Đỏ là một mệnh đề sai được, chỉ ra đúng file và đúng dòng.
Không có tình trạng "đỏ nhưng chấp nhận được" — nếu chấp nhận được thì phải sửa phép đo, không phải bỏ qua nó.

### Cây gọi

```
make                       ← .DEFAULT_GOAL := check
└── check                  chạy CẢ HAI phép dưới rồi mới kết luận, không dừng ở phép đầu
    ├── check-links        phép 1 — con trỏ gãy
    └── check-task-cols    phép 4 — dòng task lệch cột

make status                đứng riêng, không ai gọi nó
make next-id               đứng riêng, không ai gọi nó
```

Vì sao `check` không dừng ở phép hỏng đầu tiên: một lần chạy phải thấy **hết** chỗ lệch.
Dừng sớm thì bạn sửa một cái, chạy lại, lại đỏ chỗ khác — mỗi vòng là một lần trả tiền.

### Từng target trả lời câu hỏi nào

| Gõ | Loại | Trả lời câu hỏi | Đỏ khi | Gõ lúc nào |
|---|---|---|---|---|
| `make check` → [mổ kỹ ở §0](#0-check--cổng-mổ-từng-khúc) | cổng | *"Sổ sách có đang lệch không?"* | Bất kỳ phép con nào đỏ | **Bước KIỂM CHỨNG** của mọi session lane giấy tờ ([CLAUDE.md §3](../CLAUDE.md)) — trước khi commit |
| `make check-links` | cổng | *"Có link nào trỏ vào file không tồn tại không?"* | Có ít nhất 1 đích không tồn tại | Sau khi `git mv` / đổi tên / xoá file `.md` |
| `make check-task-cols` | cổng | *"Dòng task nào sai số cột?"* | Có dòng `T-xx` mà `NF != 8` | Sau khi thêm/sửa dòng trong bảng task |
| `make status` | tra cứu | *"Repo đang ở đâu?"* | — | **Bước ĐỊNH VỊ**, đầu session, trước khi tin bất cứ con số nào trong tài liệu |
| `make next-id` | tra cứu | *"Task mới lấy mã nào?"* | — | Ngay trước khi viết một dòng task mới |

### Ví dụ thực tế — 5 lần gõ, 5 output

> Các khối dưới đây là **ảnh chụp một lần chạy thật**, để bạn biết *hình dạng* output trông ra sao.
> Số trong đó **sẽ khác** khi bạn gõ — muốn số đúng thì chạy lệnh, đừng tin số ở đây.

**a) `make check` — cổng, lúc ĐỎ**

```console
$ make check
phép 1 · link chết:
  project_preparation/task_guiline.md:25 -> project_preparation/../finding.md
  project_preparation/07-cau-truc-du-an.md:9 -> project_preparation/06-lich-su-du-an.md
  … (còn nhiều dòng)
  đích không tồn tại: project_preparation/../finding.md
  đích không tồn tại: project_preparation/06-lich-su-du-an.md
  đích không tồn tại: project_preparation/../design/data_base/README.md
phép 4 · dòng task lệch cột: không có
make check: ĐỎ
make: *** [check] Error 1
$ echo $?
2
```

Đọc thế nào: phép 1 đỏ, phép 4 xanh, **nhưng `check` vẫn chạy hết cả hai** rồi mới kết luận.
Ba dòng `đích không tồn tại` mới là **việc phải làm** — 19 dòng gãy nhưng chỉ 3 file cần dựng/trỏ lại.
`$?` khác `0` ⇒ **không được commit**, không được ghi "xong" vào sổ task.

**b) `check-links` — vì sao một link SỐNG, một link CHẾT**

File demo `project_preparation/task_guiline.md`:

```md
Dòng 3: link SỐNG   -> [07](07-cau-truc-du-an.md)
Dòng 4: link CHẾT   -> [sổ finding](../finding.md)
Dòng 5: link Internet, bỏ qua -> [Anthropic](https://anthropic.com)
Dòng 6: neo trong file, bỏ qua -> [xem mục 4](#muc-4)
Dòng 7: có neo, phải cắt đuôi -> [07 dòng 42](07-cau-truc-du-an.md#L42)
```

Chạy đúng awk của phép 1, in ra **cả link sống lẫn chết** cho dễ đối chiếu:

```console
  SỐNG  project_preparation/task_guiline.md:3 -> project_preparation/07-cau-truc-du-an.md
  CHẾT  project_preparation/task_guiline.md:4 -> project_preparation/../finding.md
  SỐNG  project_preparation/task_guiline.md:7 -> project_preparation/07-cau-truc-du-an.md
```

Năm điều đọc được, mỗi điều ứng đúng một khúc awk ở [§1](#1-check-links--mổ-từng-khúc):

| Dòng | Chuyện gì xảy ra | Khúc awk chịu trách nhiệm |
|---|---|---|
| 3 | `07-…md` giải thành `project_preparation/07-…md` — **cộng thư mục của file đang đọc**, không phải thư mục bạn đang đứng | `FNR==1 { d=FILENAME; … }` |
| 4 | `../finding.md` giải thành `project_preparation/../finding.md`, file không có ⇒ **CHẾT** | `[ -e "$p" ]` |
| 5 | không xuất hiện trong output — link Internet **không phải việc của lệnh này** | `if (t ~ /^(https?:\|mailto:\|#)/)` |
| 6 | không xuất hiện — neo trong cùng file, cũng bỏ qua | cùng dòng trên |
| 7 | `#L42` bị cắt, kiểm tra `07-…md` ⇒ **SỐNG** (không đi tìm file tên `07-…md#L42`) | `sub(/#.*$/, "", t)` |

Còn dòng link tới `06-lich-su-du-an.md` nằm trong khối ```` ```md ```` thì **không hề xuất hiện** trong output —
dù file đó thật sự không tồn tại. Đó là bẫy F-60 bị chặn: không có cờ `c`, file hướng dẫn sẽ **tự tố cáo chính nó**.

Chính câu vừa rồi là một ví dụ sống: nếu tôi viết link `[06]` đó **trần ra văn xuôi** thay vì gọi tên nó,
thì `make check` sẽ đỏ ngay tại đây — và đỏ **đúng**, vì với awk thì link ví dụ và link thật không khác gì nhau.

**c) `check-task-cols` — bảng task demo có 4 dòng, 3 dòng đỏ**

```md
| Mã | Việc | Lane | Chặn bởi | Đầu ra | Context |
|---|---|---|---|---|---|
| **T-01** | Dựng Makefile | DevOps | — | `make check` xanh | 07 §4 |
| **T-02** | Thiếu 1 cột | DevOps | — | `make check` xanh |
| **T-03** | Ô chứa dấu \| trần | NON-CODE | T-02 | a | b | c |
| ~~**T-04**~~ | Dòng đã gạch, vẫn bị soi | FE | — | build xanh |
```

```console
$ awk -F'|' '/^\| (~~)?\*\*T-/ && NF != 8 { printf "  %s (NF=%d, cần 8)\n", $2, NF }' task_demo.md
   **T-02**  (NF=7, cần 8)
   **T-03**  (NF=10, cần 8)
   ~~**T-04**~~  (NF=7, cần 8)
```

- `T-01` đủ 6 cột ⇒ `NF=8` ⇒ im lặng. **8 = 6 cột + 1 mảnh rỗng đầu + 1 mảnh rỗng cuối**, vì dòng mở và đóng bằng `|`.
- `T-02` thiếu ô *Context* ⇒ `NF=7`. Đây là ca **nguy hiểm nhất**: nhìn bằng mắt vẫn thấy "có vẻ đủ", nhưng mọi ô sau chỗ thiếu đã **tụt sang trái một bậc**.
- `T-03` có dấu `|` trần trong ô ⇒ `NF=10`. Cùng một phép đo bắt luôn bệnh này, không cần lệnh thứ hai.
- `T-04` đã gạch `~~` **vẫn bị soi** — nhờ `(~~)?`. Dòng xong mà lệch cột thì lịch sử đọc sai vĩnh viễn.

**d) `make next-id`**

```console
$ make next-id
T-20
```

Một dòng, dán thẳng vào sổ task. Nó **không** nhìn vào chỗ trống: nếu `T-07` bị xoá, `next-id` vẫn trả `T-20`,
vì luật là mã không bao giờ tái sử dụng.

**e) `make status`** — xem cách đọc ở ngay dưới.

### Đọc output của `make status`

```console
$ make status
commit          : 6
commit theo lane:
   2   NON-CODE
   2   FE
file .md        : 169
task chưa gạch  : 19
task đã gạch    : 0
```

Năm dòng nó in, mỗi dòng là một câu hỏi khác nhau — đừng đọc lướt thành "một cục thống kê":

| Dòng | Nghĩa | Dùng để làm gì |
|---|---|---|
| `commit` | tổng số commit | Ước lượng repo đã đi được bao xa |
| `commit theo lane` | đếm theo tiền tố `BA:` `DB:` `BE:` `FE:` `DEVOPS:` `NON-CODE:` | **Tổng các lane < tổng commit ⇒ có commit thiếu tiền tố** — đúng cái T-13 định chặn bằng `git` hook |
| `file .md` | số nhà tài liệu | So với số file code: tỷ lệ này là sức khoẻ thật của repo |
| `task chưa gạch` | dòng `\| **T-` | Còn bao nhiêu việc |
| `task đã gạch` | dòng `\| ~~**T-` | Đã đóng bao nhiêu — đóng đúng luật thì phải có đủ 3 dấu (biên nhận · commit · ngày) |

Ba thứ đọc được từ đúng ảnh chụp ở trên:

1. **`2 + 2 = 4 < 6` ⇒ có 2 commit không mang tiền tố lane.** Không dòng nào in ra chữ "sai" — bạn phải **tự trừ**.
   Đây đúng là lỗ mà T-13 định bịt bằng `git` hook; trước khi có hook, `make status` là cách duy nhất thấy nó.
2. **`task đã gạch : 0`** ⇒ chưa task nào đóng đúng luật, dù việc đã làm. Đóng đúng cần đủ ba dấu: biên nhận có output · commit chứa thay đổi · gạch dòng kèm ngày.
3. **`file .md` so với số file code** ⇒ tỷ lệ giấy tờ / code. Đây là con số đau nhất repo đang mang.

Nhắc lại vì đây là chỗ dễ hỏng nhất: những con số trên là **ảnh chụp**, không phải sự thật.
Đừng chép chúng sang file khác, đừng trích dẫn lại — chạy `make status`.
Trạng thái là sự thật **không có nhà** ([CLAUDE.md §2](../CLAUDE.md)); mọi con số gõ tay vào tài liệu đều sẽ sai, chỉ là chưa biết ngày nào.

---

## 0. `check` — cổng, mổ từng khúc

```make
check:
	@rc=0; \
	$(MAKE) --no-print-directory check-links     2>/dev/null || rc=1; \
	$(MAKE) --no-print-directory check-task-cols 2>/dev/null || rc=1; \
	if [ $$rc -eq 0 ]; then echo "make check: XANH"; else echo "make check: ĐỎ"; fi; \
	exit $$rc
```

### "Cổng" nghĩa là gì

Không phải "chạy cho biết". Cổng là thứ **có quyền chặn**: nó trả về một **mã thoát**, và mã thoát đó là thứ
`git` hook / CI / người duyệt đọc để quyết định cho qua hay không. Ba tính chất làm nên một cổng:

| Tính chất | Ở đây là gì | Nếu thiếu thì sao |
|---|---|---|
| **Máy đọc được** | `exit $$rc` — `0` cho qua, khác `0` chặn | Chỉ còn người đọc ⇒ quên là lọt |
| **Chạy lại ra kết quả cũ** | Cùng repo ⇒ cùng output, không phụ thuộc ai gõ | Không cãi được, thành ý kiến |
| **Chỉ đúng chỗ hỏng** | In ra `file:dòng -> đích` | Biết "có gì đó sai" mà không sửa được ⇒ bị bỏ qua |

### Từng dòng làm gì

- **`rc=0` rồi `|| rc=1`** — biến gom lỗi. Đây là lý do `check` **chạy hết cả hai phép** rồi mới kết luận:
  `||` nuốt lỗi của từng phép để shell không chết giữa chừng, nhưng đã đỏ thì `rc` không bao giờ về `0` lại.
  Nếu viết `check-links && check-task-cols` thì phép 4 **không bao giờ chạy** khi phép 1 đỏ — bạn sửa xong link, chạy lại, mới biết còn lệch cột. Mỗi vòng như vậy là một lần trả tiền.

- **`$(MAKE) … check-links`** — gọi **lại target**, không chép lệnh. Đây là [CLAUDE.md §2](../CLAUDE.md) ở dạng thi hành:
  lệnh có **một nhà duy nhất**. Sửa phép 1 thì `check` tự đúng theo, không có bản sao nào ở lại phía sau.

- **`--no-print-directory`** — bỏ dòng `make: Entering directory …`. Output của cổng là thứ **dán vào sổ task** làm biên nhận; rác trong đó làm người đọc phải lọc bằng mắt.

- **`2>/dev/null`** — giấu dòng `make: *** [check-links] Error 1` của lệnh con. Đỏ đã được nói bằng tiếng Việt ở trên rồi, thêm dòng lỗi thô chỉ làm người mới tưởng Makefile hỏng. **Đánh đổi:** nó cũng giấu luôn lỗi thật của `awk`/`find` — xem lỗ đã biết ở dưới.

- **`exit $$rc`** — trả mã thoát ra ngoài. Thiếu dòng này thì `check` **luôn xanh** với máy, dù màn hình in chữ ĐỎ.

### Đọc mã thoát cho đúng

```console
$ make check-links     >/dev/null 2>&1; echo $?
2
$ make check-task-cols >/dev/null 2>&1; echo $?
0
$ make check           >/dev/null 2>&1; echo $?
2
```

Recipe `exit 1`, nhưng `make` bọc lại thành **`2`**. Nên khi viết hook/CI: so **`-ne 0`**, đừng bao giờ so `-eq 1`.

### "Đỏ khi bất kỳ phép con nào đỏ" — nhìn thấy được

```console
$ make check
phép 1 · link chết:
  … (19 dòng)
phép 4 · dòng task lệch cột: không có     ← vẫn chạy, dù phép 1 đã đỏ
make check: ĐỎ
```

Một phép đỏ là cả cổng đỏ. Không có "đỏ nhẹ", không có "đỏ chỗ này thì bỏ qua chỗ kia".

### "Gõ ở bước KIỂM CHỨNG, trước khi commit" nghĩa là

Vòng lặp session ([CLAUDE.md §3](../CLAUDE.md)) là `… LÀM → TỰ RÀ → KIỂM CHỨNG → GHI SỔ`. `check` đứng ở **KIỂM CHỨNG**, tức **sau khi sửa xong, trước khi `git commit`**:

| Thứ tự | Làm gì | Vì sao đúng chỗ đó |
|---|---|---|
| 1. LÀM | sửa file | |
| 2. TỰ RÀ | `git diff --stat` | Thấy file lạ ⇒ dừng, không stage |
| 3. **KIỂM CHỨNG** | **`make check`** | Đỏ ở đây thì **sửa tiếp**, chưa được commit |
| 4. GHI SỔ | `git add <đường dẫn>` → commit → gạch dòng task kèm ngày | Dán **output thật** của bước 3 làm biên nhận |

Hai luật hay bị vi phạm ở khúc này:

- **"Đã viết code" ≠ "đã chạy".** Chưa dán được output thì task **chưa xong**, dù file đã sửa.
- **Đỏ ≠ "cần rà lại".** Đỏ là mệnh đề sai được, có file và dòng. Chỉ có hai lối ra: **sửa cho xanh**, hoặc **sửa phép đo** nếu phép đo mới là cái sai. Không có lối thứ ba tên "chấp nhận".

### Lỗ đã biết của cổng này

`check` không phân biệt **"quét mà không thấy lỗi"** với **"không quét gì cả"**:

```console
$ make check DOCS=
phép 1 · link chết: không có
phép 4 · dòng task lệch cột: không có
make check: XANH
$ echo $?
0
```

Phạm vi rỗng ⇒ `find` không ra file nào ⇒ `out` rỗng ⇒ báo **XANH**. Cùng cơ chế đó, nếu `awk` hỏng cú pháp,
`2>/dev/null` nuốt lỗi và cổng vẫn xanh. **Xanh giả nguy hiểm hơn đỏ**, vì đỏ thì có người sửa, còn xanh giả thì không ai nhìn lại.
Cách bịt: đếm số file đã quét, `0` file thì đỏ. **Chưa có lệnh** — đây là nợ, thuộc lane DevOps.

---

## 1. `check-links` — mổ từng khúc

```sh
find $(DOCS) -name '*.md' -print0 | xargs -0 awk '…' | while read f n p; do [ -e "$p" ] || echo …; done
```

- **`find … -print0` + `xargs -0`** — cắt danh sách file bằng ký tự `NUL` thay vì xuống dòng.
  Đường dẫn có dấu cách vẫn đúng (máy bạn có sẵn thư mục `claude restaurant`; kiểu tên đó làm hỏng vòng lặp thường).

- **`FNR==1 { d=FILENAME; sub(/\/[^\/]*$/,"",d) }`** — mỗi lần sang file mới, lấy thư mục chứa nó.
  Bắt buộc: link trong Markdown là **tương đối với file**, không tương đối với chỗ bạn gõ `make`.
  `../finding.md` trong `project_preparation/07-….md` phải giải ra gốc repo, không phải `./`.

- **````/^[ \t]*```/ { c=!c; next }```` rồi `c { next }`** — bật/tắt cờ khi gặp hàng rào ```` ``` ````, bỏ qua mọi dòng bên trong.
  Đây là chỗ chặn **bẫy F-60**: file hướng dẫn chứa link ví dụ trong code block và sẽ tự tố cáo chính nó.
  Đo được: loại đúng 2 dương tính giả (`task_guiline.md:128`, `design/fe/README.md:16`), không mất link thật nào.

- **`while (match(l, /\]\([^)]*\)/))`** — vòng lặp chứ không khớp một lần, vì một dòng có nhiều link
  (dòng 260 của một file wireframe có 3 cái).

- **`if (t ~ /^(https?:|mailto:|#)/) continue`** — link ra Internet và neo trong cùng file không phải việc của lệnh này;
  nó chỉ gác file **trong repo**.

- **`sub(/#.*$/, "", t)`** — cắt đuôi neo: `task.md#L42` phải kiểm tra `task.md` tồn tại,
  chứ không đi tìm một file tên `task.md#L42`.

- **`[ -e "$p" ]`** — phép thử thật sự. Dùng `-e` chứ không `-f` để **link trỏ vào thư mục** cũng hợp lệ:

  ```md
  [src/utils/](src/utils/)
  ```

  (ví dụ trên **bắt buộc** nằm trong khối code — để trần ra văn xuôi thì chính nó bị bắt là link chết, đúng bẫy F-60 ở gạch đầu dòng trên.)

- **`sed 's/.*-> //' | sort -u`** — in thêm danh sách **đích** đã gộp. 19 dòng gãy nhưng chỉ 3 đích;
  sửa 3 đích là xong, còn đọc 19 dòng thì tưởng là 19 việc.

> **Vì sao đáng có:** [07 §5.2](../project_preparation/07-cau-truc-du-an.md) ghi khuôn này lặp 5 lần `git mv`, đẻ 8 finding con trỏ gãy.
> Luật *"grep trước khi dời"* phải có người nhớ mới chạy; lệnh này biến nó thành **thứ tự cưỡng chế ngay tại commit sinh ra lỗi**.

---

## 2. `check-task-cols`

```sh
awk -F'|' '/^\| (~~)?\*\*T-/ && NF != 8 { … }' $(TASK)
```

Bảng task có **6 cột** ⇒ cắt theo `|` ra **8 mảnh** (một mảnh rỗng trước dấu `|` đầu, một rỗng sau dấu cuối).

`NF != 8` bắt hai bệnh cùng lúc: dòng **thiếu/thừa cột**, và ô nào lỡ chứa **dấu `|` trần**.
`(~~)?` để dòng **đã gạch xong** vẫn bị soi — dòng xong mà lệch cột thì lịch sử đọc sai.

> **Vì sao:** F-63 — cột mang hai nghĩa làm 8 task vĩnh viễn không mở được.
> Cột lệch **âm thầm** còn tệ hơn: ô *Chặn bởi* tụt sang ô *Đầu ra*, task trông như đã sẵn sàng.

---

## 3. `status`

```sh
git log --oneline | wc -l                                  # số commit
git log --format='%s' | sed -n 's/^\([A-Z][A-Z-]*\):.*/  \1/p' | sort | uniq -c | sort -rn
find . -name '*.md' -not -path './.git/*' | wc -l          # số nhà tài liệu
grep -c '^| \*\*T-' $(TASK)                                # chưa gạch
grep -c '^| ~~\*\*T-' $(TASK)                              # đã gạch
```

`sed -n 's/^\(...\):.*/\1/p'` lấy **tiền tố lane** trước dấu `:` của tiêu đề commit — commit nào không có tiền tố thì
không xuất hiện trong bảng đếm, và chênh lệch đó chính là cái **T-13** định chặn bằng `git` hook.

> **Vì sao:** [CLAUDE.md §2](../CLAUDE.md) — trạng thái là sự thật **không có nhà**. Chép nó vào file là bảo đảm sẽ trôi;
> [07 §3](../project_preparation/07-cau-truc-du-an.md) đã cắt cả thư mục `status/` vì bệnh này.
> Tỷ lệ *file code / file `.md`* là con số đau nhất trong repo — và nó **chỉ có giá trị khi luôn được sinh lại**
> bằng `make status`, không bao giờ được gõ tay vào đây.

---

## 4. `next-id`

```sh
grep -o 'T-[0-9][0-9]*' $(TASK) | sed 's/T-//' | sort -n | tail -1 | awk '{ printf "T-%02d\n", $1 + 1 }'
```

- `T-[0-9]` **không** khớp `T-FE-01` — hai dải mã tách bạch đúng như đầu sổ task khai.
- `sort -n` (số) chứ không `sort` (chữ), nếu không `T-9` sẽ lớn hơn `T-19`.
- Lấy **max+1**, không lấp chỗ trống — vì luật là **mã không bao giờ tái sử dụng**.

---

## 5. Ba dòng khai báo ở đầu file

| Dòng | Vì sao có |
|---|---|
| `DOCS := CLAUDE.md project_preparation design quality plan` | Phạm vi gác, **khai ra** để sửa được và cãi được, thay vì chôn trong lệnh |
| `.DEFAULT_GOAL := check` | Gõ trống `make` là chạy **cổng**, không phải target đầu tiên tình cờ |
| `.PHONY:` | Báo cho `make` biết đây là **hành động**, không phải file cần build; thiếu nó, ngày nào đó có file tên `status` là target chết im lặng |
