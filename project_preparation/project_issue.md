# Mười ba kiểu hỏng của một dự án chạy bằng agent — và luật rút ra

> Cập nhật **2026-08-15**. Nhà của **danh mục kiểu hỏng + luật rút ra từ nó**, viết cho người **chưa biết gì** về
> dự án: không cần đọc code, không cần biết dự án làm sản phẩm gì, không cần mở file nào khác. Đây là **gốc của bộ
> luật** trong file luật dự án (`CLAUDE.md`); lệch ⇒ **file luật thắng** — file này chỉ trả lời *vì sao*.
>
> **Không giữ ở đây** (đặt link, không chép): khuôn bảng task → [task_guiline](task_guiline.md) · khuôn sổ
> finding → [finding_guiline](finding_guiline.md) · khuôn prompt → [prompt_guiline](prompt_guiline.md) ·
> bộ khung thư mục + thứ tự dựng → [07](07-cau-truc-du-an.md).

**Luận điểm.** Mười ba mục dưới đây không phải lý thuyết: mỗi mục là **một lần đã trả tiền**, ở các đời dự án trước.
Đọc để **không phải trả lại**. Kết luận xuyên suốt cả mười ba mục, nói trước ở đây vì nó là thứ duy nhất bắt buộc nhớ:

> **Luật không quy được về một lệnh đỏ thì nó sẽ tái phát.** Không phải vì người làm cẩu thả — mà vì vế nào có
> lệnh kiểm thì người ta làm, vế nào chỉ có chữ thì không. Điều này đo được, không phải cảm tính (mục 5).

---

## 0. Đọc một mục thế nào

Mỗi mục có bốn vế: **Triệu chứng** · **Nguyên nhân thật** (gần như luôn là khuôn ép người ta điền sai, không phải
người sai) · **Luật rút ra** · **Lệnh cưỡng chế** — chưa có lệnh thì ghi thẳng *"chưa có"*, vì đó là chỗ nó sẽ tái phát.
Xếp một sự cố mới vào đúng mục bằng ba câu: *ai trả giá tiếp · nó tự lộ ra hay phải tình cờ mở đúng dòng · lệnh nào lẽ ra đã bắt được.*

## 1. Read path — mỗi dòng viết thêm, mọi session sau đều trả tiền

- **Triệu chứng.** Ngân sách "byte phải đọc trước khi làm việc" luôn đỏ; kéo tay xuống dưới trần thì đúng **một
  session** sau đã vượt lại.
- **Nguyên nhân thật.** Ngân sách đếm cả sổ rủi ro lẫn output lệnh trạng thái ⇒ **ghi thêm một rủi ro** hay
  **ship thêm một tính năng** đều làm nó đỏ. Ngân sách chống lại chính thứ nó bảo vệ, và siết dần khi dự án lớn lên.
- **Luật rút ra.** File luật có **trần dòng cứng**; thêm luật ⇒ **thay hoặc gộp**, không thêm mục. Session nạp
  **đúng gói của lane mình**, không nạp toàn cảnh. Sổ và output lệnh **không** nằm trên đường đọc bắt buộc.
- **Lệnh cưỡng chế.** `wc -l` / `awk` so với trần đã khai, chạy trong cổng chất lượng — không phải một lượt đếm tay.
  **Cái giá:** nạp theo lane ⇒ không ai còn thấy toàn cảnh miễn phí, muốn toàn cảnh phải mở một session riêng.

## 2. Đầu ra session — không phân biệt được "chưa làm" với "làm rồi chưa ghi"

- **Triệu chứng.** Gần nửa số dòng việc không có biên nhận; commit mang nhãn một việc mà điều kiện của việc đó
  chưa đạt; cổng kiểm tra bị tắt bằng `--no-verify` cho quen tay.
- **Nguyên nhân thật.** Message commit đang là **lời khai**, không phải bằng chứng; và khi cổng chung đỏ **vì một lý do sai**, mọi vi phạm nhỏ khác đi qua cùng một lần tắt cổng đó.
- **Luật rút ra.** Đánh dấu xong cần đủ **ba** thứ: biên nhận của lane chạy thật kèm output · commit chứa thay đổi ·
  sổ đổi trạng thái kèm ngày. Thiếu một ⇒ vẫn là **đang làm**. *"Đã viết code" ≠ "đã chạy"*.
- **Lệnh cưỡng chế.** Mỗi lane đúng **một** lệnh biên nhận, khai ngay dòng đầu session. Cấm `--no-verify`.

## 3. Đầu vào session — nguồn thật không nằm trên đường đọc

- **Triệu chứng.** Một session viết migration **bằng suy diễn** trong khi bản DDL đã chạy thật nằm ở kho cũ, không
  file nào trỏ tới. Một điều kiện "xong" được đóng bằng `grep` ba thư mục **tài liệu**, không lần nào chạm vào code.
- **Nguyên nhân thật.** Gói nạp khai *được đọc file nào*, **không ai kiểm nguồn thật đã có trong gói chưa**. Thiếu
  nguồn không gây lỗi — nó gây **bịa**, và bịa thì trông hệt như làm đúng.
- **Luật rút ra.** Mỗi dòng việc mang sẵn ô **Context** ba mẩu: *nạp gì · đã chốt gì · bẫy ở đâu*. Luật *"code thắng
  tài liệu"* chỉ có nghĩa nếu **lệnh đóng chạm vào code**, không phải chạm vào tài liệu mô tả code.
- **Lệnh cưỡng chế.** Lệnh đóng phải trỏ vào đường dẫn code/DB thật; `grep` trong thư mục tài liệu **không** tính.

## 4. Session quá dài

- **Triệu chứng.** Tám session rất dài trong một ngày ⇒ chín commit sổ sách, **không dòng code nào**; và phải cuộn ngược lên mới nhớ mình đã quyết gì.
- **Nguyên nhân thật.** Cảnh báo độ dài chỉ **báo**, không **tách**; và một dòng việc từng được viết to hơn một
  session (có dòng gánh 18 migration, phải chẻ làm bốn **sau khi** đã tồn tại nhiều ngày).
- **Luật rút ra.** Một session = **một lane, một task**. Dấu hiệu phải dừng viết sẵn thành danh sách: chạm file
  ngoài lane · sửa quá 3 file ngoài kế hoạch · hơn 2 lần thử–sai trên cùng một lỗi · context bị tóm tắt giữa chừng.
  Gặp dấu hiệu ⇒ **dừng ở điểm lùi gần nhất**, mở việc mới cho phần còn lại. Cấm gánh tiếp cho xong.
- **Lệnh cưỡng chế.** Chưa có (độ dài context là thứ agent tự khai) ⇒ bù bằng **kích cỡ task** ở mục 11.

## 5. Finding / cảnh báo phát hiện giữa chừng

- **Triệu chứng.** Đóng vì hết chỗ chứ không phải vì hết sai; đóng hình thức (việc được trỏ tới **không có vế nào**
  đóng dòng đó); một dòng khai **5 vế**, lúc đóng còn **3**.
- **Nguyên nhân thật.** Trần sổ biến thành **cái rọ bịt miệng**: hết chỗ thì không ghi thêm rủi ro nào một cách hợp
  lệ được nữa, nên van xả bị dùng như cái **bơm** — và chỉ chạy khi trần đỏ.
- **Luật rút ra.** Đóng bằng **bằng chứng chạy được**; khai 5 vế thì đóng 5 vế, hoặc đóng 3 và ghi rõ 2 vế còn nợ;
  mỗi lần đóng để lại một dòng **Bài học giữ lại** nói *luật nào đổi*, không kể lại sự cố; cùng một bài học lặp
  **lần thứ ba** ⇒ nó lên thành luật, bằng cách **thay hoặc gộp** luật cũ.
- **Đo được, và đây là bài học lớn nhất của cả file này.** Ở đời dự án trước, mọi dòng đã đóng đều có ngày đóng,
  nhưng **19/21** không có dòng *Bài học giữ lại* ([finding_guiline §5](finding_guiline.md)): ngày đóng có lệnh dò,
  bài học chỉ có luật. Khác biệt giữa hai con số ấy chính là kết luận ở đầu file.

## 6. One fact one home — một sự thật, một nhà

- **Triệu chứng.** Phiên bản stack ghi ở tài liệu khác ở code; đơn hàng vừa ở server vừa cache ở máy khách và hai
  bên lệch nhau; **trạng thái của một hạng mục sống ở 5 chỗ**, chỉ một chỗ là thật.
- **Nguyên nhân thật.** Chép **rẻ lúc viết, đắt lúc đổi**. Nhà thứ hai không bao giờ báo là nó đã cũ.
- **Luật rút ra.** Một bảng duy nhất *sự thật → nhà duy nhất → ai thắng khi lệch*, và **code thắng tài liệu**.
  Cần lại một sự thật ⇒ **đặt link, không chép**. **Suy ra được bằng lệnh thì cấm chép thành bảng/cột.**
- **Bẫy đã trả tiền.** Chính mục *"ghi sổ cuối session"* của bộ luật từng bắt chép một sự thật vào 4–7 nơi — bộ luật
  tự mâu thuẫn với luật số 1 của nó. Luật càng chi tiết càng dễ có hai điều khoản va nhau: đó là chi phí có thật của
  việc viết luật, không phải dấu hiệu người viết kém.

## 7. File luật riêng cho từng lane (DB · BE · FE · DevOps · giấy tờ)

- **Triệu chứng.** File luật của một lane **chép ba luật** từ nơi khác về ⇒ chắc chắn sẽ trôi mà không lệnh nào đỏ;
  đổi tên một file luật ⇒ nó rơi khỏi cơ chế tự nạp của công cụ; **thư mục gốc không lane nào sở hữu**.
- **Nguyên nhân thật.** Checker đếm **dòng**, không đọc **nghĩa**: một file 24 dòng chép nguyên ba luật vẫn xanh.
- **Luật rút ra.** Mỗi file có **đúng một lane sở hữu**; file lane chỉ giữ thứ **chỉ lane đó cần** — biên nhận và
  bẫy của lane. Luật chung nằm ở file gốc và **không chép về**. Sửa file của lane khác — kể cả một dòng — là việc
  của lane đó: mở finding + task, đừng tiện tay.
- **Kiểm trước khi tin.** Cơ chế tự nạp của công cụ phải **đo thật** trên phiên bản đang dùng — ở đây một lần từ chối
  đổi tên file vì *"sợ mất autoload"* hoá ra là sợ thứ không tồn tại.

## 8. Vòng lặp làm việc

- **Triệu chứng.** Bước nào không có lệnh gác thì bước đó thành tự giác: điểm lùi không ai kiểm có tồn tại; bước tự
  rà thành no-op vì thước của lane phần lớn *chưa đo được*; luật *đỏ-trước-xanh-sau* không lệnh nào đòi đủ hai output.
- **Luật rút ra.** Viết vòng lặp thành **các bước có điều kiện đi tiếp**, không phải lời khuyên:
  `ĐỊNH TUYẾN → ĐỊNH VỊ → PLAN → ĐIỂM LÙI → LÀM → TỰ RÀ → KIỂM CHỨNG → GHI SỔ`, mỗi bước một câu *"phải đúng cái gì
  mới được đi tiếp"*. Bước cuối là **ghi sổ**: chưa ghi thì việc chưa xong.
- **Lệnh cưỡng chế.** Dòng khai lane ở đầu session (owner chặn được ngay nếu định tuyến sai) + `git diff --stat`
  trước khi commit.

## 9. Trạng thái bị chép ra nhiều chỗ

- **Triệu chứng.** Một file khai *"chỉ được chứa 2 thứ"* nhưng đang chứa 13 mã việc và 8 dấu ✅; trạng thái một hạng
  mục nằm ở 5 chỗ, 4 chỗ là bản chép và **chúng đã lệch**.
- **Nguyên nhân thật.** Trạng thái là thứ **derive được**; giữ nó thành chữ viết tay là **bảo đảm** sẽ trôi. Đây
  đúng là ca đã giết bản dự án trước: một ô trạng thái viết tay sai **bốn lần** trước khi bị xoá.
- **Luật rút ra.** Trạng thái **in ra bằng lệnh**, không chép: một target `make status` đọc `git` / `ls` / DB.
  Dấu ✅ chỉ sống ở dòng việc; trạng thái rủi ro chỉ sống ở cột *Trạng thái*; ảnh chụp hệ thống thì **đừng làm file**.
- **Lệnh cưỡng chế.** `make status`. Bỏ hẳn thư mục "hiện trạng" nếu đã có nó ([07 §3](07-cau-truc-du-an.md)).

## 10. Tài liệu cũ mà không có tín hiệu nào

- **Triệu chứng.** Số và phiên bản trong tài liệu lệch code **sau vài giờ**; file khai *"chưa tạo"* khi đã tạo,
  *"chưa có remote"* khi đã có; tài liệu ghi *"đã sửa"* mà code chưa — loại nguy hiểm nhất vì nó **giả vờ đã đóng**.
- **Nguyên nhân thật.** Doc lệch **im lặng**. Luật chống nó viết đúng từ ngày đầu, nhưng chỉ chặn được ở khâu
  *người viết nhớ ra* — không lệnh nào bắt nội dung cũ.
- **Luật rút ra.** Mọi file tài liệu có dòng `Cập nhật <ngày>`; sửa nội dung ⇒ **đổi ngày trong cùng commit**.
  Sửa code làm tài liệu sai ⇒ sửa tài liệu **trong cùng commit**, hoặc mở finding ngay — không có lựa chọn thứ ba.
  **Đếm được bằng lệnh thì ghi lệnh, đừng ghi số.**
- **Lệnh cưỡng chế** — thứ đáng làm nhất trong cả file này, một script ~40 dòng: link chết · ngày header so với
  `git log -1 --format=%ad -- <file>` · số trần trụi không kèm lệnh sinh ra nó ([07 §4](07-cau-truc-du-an.md)).

## 11. Kích cỡ việc không đều

- **Triệu chứng.** Cùng đơn vị *"một việc"* mà biên độ thật đi từ **sửa 2 dòng tài liệu** tới **18 migration** tới
  **9 thứ gộp trong một commit**. Chênh nhau hàng chục lần nhưng đọc bảng thì trông như nhau.
- **Nguyên nhân thật.** Luật kích cỡ **không có checker**; ràng buộc duy nhất đang hoạt động là **độ rộng ô Markdown**.
- **Luật rút ra.** Một việc = **1 lane · ≤ 3 file · 1 đầu ra kiểm chứng được · vừa một session**. Vượt bất kỳ vế nào
  ⇒ **chẻ trước khi làm**, đánh mã mới. Việc chạm 2 lane luôn tách đôi, vì **biên nhận của hai lane là hai lệnh khác nhau**.
  Việc giấy tờ cũng phải có đầu ra kiểm chứng được — *viết vào file nào, mục nào*; không có thì nó là **ý kiến**.
- **Lệnh cưỡng chế.** Đếm ô bắt buộc của mỗi dòng bảng bằng `awk -F'|'`; mã việc **không bao giờ tái sử dụng**.

## 12. File chỉ để điều hướng ⇒ nhảy nhiều chặng

- **Triệu chứng.** Một việc phải mở tối thiểu **8 file điều hướng** trước dòng code đầu tiên. Mỗi file rẻ; cộng lại
  thì **không ai sở hữu tổng số chặng**.
- **Nguyên nhân thật.** Ngân sách đo **tổng byte**, không đo **số lần nhảy** ⇒ chi phí này vô hình với mọi checker.
- **Luật rút ra.** **Cấm file chỉ để điều hướng.** File mới phải giữ ít nhất một sự thật chưa có ở đâu khác; nếu nó
  chỉ liệt kê link thì nội dung của nó thuộc về file bản đồ. **Bản đồ chỉ có một.** Và thay "đường đọc nhiều chặng"
  bằng **định tuyến lane**: đọc prompt xong chọn lane, nạp đúng một gói 2–4 file, khai ra ở dòng đầu.
- **Đây là thay đổi lớn nhất bản này rút ra từ bản trước** — bỏ hẳn read path 4 chặng, thay bằng bảng định tuyến.

## 13. Sửa nhầm ngoài ý muốn, không có điểm lùi sạch

- **Triệu chứng.** Ba lần một commit **nuốt việc chưa xong của người khác**, cả ba đều do `git add -A`; nhiều
  session cùng ghi vào một cây làm việc; có lúc cây làm việc **không có điểm lùi nào** cho phiên đang chạy.
- **Nguyên nhân thật.** Cổng kiểm là **hậu kiểm** — nó bắt sau khi commit đã vào lịch sử; và khi nó đỏ sai thì cách
  duy nhất để làm tiếp là tắt luôn cả phần nó bắt đúng.
- **Luật rút ra.** Điểm lùi = **commit ngay trước khi sửa**; không có nó thì không được sửa file nào. `git add`
  **từng đường dẫn cụ thể**, cấm `-A`. Thấy file lạ ⇒ **đừng stage, cũng đừng `git restore`** — đó là việc chưa commit
  của lane khác. Lùi thật (`reset --hard`, xoá nhánh, `push --force`, xoá volume, `DROP`) **thuộc owner**: agent phát
  hiện đã sửa nhầm thì **dừng và báo**, không tự lùi.
- **Bẫy còn hở.** Phép đo va chạm chỉ thấy thứ **đã ghi vào cây**; hai session cùng lane đụng nhau lúc cả hai còn
  chưa commit thì **lọt cả hai phép đo**.

---

## 14. Kiến trúc đúng từ đầu — bốn quyết định gốc

1. **Ba tầng file.** Tầng 1: **luật + con trỏ + việc đang làm**, trần dòng cứng, **không giữ sự thật nào**. Tầng 2:
   nhà của từng sự thật, chia theo lane. Tầng 3: thứ **derive được** — và tầng 3 **không phải file**, nó là một lệnh.
   Cây thư mục cụ thể + thứ tự dựng: [07](07-cau-truc-du-an.md).
2. **One fact one home** (mục 6) — luật nền, mọi luật khác chỉ là cách thi hành nó.
3. **Bản đồ không phải lãnh thổ.** File luật lệch nhà thật ⇒ **nhà thật thắng**, dòng ở bản đồ là **bug phải sửa
   ngay**, không phải chuyện để sau. Bản đồ mà sai thì tệ hơn không có bản đồ.
4. **Mỗi luật phải có một lệnh cưỡng chế, nếu không nó chưa phải luật.** Vế thứ tư này owner để trống ở bản đầu;
   mười ba mục trên điền nó. Hệ quả thi hành: **mỗi lane đúng một lệnh biên nhận**, và lane giấy tờ — lane duy nhất
   không có compiler — phải **tự dựng compiler cho mình** (`check-docs`), nếu không nó sẽ là lane nhiều lỗi nhất.

## 15. Nếu chỉ nhớ được bốn thứ

| # | Việc | Không làm thì trả giá ở |
|---|------|------------------------|
| 1 | **Gác cửa sổ rủi ro ngay từ dòng đầu tiên**: *"chưa có X"* là **việc**, không phải **lỗi** | Sổ gánh hai vai ⇒ mọi thứ đều kêu ⇒ không ai còn nhìn nó (mục 5) |
| 2 | **Mọi trạng thái derive bằng lệnh**, không chép thành chữ | Bản chép lệch âm thầm — ca đã giết dự án trước (mục 9) |
| 3 | **Điểm lùi trước khi sửa + `git add` từng đường dẫn** | Một commit nuốt việc của người khác, không có đường lùi (mục 13) |
| 4 | **Viết `check-docs` ngay lần tài liệu lệch code thứ hai** | Luật đúng mà vẫn tái phát, mãi mãi (mục 10) |

**Cái giá, nói thẳng.** Bộ luật này chỉ có lãi khi dự án **nhiều lane · nhiều session · sống lâu**. Nó mua được: mọi
thay đổi có điểm lùi, mọi việc xong có biên nhận, không lane nào âm thầm sửa file lane khác, một session chưa từng đọc
repo vẫn mở việc được. Nó bán đi **thời gian** — đời trước phần lớn commit là commit giấy tờ trong khi sản phẩm mới
đi được một phần; đo tỉ lệ đó bằng [lệnh đếm ở 07 §0](07-cau-truc-du-an.md). Dự án một người, một tuần, một lane thì **ba
file** là đủ (`README.md` · `task.md` ba cột · `Makefile`); mười ba mục trên để biết **cái gì sẽ đau trước** và thêm đúng lớp đó **đúng lúc nó bắt đầu đau**, không phải để dựng hết từ ngày đầu.

## 16. Trần của chính file này

**≤ 200 dòng** · mỗi mục ≤ 14 dòng · mỗi dòng ≤ 400 byte. Thêm kiểu hỏng mới ⇒ **gộp vào một trong 13 mục**, không mở
mục thứ 14 — file này phình ra thì chính nó thành mục 1 và mục 12. **Số liệu không sống ở đây**: con số thuộc
[07 §0](07-cau-truc-du-an.md), nơi có sẵn lệnh sinh lại chúng.
