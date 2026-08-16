# finding_project_preparation.md — sổ lỗi của hàng đợi liên lane

> Cập nhật **2026-08-16** · Lane sở hữu: **NON-CODE** · Khuôn: [finding_guiline.md](../finding_guiline.md)
> Hàng đợi anh em: [task_project_preparation.md](task_project_preparation.md) · Sổ lỗi lane FE: [finding_fe.md](../../design/fe/finding_fe.md)

**Cửa vào.** Sổ này nhận **mệnh đề sai được đang chặn hàng đợi liên lane**. Phép thử trước khi viết dòng nào
([finding_guiline §1](../finding_guiline.md)): chạy hết kế hoạch **y như nó viết** — dòng này còn không?
Còn ⇒ vào đây. Mất ⇒ nó là **task**, sang [task_project_preparation.md](task_project_preparation.md).

**Mã `F-xx` của repo này bắt đầu lại từ `F-01`** và **không liên quan** tới `F-13`/`F-39`/`F-60`/`F-63` mà
`task_guiline` và `finding_guiline` trích dẫn — những mã đó thuộc **repo đời trước, không mang sang**.
Giống `T-xx`, mã ở đây **không bao giờ tái sử dụng**.

**Đã cân nhắc và cố ý KHÔNG mở dòng nào** cho hai chỗ `prompt-fullstack §5` mà bảng task chưa đáp ứng —
§5.1 (task đẻ từ 3 lát cắt A/B/C) và §5.2 (tầng `Pha → Epic → Task`). Cả hai **mất đi** nếu chạy kế hoạch
y như nó viết: `T-05` nạp `prompt-fullstack §1→§10`, tức nó **sẽ đọc §5** trước khi đẻ master task đầu tiên.
Đó là *chưa tới lượt xây*, không phải *đang sai* — đúng vế bên phải của phép thử §1.

**Phép đo sức khoẻ sổ** (chạy từ gốc repo, cả hai phải rỗng):

```sh
S=project_preparation/project_preparation_task_finding/finding_project_preparation.md
for f in $(grep -E '^\| \[F-[0-9]+\]' $S | grep 'ĐÓNG' | awk -F'|' '{print $2}' | grep -oE 'F-[0-9]+'); do
  awk -v id="### $f" '$0==id{p=1;next} /^### F-/{p=0} p' $S | grep -q 'Bài học giữ lại' || printf '%s ' "$f"
done; echo                                                      # đóng mà không để lại bài học
awk '/^### F-/{getline; if (/✅ ĐÓNG|🔓 MỞ|⚠️ MỞ LẠI/) print NR}' $S   # trạng thái ghi ngoài cột
```

---

## Bảng tổng hợp

| ID | Mức | Finding | Lane | Trạng thái | Chặn việc gì | Context |
|---|---|---|---|---|---|---|
| [F-01](#f-01) | 🟠 | `prompt-fullstack §5.3` và `task_guiline §1` khai **hai khuôn khác nhau** cho cùng một sự thật *"một dòng task có cột gì"*, và `CLAUDE.md §2` không khai bên nào thắng | NON-CODE | 🔓 MỞ | Mọi session dựng hoặc sửa một bảng task · `T-11` | **Nạp:** [prompt-fullstack §5.3](../prompt-fullstack.md) dòng 351 · [task_guiline §1](../task_guiline.md) dòng 14 · [CLAUDE.md §2](../../CLAUDE.md) · **Đã chốt:** hai bảng task thật đều theo `task_guiline`, vì [CLAUDE.md §1](../../CLAUDE.md) route lane NON-CODE tới `task_guiline` chứ không tới `prompt-fullstack §5` — chưa session nào dựng bảng task từng đọc §5 · **Đóng đúng:** `CLAUDE.md §2` có thêm một dòng phân xử *hình dạng dòng task* trỏ về đúng một nhà, và nhà thua đặt link thay vì giữ khuôn riêng; `wc -l < CLAUDE.md` vẫn ≤ `60` · **Bẫy:** đừng đóng bằng cách chép cột của bên này sang bên kia — đó là đẻ nhà thứ ba. Và `prompt-fullstack.md` **chưa có `Lane sở hữu`** (`T-18` mới khai), nên sửa nó lúc này là chạm file chưa ai nhận |
| [F-02](#f-02) | 🟠 | `prompt-fullstack §8` bắt mọi `plan/*.md` xuất `MASTER TASK` **7 cột kèm `Hỏng thì mất gì`**, trong khi bảng đích có **6 cột** và `make check` chốt cứng `NF != 8` | NON-CODE | 🔓 MỞ | `T-11` (gom master task) · gián tiếp `T-05`→`T-10`, mỗi pha đẻ thêm một bảng 7 cột không có chỗ đổ | **Nạp:** [prompt-fullstack §8](../prompt-fullstack.md) dòng 461 · [§5.3](../prompt-fullstack.md) dòng 354 · `command/Makefile` target `check-task-cols` · **Đã chốt:** `T-11` chỉ nói *"mở thêm cột theo bảng kích hoạt"*, mà bảng kích hoạt [task_guiline §7](../task_guiline.md) **không có** cột `Hỏng thì mất gì` ⇒ chạy `T-11` y như nó viết thì cột kia bị vứt · **Đóng đúng:** chốt một trong hai — hoặc bảng task mở cột thứ 7 và `check-task-cols` đổi ngưỡng cùng commit, hoặc `§8` bỏ cột đó khỏi khuôn xuất — rồi dán output `make check` **đỏ trước xanh sau** · **Bẫy:** nội dung cột này đang **có thật nhưng chôn trong ô `Bẫy`** (T-08 *"thu thiếu 1.000đ mỗi suất"*, T-FE-06 *"sai một phép cộng là mất tiền thật"*); để nguyên đó là mất luôn tie-break của §5.4, xem [F-03](#f-03) |
| [F-03](#f-03) | 🟡 | `task_guiline §4` khai `⚑n` là *"thứ tự owner tự chọn"*, `prompt-fullstack §5.4` khai thứ tự **không do sở thích** mà do phụ thuộc dữ liệu — hai luật ngược nhau cho cùng một quyết định | NON-CODE | 🔓 MỞ | Không chặn task nào hôm nay; chặn **độ tin của thứ tự `⚑`** sau khi `T-11` gom master task | **Nạp:** [task_guiline §4](../task_guiline.md) dòng 79 · [prompt-fullstack §5.4](../prompt-fullstack.md) dòng 360 · **Đã chốt:** hôm nay thứ tự `⚑` **chưa** vi phạm phụ thuộc nào — lệnh dò ở mục chi tiết ra **rỗng**, nên đây là xung đột **luật**, không phải dữ liệu sai; và vế tie-break của §5.4 *(ưu tiên task dính tới tiền)* **không chạy được** vì cột nó dựa vào không tồn tại, xem [F-02](#f-02) · **Đóng đúng:** một trong hai file khai bên kia thắng, **và** lệnh dò ở mục chi tiết được đưa vào `make check` để thứ tự `⚑` sai là đỏ chứ không phải tự giác · **Bẫy:** hôm nay bảng toàn giấy tờ nên không dòng `⚑` nào *dính tới tiền* — đóng finding này lúc bảng còn dễ thì rẻ; chờ tới sau `T-11` thì phải xếp lại một bảng đã to |

---

## Chi tiết

### F-01

**`prompt-fullstack §5.3` và `task_guiline §1` khai hai khuôn khác nhau cho cùng một sự thật — 🟠** *(session rà §5, phát hiện 2026-08-16)*

**Bằng chứng chạy được**

```sh
$ grep -n 'đúng 7 cột' project_preparation/prompt-fullstack.md
351:**5.3 Mỗi dòng task có đúng 7 cột. Thiếu cột 5 thì nó là ý kiến, không phải task.**

$ grep -n 'Khuôn 8 cột' project_preparation/task_guiline.md
14:## 1. Khuôn 8 cột

$ grep -c 'Hỏng thì mất gì' project_preparation/task_guiline.md
0
```

§5.3 khai 7 cột `ID · Pha · Tầng · Việc · Cần xong trước · Đầu ra · Hỏng thì mất gì · Trạng thái`.
`task_guiline §1` khai 8 cột `# · Lane · Task · Context · Cần xong trước · Chặn bởi · Đầu ra · Prompt mở session`.
Giao nhau đúng 3 cột. Không file nào nhắc tên file kia, [CLAUDE.md §2](../../CLAUDE.md) không có dòng nào phân xử.

**Vì sao đây là lỗi hệ thống, không phải lỗi người làm**

[CLAUDE.md §1](../../CLAUDE.md) route lane NON-CODE tới `task_guiline` + `07` + *"khuôn của sổ đang sửa"*.
`prompt-fullstack §5` **không nằm trong gói nạp của lane dựng bảng task** — nó nằm trong gói lane BA.
Nên session dựng bảng task làm đúng luật định tuyến mà vẫn không thể biết §5 tồn tại. Sửa người vô ích:
bất kỳ session NON-CODE nào sau này cũng sẽ lệch y hệt cho tới khi bảng định tuyến hoặc bảng phân xử đổi.

**Hậu quả thật**

Hai bảng task đang chạy (39 dòng, `task_project_preparation.md` + `task_fe.md`) dựng theo khuôn thua cuộc,
và không lệnh nào đỏ. Giá phải trả rơi vào [F-02](#f-02) — nó là hệ quả cụ thể đầu tiên, đúng lúc `T-11` chạy.

**Cách sửa đề xuất**

Thêm một dòng vào bảng §2 của `CLAUDE.md`: *hình dạng dòng task → nhà là `task_guiline.md` → lệch thì
`task_guiline` thắng*, kèm sửa `prompt-fullstack §5.3` thành link tới `task_guiline` khi `T-18` đã khai owner
cho file đó. Chọn `task_guiline` làm nhà thắng vì nó là khuôn **hai bảng thật đang dùng** và nó có
cột `Context` — thứ §5.3 không có mà mọi session mở lạnh đều cần.

**Đóng đúng + Bẫy**

Đóng khi `CLAUDE.md §2` có dòng phân xử và `wc -l < CLAUDE.md` vẫn ≤ `60` (trần đang **vừa khít**, nên phải
**thay hoặc gộp**, không thêm dòng). Bẫy: `prompt-fullstack.md` chưa có `Lane sở hữu` — chạm nó trước `T-18`
là sửa file chưa ai nhận; làm vế `CLAUDE.md` trước, vế `prompt-fullstack` để `T-18` xong đã.

### F-02

**Khuôn xuất `plan/*.md` là 7 cột, bảng đích là 6 cột, và cổng chốt cứng ở 6 — 🟠** *(session rà §5, phát hiện 2026-08-16)*

**Bằng chứng chạy được**

```sh
$ awk -F'|' '/^\| (~~)?\*\*T-/ {print NF}' \
    project_preparation/project_preparation_task_finding/task_project_preparation.md \
    design/fe/task_fe.md | sort -u
8

$ grep -c 'Hỏng thì mất gì' project_preparation/project_preparation_task_finding/task_project_preparation.md
0

$ grep -n 'ID | Pha · Tầng' project_preparation/prompt-fullstack.md
354:| ID | Pha · Tầng | Việc (động từ + tân ngữ cụ thể) | Cần xong trước | ... | Hỏng thì mất gì | Trạng thái |
461:| ID | Pha · Tầng | Việc | Cần xong trước | Đầu ra kiểm chứng được | Hỏng thì mất gì | ⬜ |
```

`NF=8` ⇒ 6 cột trên cả 39 dòng của hai bảng. `command/Makefile` target `check-task-cols` chốt `NF != 8` là đỏ.

**Vì sao đây là lỗi hệ thống, không phải lỗi người làm**

Ba nhà nói ba kiểu về cùng một bảng: `§8` bảo *xuất 7 cột*, `task_guiline §7` bảo *mở cột theo bảng kích hoạt*
(bảng đó không có cột này), `check-task-cols` bảo *đúng 6 cột hoặc đỏ*. Session chạy `T-11` sẽ cầm 6 mảnh
`MASTER TASK` 7 cột và một bảng đích 6 cột, và ô trống duy nhất trông hợp lý là ô `Bẫy` — đúng khuôn hỏng mà
[task_guiline §1](../task_guiline.md) đã mô tả ở cột *Finding* của dự án trước: **bẫy nằm ở khuôn, không ở người viết**.

**Hậu quả thật**

`Hỏng thì mất gì` là cột `§5.4` dùng để xếp thứ tự khi hai task không phụ thuộc nhau. Vứt nó đi thì
thứ tự ưu tiên của **toàn bộ master task 6 pha** mất căn cứ đo được, và mất im lặng: `make check` vẫn xanh.
Đây là lane đã tự khai *không có compiler* — mất một cột không lệnh nào bắt được là mất thật.

**Cách sửa đề xuất**

Chốt một trong hai, không có phương án ba:
1. Bảng task mở cột thứ 7 `Hỏng thì mất gì`, `check-task-cols` đổi `NF != 8` thành `NF != 9` **trong cùng commit**
   (target thuộc lane DevOps ⇒ mở task cho lane đó, đừng tiện tay sửa).
2. `§8` bỏ cột đó khỏi khuôn xuất, và `§5.4` thay vế tie-break bằng một tiêu chí đọc được từ 6 cột hiện có.

Phương án 1 đắt hơn nhưng giữ được vế *"cột này quyết định thứ tự ưu tiên"*; phương án 2 rẻ và làm §5.4 rỗng ruột.

**Đóng đúng + Bẫy**

Đóng khi `make check` **đỏ trên bản cũ, xanh trên bản mới**, dán cả hai output, và `grep -c 'Hỏng thì mất gì'`
trên `prompt-fullstack.md` cùng bảng task cho kết quả **nhất quán với phương án đã chốt**.
Bẫy: sửa `check-task-cols` là chạm `command/Makefile` — **lane DevOps**, và thư mục đó đang `??` chưa commit.
Chạm lúc này là sửa chồng lên việc dở của session khác; mở task cho DevOps và chờ.

### F-03

**`⚑n` được hai file khai bằng hai nguyên tắc ngược nhau — 🟡** *(session rà §5, phát hiện 2026-08-16)*

**Bằng chứng chạy được**

```sh
$ grep -n 'Thứ tự owner tự chọn' project_preparation/task_guiline.md
79:| **⚑n** | Thứ tự owner tự chọn cho việc ngoài đường găng | ...

$ grep -n 'không do sở thích' project_preparation/prompt-fullstack.md
360:**5.4 Thứ tự do phụ thuộc dữ liệu quyết định, không do sở thích.**
```

Lệnh dò thứ tự `⚑` có vi phạm phụ thuộc hay không — **hôm nay ra rỗng**:

```sh
awk -F'|' '/^\| (~~)?\*\*T-/ {
  id=$2; dep=$6
  if (match(id,/T-[0-9]+/)) k=substr(id,RSTART,RLENGTH); else next
  if (match(id,/⚑[0-9]+/)) o[k]=substr(id,RSTART+3,RLENGTH); else o[k]=-1
  d[k]=dep
} END {
  for (k in d) { s=d[k]
    while (match(s,/T-[0-9]+/)) { p=substr(s,RSTART,RLENGTH); s=substr(s,RSTART+RLENGTH)
      if (o[k]>=0 && o[p]>=0 && o[p]+0 >= o[k]+0) printf "  VI PHAM: %s (%s) can %s (%s)\n", k,o[k],p,o[p] } }
}' project_preparation/project_preparation_task_finding/task_project_preparation.md
```

`T-02` mang `⚑05` và đứng trước cả ba dòng phụ thuộc nó (`T-03` ⚑06 · `T-14` ⚑07 · `T-15` ⚑09).

**Vì sao đây là lỗi hệ thống, không phải lỗi người làm**

Owner xếp `⚑` theo `task_guiline §4` — đúng gói nạp của lane mình. Kết quả tình cờ hợp §5.4 vì bảng còn nhỏ
và hầu hết dòng không phụ thuộc nhau. Không có lệnh nào gác, nên lần xếp `⚑` tiếp theo trúng hay trượt là **may rủi**.

**Hậu quả thật**

Chưa mất gì hôm nay — đó chính là lý do nó là 🟡 chứ không phải 🟠, và cũng là lý do nó dễ bị bỏ qua.
Cái giá đến sau `T-11`: một bảng master task 6 pha xếp `⚑` theo sở thích, giữa lúc `§5.4` bảo phải xếp theo
tiền, mà cột tiền thì không tồn tại ([F-02](#f-02)).

**Cách sửa đề xuất**

Giữ `⚑n` (nó có thật và hữu dụng), nhưng khai lại nghĩa ở `task_guiline §4`: *`⚑n` là thứ tự owner chọn
**trong phạm vi mà phụ thuộc dữ liệu cho phép***, và đưa lệnh awk ở trên vào `make check` thành phép 5.
Sửa được ngay khi `F-02` đã chốt xong phương án, vì tie-break phụ thuộc vào cột kia.

**Đóng đúng + Bẫy**

Đóng khi `task_guiline §4` khai đúng một nguyên tắc, **và** lệnh awk trên nằm trong `make check` với
output **đỏ trên một bảng cố tình xếp sai, xanh trên bảng thật** — dán cả hai. Bẫy: đừng đóng chỉ bằng cách
sửa chữ ở `task_guiline`; luật không có lệnh cưỡng chế là luật sẽ tái phát, đúng thứ
[finding_guiline §5](../finding_guiline.md) đo được ở dự án trước (**19/21** finding đóng không để lại bài học,
trong khi 100% có ngày đóng — *vế nào có lệnh kiểm thì người ta làm*).
