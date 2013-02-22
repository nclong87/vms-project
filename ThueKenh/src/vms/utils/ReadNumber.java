package vms.utils;

import java.text.DecimalFormat;


public class ReadNumber {
	private static final String[] hang_chuc = {
		""," mười"," hai mươi"," ba mươi"," bốn mươi"," năm mươi",
		" sáu mươi"," bảy mươi"," tám mươi"," chín mươi"
		};

		private static final String[] hang_don_vi = {
		""," một"," hai"," ba"," bốn"," năm"," sáu"," bảy",
		" tám"," chín"," mười"," mười một"," mười hai"," mười ba"," mười bốn",
		" mười lăm"," mười sáu"," mười bảy"," mười tám"," mười chín"
		};

		private static String chuyen_so_nho_hon_1_nghin(int n) {
		String chuoi_so;
		if (n % 100 < 20)
		{
		chuoi_so = hang_don_vi[n % 100];
		n /= 100;
		}
		else
		{
		chuoi_so = hang_don_vi[n % 10];
		n /= 10;
		chuoi_so = hang_chuc[n % 10] + chuoi_so;
		n /= 10;
		}
		if (n == 0) return chuoi_so;
		return hang_don_vi[n] + " trăm" + chuoi_so;
		}

		public static String read(String n)
		{
		if (n.equals("0")) { return "không"; }

		//String snumber = Long.toString(n);
		String mask = "000000000000";

		DecimalFormat dec = new DecimalFormat(mask);
		String snumber = dec.format(Long.parseLong(n));

		int Hang_Ty111411 = Integer.parseInt(snumber.substring(0,3));
		int Hang_Trieu111411 = Integer.parseInt(snumber.substring(3,6));
		int Hang_Tram_Nghin111411 = Integer.parseInt(snumber.substring(6,9));
		int Hang_Nghin111411 = Integer.parseInt(snumber.substring(9,12));

		String chuoiTy;

		switch (Hang_Ty111411)
		{
		case 0:
		chuoiTy = "";
		break;
		case 1 :
		chuoiTy = chuyen_so_nho_hon_1_nghin(Hang_Ty111411)+" tỷ ";
		break;
		default :
		chuoiTy = chuyen_so_nho_hon_1_nghin(Hang_Ty111411)+" tỷ ";
		}

		String Kq111411 = chuoiTy;
		String chuoiTrieu;

		switch (Hang_Trieu111411)
		{
		case 0:
		chuoiTrieu = "";
		break;
		case 1 :
		chuoiTrieu = chuyen_so_nho_hon_1_nghin(Hang_Trieu111411)+ " triệu ";
		break;
		default :
		chuoiTrieu = chuyen_so_nho_hon_1_nghin(Hang_Trieu111411)+ " triệu ";
		}

		Kq111411 = Kq111411 + chuoiTrieu;
		String chuoiTramNgan;

		switch (Hang_Tram_Nghin111411)
		{
		case 0:
		chuoiTramNgan = "";
		break;
		case 1 :
		chuoiTramNgan = "một nghìn ";
		break;
		default :
		chuoiTramNgan = chuyen_so_nho_hon_1_nghin(Hang_Tram_Nghin111411)+ " nghìn ";
		}

		Kq111411 = Kq111411 + chuoiTramNgan;

		String chuoingan = chuyen_so_nho_hon_1_nghin(Hang_Nghin111411);
		Kq111411 = Kq111411 + chuoingan;

		return Kq111411.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
		}

}