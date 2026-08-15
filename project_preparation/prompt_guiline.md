# Viết prompt — 5 vế, context chỉ là 1

> Cập nhật **2026-08-14**. Khuôn **cách viết prompt** cho các session agent.
> Repo này có đúng hai file: **file này** (khuôn) và [prompt-fullstack.md](prompt-fullstack.md)
> (một prompt thật viết theo khuôn — dùng làm ví dụ đối chiếu ở mục 7).

**Luận điểm.** Context tốt là nền tảng quan trọng nhất nhưng **chưa đủ**. Context là nguyên liệu và
công thức; vẫn phải nói cho đầu bếp biết nấu thế nào, dùng dao nào, bày ra đĩa gì.

---

## 1. Năm vế của một prompt tốt

| Vế | Câu hỏi nó trả lời | Hỏng thì ra gì |
|----|--------------------|----------------|
| **Nhiệm vụ** | Làm **một** việc gì — động từ cụ thể | Model làm 3 việc nửa vời, hoặc làm việc bên cạnh |
| **Ngữ cảnh** | Cần biết gì mới làm đúng | Bịa ra chi tiết thiếu, rất tự tin |
| **Ràng buộc** | Cấm chạm gì, phải giữ gì | "Tiện tay" sửa file ngoài phạm vi |
| **Biên nhận** | Lệnh nào chứng minh nó xong | "Đã viết code" thay cho "đã chạy" |
| **Hình dạng đầu ra** | Dài bao nhiêu, định dạng gì, cho ai đọc | Đúng nội dung, sai kích cỡ, phải làm lại |

Bốn vế còn lại **không** phải context. Nạp thêm tài liệu không sinh ra vế nào trong số đó.

---

## 2. Ba thứ context không bao giờ cứu được

**Kích cỡ sai.** Task quá to thì thêm context chỉ làm nó trôi *có căn cứ* hơn.
Chuẩn một task vừa tay: **1 tầng · ≤ 3 file · 1 biên nhận · vừa một phiên làm việc.**
Vượt ⇒ **chẻ trước khi làm**, không phải nạp thêm.

**Thứ tự ưu tiên khi xung đột.** Context nói A và B đều đúng; prompt phải nói **cái nào thắng**.
Không chốt sẵn thì mỗi session tự phân xử một kiểu. Khi một con số xuất hiện ở hai chỗ, chỉ định
thẳng **chỗ nào là nhà thật** và ghi rằng bản chép sẽ trôi.

**Điểm lùi.** Prompt không nói "commit / backup trước khi sửa" thì không context nào ngăn nổi một
diff 40 file không ai rà.

---

## 3. Bẫy ngược: nhiều context ≠ context tốt

Chỗ hay hiểu sai nhất. Nạp thừa **làm loãng chú ý** — tín hiệu quan trọng bị chôn giữa hàng nghìn
dòng nền. Cách chống: tài liệu dài thì **chỉ đọc đúng mục cần** (`grep -n '^## §' <file>` rồi đọc
một mục), và giữ file luật đủ ngắn để `grep` thay được `Read`.

> **Thước đo thực tế:** mỗi dòng context bạn nạp phải **thay đổi được một quyết định** trong session này.
> Không thay đổi quyết định nào ⇒ nó là nhiễu, dù nó đúng.

---

## 4. Sáu kỹ thuật nâng đầu ra qua mức "đã đủ"

### 4.1 Phân tách nhiệm vụ (Decomposition)

Càng ít việc phải làm cùng lúc, kết quả càng tốt. Đừng đưa context khổng lồ rồi hỏi một câu phức tạp.

- **Thay vì:** "Dựa vào báo cáo tài chính 50 trang này, phân tích điểm yếu, viết email cho CEO, rồi tạo slide."
- **Tách nhỏ:**
  1. "Trích xuất 3 điểm yếu chính trong báo cáo này."
  2. "Dùng 3 điểm yếu đó, soạn email cho CEO."
  3. "Chuyển email đó thành 3 gạch đầu dòng để bỏ vào slide."

### 4.2 Định dạng đầu ra cụ thể

Context mơ hồ về cấu trúc mong muốn. Áp đặt cấu trúc để **gọt** đầu ra.

- **Thay vì:** "Viết đánh giá sản phẩm" (dù context đã đủ tính năng).
- **Dùng template:**

```
Tiêu đề:   [Tiêu đề hấp dẫn]
Tóm tắt:   [Mô tả trong 1 câu]
Ưu điểm:   - [...]
           - [...]
Nhược điểm: - [...]
Kết luận:  [Ai nên mua sản phẩm này]
```

### 4.3 Phân vai và đối tượng mục tiêu

Context thường thiếu **"ai đang viết"** và **"viết cho ai"** — hai thứ đổi hoàn toàn giọng văn và cách lọc thông tin.

| Vế | Nó điều khiển cái gì |
|----|----------------------|
| **Phân vai** (ai viết) | Chuyên môn, thái độ, quyền hạn trong câu trả lời |
| **Đối tượng** (viết cho ai) | Độ phức tạp, ví dụ dùng, và cả **những gì nên lược bỏ** |

- Phân vai: *"Bạn là kiến trúc sư giải pháp cloud dày dạn, ưa sự chính xác."*
- Đối tượng: *"Giải thích cho sinh viên năm nhất"* · *"Viết email bán hàng cho CFO"*.

### 4.4 Dây xích suy nghĩ (Chain-of-Thought)

Vũ khí khi context đã tốt mà đầu ra vẫn sai hoặc hời hợt: bắt model **nghĩ thành tiếng** trước khi chốt.

```
Đọc bối cảnh sau. Trước khi trả lời, làm từng bước:
1. Xác định các giả định chính trong bài toán.
2. Phác thảo 2–3 hướng giải quyết khả thi.
3. Chọn hướng tốt nhất và giải thích lý do.
Sau đó mới đưa ra câu trả lời cuối cùng.
```

### 4.5 Cung cấp ví dụ (Few-shot)

Context cho biết **cái gì**, ví dụ cho biết **như thế nào**. Model bắt chước rất giỏi — đưa 1–3 cặp Input–Output ngay trong prompt.

```
Input: "Sản phẩm dùng tạm được."  → Output: Trung tính
Input: "Quá tệ, phí tiền!"        → Output: Tiêu cực
Input: "Mình rất hài lòng."       → Output: Tích cực
Input: "Đóng gói cẩn thận."       → Output: ?
```

### 4.6 Tham số điều khiển (khi gọi API)

- **Temperature** — hạ 0.1–0.3 cho phân tích và trích xuất dữ kiện; nâng 0.7–0.9 cho sáng tạo.
  Context tốt + nhiệt độ cao vẫn dễ **bịa ra khỏi khung**.
- **Top-P** — kết hợp với temperature để kiểm soát độ đa dạng. Chỉnh **một** trong hai, đừng chỉnh cả hai.

---

## 5. Ví dụ so sánh: context "đủ" vs prompt "xuất sắc"

**Context chung cho cả hai:** *"Công ty A lợi nhuận giảm 20% do chuỗi cung ứng đứt gãy. Sản phẩm chính
là điện thoại X, ra mắt năm ngoái, vòng đời sắp hết. Đối thủ B vừa ra sản phẩm cạnh tranh."*

| | Prompt | Kết quả |
|---|--------|---------|
| **Chỉ context** | "Phân tích công ty A." | Bài phân tích lan man, thiếu chiều sâu |
| **Có đủ 5 vế** | "Vai trò: nhà phân tích chiến lược cấp cao. Đối tượng: CEO. Nhiệm vụ: dựa vào bối cảnh trên, làm 2 bước — (1) chỉ ra **đúng 2** rủi ro chết người; (2) mỗi rủi ro đề xuất **1** hành động cụ thể cho quý tới. Trình bày dạng báo cáo 1 trang." | Súc tích, có cấu trúc, hướng hành động, đúng giọng cho CEO |

Khác biệt không nằm ở lượng thông tin — hai prompt cùng một context. Nó nằm ở **vai, đối tượng, số lượng
bị chốt cứng, và hình dạng đầu ra**.

---

## 6. Kiểm tra nhanh trước khi gửi

1. Đưa prompt này cho người khác, họ có làm ra **cùng một thứ** không? Không ⇒ thiếu **ràng buộc**, không phải thiếu context.
2. Câu nào cho biết **khi nào được dừng**? Không có ⇒ thêm **biên nhận**.
3. Vế nào hiểu được **hai nghĩa** dẫn tới hai việc khác nhau? Có ⇒ chốt, hoặc nói rõ giả định.
4. Đã nạp file nào mà **không dùng tới**? Có ⇒ bỏ ra lần sau (mục 3 ở trên).
5. Đã nói **cách tư duy** và **hình dạng đầu ra** chưa, hay mới chỉ đổ thông tin vào?

---

## 7. Khuôn này nằm ở đâu trong `prompt-fullstack.md`

File [prompt-fullstack.md](prompt-fullstack.md) là bản áp dụng đầy đủ nhất của khuôn 5 vế trong repo
này. Muốn xem một vế trông ra sao khi viết nghiêm túc thì mở đúng mục tương ứng:

| Vế | Ở đâu trong [prompt-fullstack.md](prompt-fullstack.md) |
|----|---------------------------------------------------------|
| Phân vai + đối tượng (4.3) | §1 |
| Nhiệm vụ | §2 — nói thẳng "không viết code", giao **kế hoạch** |
| Ngữ cảnh | §3 — chỉ những dữ kiện đổi được quyết định, kèm 3 câu **chưa rõ** để không bịa |
| Ràng buộc | §4 — 11 dòng, mỗi dòng nói rõ vi phạm thì mất gì |
| Biên nhận | §6 — ba tầng chất lượng, mỗi bất biến phải có **query đối chiếu** |
| Hình dạng đầu ra | §8 — template cố định + trần 12 dòng master task mỗi pha |
| Phân tách nhiệm vụ (4.1) | §7 — 6 pha, mỗi lượt trả lời đúng một pha |
| Chain-of-Thought (4.4) | §10 — 4 câu phải tự trả lời trước khi viết dòng đầu tiên |
| Few-shot (4.5) | §9 — cặp SAI / ĐÚNG cho dòng task và cho bất biến |
| Tham số (4.6) | §11 — nhiệt độ 0.1–0.3 |

Đọc bằng lệnh, đừng tin trí nhớ:

```
grep -n '^## §' prompt-fullstack.md
```

---

## 8. Điểm yếu hay gặp nhất khi mở session

Không nằm ở context — context thường đã đủ. Nó nằm ở chỗ prompt mở session **thường không khai biên nhận**,
nên agent phải tự suy ra lúc nào là xong. Khai thẳng một dòng theo mẫu mục 1 cắt được phần lớn sai lệch còn lại:

```
Nhiệm vụ: <một việc>. Phạm vi: <file được chạm>. Xong khi: <lệnh + kết quả kỳ vọng>.
```
