var trangthai_utils = {
	tuyenkenhDisplay : function(matrangthai) {
		switch(parseInt(matrangthai)) {
			case 0 :
				return '<div class="mau_xam" title="Không hoạt động"></div>';
				break;
			case 1 :
				return '<div class="mau_vang" title="Đang bàn giao"></div>';
				break;
			case 2 :
				return '<div class="mau_vang" title="Đang cập nhật số lượng"></div>';
				break;
			case 3 :
				return '<div class="mau_xanh_la" title="Đang hoạt động"></div>';
				break;
			default:
				return '';
				break;
		}
	},
	tuyenkenhText : function(matrangthai) {
		switch(parseInt(matrangthai)) {
			case 0 :
				return 'Không hoạt động';
				break;
			case 1 :
				return 'Đang bàn giao';
				break;
			case 2 :
				return 'Đang cập nhật số lượng';
				break;
			case 3 :
				return 'Đang hoạt động';
				break;
			default:
				return '';
				break;
		}
	},
	tuyenkenhdexuatDisplay : function (matrangthai) {
		switch(parseInt(matrangthai)) {
			case 0 :
				return '<div class="mau_vang" title="Đang bàn giao"></div>';
				break;
			case 1 :
				return '<div class="mau_xanh_bien" title="Đã bàn giao"></div>';
				break;
			case 2 :
				return '<div class="mau_xanh_la" title="Đã có biên bàn giao"></div>';
				break;
			default:
				return '';
				break;
		}
	},
	dexuatDisplay : function (matrangthai) {
		switch(parseInt(matrangthai)) {
			case 0 :
				return '<div class="mau_vang" title="Đang bàn giao"></div>';
				break;
			case 1 :
				return '<div class="mau_xanh_bien" title="Đã bàn giao"></div>';
				break;
			default:
				return '';
				break;
		}
	}
}
