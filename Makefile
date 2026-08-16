# Điểm vào của mọi lệnh. Thân nằm ở command/Makefile — file này KHÔNG giữ lệnh nào.
# Cập nhật 2026-08-15 · Lane sở hữu: DevOps
# Lý do có nó: `make` theo định nghĩa tìm ./Makefile. Bỏ hẳn file này thì `make check`
# gãy ở 6 biên nhận đang gọi tên nó (T-02·T-03·T-11·T-14·T-15 + design/fe/finding_fe.md).
include command/Makefile
