# Makefile — nhà duy nhất của mọi lệnh (CLAUDE.md §2). CI gọi lại, cấm chép lệnh ra chỗ khác.
# Cập nhật 2026-08-15 · Lane sở hữu: DevOps · Sinh bởi T-02 · Phép đo: 07-cau-truc-du-an.md §4

TASK := project_preparation/project_preparation_task_finding/task_project_preparation.md

# Phạm vi quét của `check` — các sổ do CLAUDE.md quản.
# KHÔNG gồm wireframes/: tư liệu nhập từ repo đời trước, con trỏ trỏ ra ngoài repo này,
# chưa lane nào sở hữu. Cổng đỏ vĩnh viễn vì rác không ai nhận là cổng sẽ bị vô hiệu hoá.
DOCS := CLAUDE.md project_preparation design quality plan

.DEFAULT_GOAL := check
.PHONY: check check-links check-task-cols status next-id

## check — cổng của lane giấy tờ. Đỏ = có thứ đang lệch, không phải "cần rà lại".
check:
	@rc=0; \
	$(MAKE) --no-print-directory check-links     2>/dev/null || rc=1; \
	$(MAKE) --no-print-directory check-task-cols 2>/dev/null || rc=1; \
	if [ $$rc -eq 0 ]; then echo "make check: XANH"; else echo "make check: ĐỎ"; fi; \
	exit $$rc

## Phép 1 (07 §4) — link chết. Bỏ qua khối ``` : file hướng dẫn chứa link ví dụ
## và sẽ tự bắt chính nó (bẫy F-60 đời trước).
check-links:
	@out=$$(find $(DOCS) -name '*.md' -print0 2>/dev/null \
	| xargs -0 awk 'FNR==1 { d=FILENAME; sub(/\/[^\/]*$$/,"",d); if (d==FILENAME) d="."; c=0 } /^[ \t]*```/ { c=!c; next } c { next } { l=$$0; while (match(l,/\]\([^)]*\)/)) { t=substr(l,RSTART+2,RLENGTH-3); l=substr(l,RSTART+RLENGTH); if (t ~ /^(https?:|mailto:|#)/) continue; sub(/#.*$$/,"",t); if (t=="") continue; print FILENAME "\t" FNR "\t" d "/" t } }' \
	| while IFS="$$(printf '\t')" read -r f n p; do \
	    [ -e "$$p" ] || printf '  %s:%s -> %s\n' "$$f" "$$n" "$$p"; \
	  done); \
	if [ -n "$$out" ]; then \
	  echo "phép 1 · link chết:"; printf '%s\n' "$$out"; \
	  printf '%s\n' "$$out" | sed 's/.*-> //' | sort -u | sed 's/^/  đích không tồn tại: /'; \
	  exit 1; \
	fi; \
	echo "phép 1 · link chết: không có"

## Phép 4 (07 §4) — dòng task lệch cột. 6 cột ⇒ NF=8 khi cắt theo '|'.
## Ô chứa '|' trần cũng rơi vào đây: đó là lỗi thật, không phải nhiễu.
check-task-cols:
	@out=$$(awk -F'|' '/^\| (~~)?\*\*T-/ && NF != 8 { printf "  %s (NF=%d, cần 8)\n", $$2, NF }' $(TASK)); \
	if [ -n "$$out" ]; then \
	  echo "phép 4 · dòng task lệch cột:"; printf '%s\n' "$$out"; exit 1; \
	fi; \
	echo "phép 4 · dòng task lệch cột: không có"

## status — hiện trạng KHÔNG có nhà (CLAUDE.md §2): derive bằng lệnh, đừng chép thành file.
status:
	@printf 'commit          : %s\n' "$$(git log --oneline | wc -l | tr -d ' ')"
	@printf 'commit theo lane:\n'
	@git log --format='%s' | sed -n 's/^\([A-Z][A-Z-]*\):.*/  \1/p' | sort | uniq -c | sort -rn
	@printf 'file .md        : %s\n' "$$(find . -name '*.md' -not -path './.git/*' | wc -l | tr -d ' ')"
	@printf 'task chưa gạch  : %s\n' "$$(grep -c '^| \*\*T-' $(TASK) | tr -d ' ')"
	@printf 'task đã gạch    : %s\n' "$$(grep -c '^| ~~\*\*T-' $(TASK) | tr -d ' ')"

## next-id — mã T-xx kế tiếp. Mã không bao giờ tái sử dụng ⇒ lấy max+1, không lấp chỗ trống.
## Chỉ quét hàng đợi liên lane; sổ theo lane dùng dải T-<LANE>-xx nên không giao mã.
next-id:
	@grep -o 'T-[0-9][0-9]*' $(TASK) | sed 's/T-//' \
	| sort -n | tail -1 | awk '{ printf "T-%02d\n", $$1 + 1 }'
