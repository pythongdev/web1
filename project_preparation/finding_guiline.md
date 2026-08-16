# Sổ finding — form nào, cột gì, vì sao có cột đó

> Cập nhật **2026-08-16** · Lane sở hữu: **NON-CODE**. Nhà của **cách dựng sổ finding cho một dự án mới**.
> Sổ thật của dự án này ở [finding.md](../finding.md); luật ở [CLAUDE.md §7](../CLAUDE.md);
> *vì sao sổ dự án này phình tới cỡ hiện tại* ở [06-lich-su-du-an.md §3](06-lich-su-du-an.md) — **không chép lại ở đây**.
> File này giữ đúng một thứ chưa có nhà: **khuôn sổ + luật vào/ra + phép đo sức khoẻ sổ**, viết để mang sang dự án sau.
> Anh em với [task_guiline.md](task_guiline.md) — hai sổ đo hai đại lượng khác nhau, đọc cả hai mới đủ.

**Luận điểm.** Sổ finding là **hệ thống báo động**, không phải backlog. Giá trị của nó bằng **tỉ lệ tín hiệu**,
không bằng số dòng. Mỗi dòng sai loại nhét vào đây làm cả sổ điếc đi thêm một chút — và điều đó xảy ra
âm thầm: không lệnh nào đỏ, chỉ có một ngày nào đó không ai còn nhìn cột 🔴 nữa.

---

## 1. Cửa vào — thứ duy nhất quyết định sổ này còn dùng được

**Phép thử, hỏi trước khi viết dòng nào:** chạy hết kế hoạch đang có **y như nó viết** — dòng này còn không?
**Còn** ⇒ finding. **Mất** ⇒ task. Finding đo **đúng/sai**; task đo **xong/chưa**.

| Câu mở đầu | Nhà đúng | Vì sao |
|---|---|---|
| *"Chưa có X"* / *"X chưa từng chạy"* | **task.md** | Việc chưa tới lượt xây, không phải lỗi — nó không thể đóng cho tới khi sản phẩm xong |
| *"A và B nói ngược nhau"* | **finding** | Đang sai ngay bây giờ; kế hoạch không nói tới nên không tự mất đi |
| *"Code khác thiết kế"* | **finding** | Code thắng tài liệu ⇒ tài liệu là dòng phải sửa |
| *"Tài liệu ghi đã sửa mà code chưa"* | **finding ⚠️ MỞ LẠI** | Loại nguy hiểm nhất: nó **giả vờ đã đóng** |
| *"Nên làm X cho gọn/đẹp"* | **task**, hoặc không đâu cả | Ý kiến không có mệnh đề sai được thì không đóng được |

Cái giá của việc gác cửa lỏng, đo được ở dự án này: **24/68 dòng** (đo 2026-08-14) thuộc dạng *"chưa có X"* — chúng
không thể đóng, nằm vĩnh viễn ở cột MỞ, kéo tỉ lệ đóng xuống và khiến 47 dòng MỞ trông như 47 chỗ đang hỏng
(lệnh đếm + phân tích ở [06 §3.1](06-lich-su-du-an.md)). **Sổ mất khả năng báo động vì mọi thứ đều kêu.**

> **Luật một cửa:** một dòng chỉ được **gỡ** khỏi sổ khi đã có mã task nhận nó. Gỡ trước là mất việc, không phải dọn sổ.

**Luật bàn giao chéo lane.** Đang làm lane A mà phát hiện thứ thuộc lane B — đây là tình huống **phổ biến nhất**,
không phải ngoại lệ. Ba bước, không bước nào bỏ được:

1. **Ghi vào sổ finding của chính lane A**, cột *Lane* điền **lane đóng được** (B), không phải lane phát hiện (A).
   **Cấm ghi vào sổ của lane B** — sổ đó do lane B sở hữu, và [project_issue §7](project_issue.md) cấm chạm file lane khác kể cả một dòng.
2. **Mở một dòng ở hàng đợi liên lane** (`T-xx`, cột *Lane* = B). Đây là bước biến *báo* thành *giao*.
   Bỏ bước này thì dòng nằm chết trong sổ của A: lane B không đọc sổ của A, và không lệnh nào bắt được.
3. **Không tự đóng**, kể cả khi biết chính xác cách sửa — biên nhận của lane B là **lệnh của lane B**,
   lane A chạy không ra. Lane A chỉ được **báo và chờ**.

Vì sao luật này lên đây thay vì để tự giác: nó đã lặp **ba lần trở lên** — 8 finding con trỏ gãy cùng một khuôn
lặp 5 lần ở đời trước ([task_guiline §6](task_guiline.md)); một sổ lane có **toàn bộ** dòng chờ lane khác đóng;
và một session giấy tờ tìm ra dòng đóng được của lane khác mà không được chạm. Ngưỡng *"lặp lần thứ ba ⇒ lên thành luật"* (§5.5) đã đạt.

**Hai cách hỏng đối xứng, cùng bị phép đo 5 ở §6 bắt:** *tự sửa* (nhanh, phá quyền sở hữu, không ai review được)
và *chỉ báo* (đúng luật ở bước 1, quên bước 2, dòng chết im lặng). Cách thứ hai nguy hiểm hơn vì nó **trông như đã làm đúng**.

## 2. Khuôn 7 cột của bảng tổng hợp

| Cột | Câu hỏi nó trả lời | Bỏ đi thì hỏng thế nào |
|---|---|---|
| **ID** `F-xx` + neo `#f-xx` | Trỏ tới bằng mã thay vì mô tả lại | Mỗi file mô tả lại một kiểu ⇒ 3 phiên bản của cùng một lỗi |
| **Mức** 🔴🟠🟡🟢 | Đóng trước cái nào | Không có thứ tự ⇒ đóng cái dễ, để lại cái mất tiền |
| **Finding** | **Mệnh đề sai được** — một câu, sai ở đâu | Chủ đề (*"chuyện giá"*) không bao giờ đóng được vì không biết lúc nào hết sai |
| **Lane** | Ai đóng được nó, biên nhận là lệnh nào | Dòng nằm chờ vì không ai nhận; lane khác đọc rồi bỏ qua |
| **Trạng thái** 🔓/⚠️/✅ | Còn sai không | — nhưng **chỉ ghi ở đây**, xem §4 |
| **Chặn việc gì** | Ai đang phải chờ nó | Không biết dòng này có gấp thật không hay chỉ khó chịu |
| **Context** 4 mẩu | Nạp gì · đã chốt gì · **đóng đúng là thế nào** · bẫy | Session mới phải đọc hết mục chi tiết mới đoán ra việc phải làm |

Hai chỗ dễ chép sai khuôn:

**Cột *Finding* phải là mệnh đề sai được.** Đóng finding = chứng minh mệnh đề ấy **hết đúng**, bằng lệnh.
Viết *"vấn đề về `open_key`"* thì không có gì để chứng minh; viết *"`open_key` vẫn chỉ tính `status='open'`
trong migration thật"* thì một câu `SHOW CREATE TABLE` đóng được nó.

**Cột *Context* của sổ finding có 4 mẩu, không phải 3 như bảng task** — vế thêm là **Đóng đúng**.
Lý do có thật, đừng chép mù: bảng task có cột *Đầu ra kiểm chứng được* giữ vế ấy, **sổ finding không có cột đó**.
Chép nguyên 3 mẩu sang đây là mất vế quan trọng nhất; thêm cột *Đầu ra* vào đây là đẻ nhà thứ hai của cùng một sự thật.

## 3. Mục chi tiết `### F-xx` — sáu phần, không phần nào bỏ được

1. **Tiêu đề** = mệnh đề sai được + mức + *(session, ngày phát hiện)*. Ngày phát hiện ≠ ngày đóng.
2. **Bằng chứng chạy được** — lệnh + output thật, **ghim khoảng commit** nếu là số đo (`git log … a~1..b`) để đo lại ra y hệt.
3. **Vì sao đây là lỗi hệ thống, không phải lỗi người làm** — nếu khuôn ép người ta điền sai thì sửa khuôn, sửa người vô ích.
4. **Hậu quả thật** — cái giá đã trả hoặc sẽ trả. Không có hậu quả thì nó là ý kiến.
5. **Cách sửa đề xuất** — *nêu vấn đề mà không nêu lối ra là đẩy việc ngược cho owner*.
6. **Đóng đúng + Bẫy** — điều kiện nghiệm thu, và chỗ người sau chắc chắn sẽ trượt.

Khi đóng, thêm đúng hai thứ: **Đã đóng bằng** (ngày + commit + lệnh) và **`**Bài học giữ lại:**`**.

**Trạng thái không lặp lại ở đây.** Mục chi tiết chỉ chứa **bằng chứng**; chữ ✅/🔓 chỉ sống ở cột *Trạng thái*.

## 4. Trạng thái và mức — ít giá trị, nhiều cách hỏng

**Ba trạng thái, không hơn:** 🔓 MỞ · ⚠️ **MỞ LẠI** · ✅ ĐÓNG. Trạng thái thứ hai đáng giá nhất và hay bị bỏ:
nó dành riêng cho *tài liệu ghi đã sửa nhưng code chưa*. Gộp nó vào MỞ là đánh mất phân biệt giữa
*"chưa ai làm"* và *"có người tưởng đã làm"* — hai tình huống cần hai phản ứng khác nhau.

**Bốn mức xếp theo thiệt hại, không theo độ khó:** 🔴 mất tiền/mất dữ liệu · 🟠 sai nghiệp vụ hoặc đang chặn ·
🟡 gây hiểu nhầm, tốn giờ debug · 🟢 theo dõi. Phân bố hiện tại của dự án này — **40 🟡 / 23 🟠 / 3 🔴 / 2 🟢**
(lệnh ở §6) — là tín hiệu cần đọc: quá nửa sổ là việc dọn dẹp, tức sổ đang gánh thêm vai trò *danh sách nợ kỹ thuật*.

**Một trạng thái một nhà.** Sổ này từng cho phép ghi trạng thái ở ba chỗ (cột bảng · dòng tiêu đề `### F-xx` ·
một dòng lẻ giữa thân bài). Hậu quả không phải là "trông lộn xộn" mà là **mọi lệnh kiểm đều phải đoán chỗ**,
nên câu trả lời phụ thuộc chỗ đoán — lệnh dò lệch đầu tiên báo dương tính giả ngay ([F-39](../finding.md#f-39)).

## 5. Năm luật đóng một finding

1. **Đóng bằng bằng chứng chạy được.** Đóng vì hết giờ, hết chỗ, hoặc *"đọc lại thấy ổn"* ⇒ cấm.
   Sửa lỗi thì phải **đỏ trên code cũ, xanh trên code mới**, dán cả hai output.
2. **Khai 5 vế thì đóng 5 vế**, hoặc đóng 3 và ghi rõ 2 vế còn nợ + mã task nhận chúng. Bóp nhỏ finding cho vừa cái đã làm là cấm.
3. **Không xoá dòng** — đổi trạng thái. Dòng bị xoá là bài học bị xoá.
4. **`**Bài học giữ lại:**` là bắt buộc**: nói **luật nào đổi để nó không tái phát**, không kể lại sự cố.
   Rút không ra luật ⇒ chưa hiểu nguyên nhân ⇒ chưa được đóng.
5. **Cùng một bài học lặp lần thứ 3 ⇒ nó lên thành luật** ở file luật gốc — và lên bằng cách **thay hoặc gộp** luật cũ,
   không thêm mục mới. File luật phình ra thì mọi session sau đều trả tiền.

> **Luật số 4 là luật bị vi phạm nhiều nhất, và đó là bài học lớn nhất của cả file này.**
> Đo ngày 2026-08-14 (lệnh ở §6): **19/21** finding đã đóng **không có** dòng `**Bài học giữ lại:**`,
> trong khi cả 21 dòng đều có ngày đóng. Khác biệt giữa hai con số nói đúng một điều: **vế nào có lệnh kiểm thì
> người ta làm, vế nào chỉ có luật thì không.** Dự án sau: gắn phép đo #3 của §6 vào cổng chất lượng ngay từ ngày đầu,
> đừng chờ luật tự giác.

## 6. Năm phép đo sức khoẻ của sổ

Chạy từ gốc repo. Lane này không có compiler nên đây **là** biên nhận của nó:

```sh
grep -c '^### F-' finding.md                                        # 1. tổng số finding
grep -E '^\| \[F-[0-9]+\]' finding.md | awk -F'|' '{print $3}' | tr -d ' ' | sort | uniq -c | sort -rn   # 2. phân bố mức
for f in $(grep -E '^\| \[F-[0-9]+\]' finding.md | grep 'ĐÓNG' | awk -F'|' '{print $2}' | grep -o 'F-[0-9]*'); do
  awk -v id="### $f" '$0==id{p=1;next} /^### F-/{p=0} p' finding.md | grep -q 'Bài học giữ lại' || printf '%s ' "$f"
done; echo                                                          # 3. đóng mà không để lại bài học — phải rỗng
awk '/^### F-/{getline; if (/✅ ĐÓNG|🔓 MỞ|⚠️ MỞ LẠI/) print NR}' finding.md   # 4. trạng thái ghi ngoài cột — phải rỗng
```

**Phép đo 5 — *báo mà không giao*.** Gác đúng bước 2 của luật bàn giao chéo lane (§1). Quét **mọi** sổ finding,
lấy lane sở hữu từ chính header của sổ, rồi đòi mỗi dòng MỞ có `Lane` ≠ chủ sổ phải có một **dòng task thật** ở
hàng đợi liên lane nhận nó. Phải rỗng:

```sh
T=project_preparation/project_preparation_task_finding/task_project_preparation.md
for s in $(find project_preparation design -name 'finding_*.md' -not -name 'finding_guiline.md' | sort); do
  own=$(sed -n 's/.*Lane sở hữu: \*\*\([A-Z-]*\)\*\*.*/\1/p' "$s" | head -1)
  awk -F'|' -v own="$own" '/^\| \[F-/ && $6 ~ /MỞ/ {
    gsub(/ /,"",$5); if ($5 != own) { match($2,/F-[A-Z0-9-]+/); print substr($2,RSTART,RLENGTH)" "$5 } }' "$s"
done | while read -r id lane; do
  grep -qE "^\| (~~)?\*\*T-.*$id" $T || echo "  BÁO MÀ KHÔNG GIAO: $id (chờ lane $lane)"
done
```

Hai chỗ lệnh này **phải** chặt, đã trả tiền để biết: đòi **dòng task thật** (`^| **T-`) chứ không phải
`grep` cả file — một lần **nhắc tên** finding trong văn xuôi đủ làm nó im, và nhắc tên không phải là giao việc.
Và so `$5` với lane **đọc từ header sổ**, không hardcode tên lane — hardcode thì sổ lane mới sinh ra là gác hụt.

Lệnh 3 lấy ID **từ cột đầu** (`awk -F'|' '{print $2}'`), không `grep` cả dòng — cả dòng còn chứa link tới finding khác
trong ô *Context* nên sẽ đếm nhầm. Còn một phép đo nữa nằm ở sổ kia: *finding nào không task nào đóng*
([task_guiline.md §5](task_guiline.md)) — chạy cả hai mới khép được vòng.

## 7. Sáu bài học mang sang dự án sau

| Triệu chứng | Nguyên nhân thật | Luật rút ra |
|---|---|---|
| Sổ 47 dòng MỞ nhưng phần lớn không đóng được | Sổ lỗi bị dùng làm backlog | Gác cửa bằng phép thử §1 **trước khi** viết dòng, không dọn sau |
| Đóng xong mà lần sau vẫn giẫm lại | Không rút ra luật, chỉ kể lại sự cố | Luật 5.4 + gắn phép đo #3 vào cổng chất lượng |
| Lệnh kiểm cho kết quả không tin được | Một sự thật ghi ở 3 chỗ | Trạng thái chỉ sống ở cột *Trạng thái* (§4) |
| Lane không-code chiếm 22/68 dòng | Lane duy nhất **không có compiler**: chữ sai vẫn "build xanh" | Mỗi thay đổi giấy tờ phải kèm **một lệnh đọc lại** |
| Sổ một lane có **toàn bộ** dòng chờ lane khác đóng, không lane nào tới nhận | Luật cũ dừng ở *"mở finding + task"* mà **không nói mở ở đâu** — mà sổ lane B thì lane A bị cấm chạm ⇒ tắc | Luật bàn giao chéo lane 3 bước (§1) + phép đo 5 (§6) |
| Số/version trong finding lệch code sau vài giờ | Ghi số thay vì ghi lệnh sinh ra số | Đếm được bằng lệnh thì ghi lệnh; số đo thì **ghim khoảng commit** |
| Một đợt dời file đẻ 8 finding, khuôn lặp 5 lần | Luật *mỗi file một lane sở hữu* — đây là **giá phải trả**, không phải sơ suất | Biết mình đang trả giá gì; mở sẵn task dọn cho từng lane trong cùng commit dời |

## 8. Bản mẫu cho dự án mới

```markdown
| ID | Mức | Finding | Lane | Trạng thái | Chặn việc gì | Context |
|---|---|---|---|---|---|---|
| [F-01](#f-01) | 🟠 | <mệnh đề sai được, một câu> | BE | 🔓 MỞ | <ai đang chờ> | **Nạp:** … · **Đã chốt:** … · **Đóng đúng:** <lệnh + kết quả> · **Bẫy:** … |
```

Dự án nhỏ có thể thay bảng này bằng issue tracker — nhưng **giữ nguyên hai vế không thương lượng**:
mỗi dòng là một **mệnh đề sai được**, và mỗi dòng có sẵn câu **"đóng đúng là thế nào"** viết từ lúc mở, không phải lúc đóng.

**Cái giá, nói thẳng.** Định nghĩa "đóng" chặt (bằng chứng chạy được + bài học) làm **tồn kho cao**:
21/68 đã đóng **không** phải dấu hiệu bỏ bê — với luật này, một finding chỉ rời sổ khi có commit chứng minh.
Đổi lại, dòng nào còn trong sổ thì đáng tin. Sổ dễ đóng thì rỗng nhanh và không nói lên điều gì.
