<?xml version="1.0" encoding="UTF-8"?>
<?mso-application progid="Excel.Sheet"?>
<xsl:stylesheet version="1.0" 
xmlns:html="http://www.w3.org/TR/REC-html40"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office" 
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">

<xsl:template match="/">
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
<Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s43" ss:Name="Comma">
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="m45896808" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="m45896838" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1" ss:Italic="1"/>
  </Style>
  <Style ss:ID="m45896656">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="m45896666">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896676">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896686">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896504">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="m45896514">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="m45896524">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="Medium Date"/>
  </Style>
  <Style ss:ID="m45896534">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="Medium Date"/>
  </Style>
  <Style ss:ID="m45896372" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="m45896412">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896422">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896432">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="m45896442">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s62">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Medium Date"/>
  </Style>
  <Style ss:ID="s65">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s66" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s67">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s68">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s69">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s70" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat ss:Format="h:mm:ss"/>
  </Style>
  <Style ss:ID="s71">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s72" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s73" ss:Parent="s43">
   <Alignment ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s74" ss:Parent="s43">
   <Alignment ss:Vertical="Top"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s75" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s76" ss:Parent="s43">
   <Alignment ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="8"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s77">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s78">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s79">
   <NumberFormat ss:Format="Fixed"/>
  </Style>
  <Style ss:ID="s104">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s105">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s106">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s107">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s110" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s112">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="14"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s126">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Doi soat giam tru MLL">
  <Table ss:ExpandedColumnCount="16" ss:ExpandedRowCount="29" x:FullColumns="1"
   x:FullRows="1" ss:DefaultRowHeight="15.75">
   <Column ss:StyleID="s62" ss:Width="27"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="57.75"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="55.5"/>
   <Column ss:Index="6" ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="94.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="85.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="92.25"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="93"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Span="1"/>
   <Column ss:Index="12" ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="103.5"/>
   <Column ss:StyleID="s62" ss:Width="152.25"/>
   <Column ss:StyleID="s66" ss:AutoFitWidth="0" ss:Width="76.5"/>
   <Column ss:StyleID="s66" ss:AutoFitWidth="0" ss:Width="75.75"/>
   <Column ss:Width="72"/>
   <Row>
    <Cell ss:MergeAcross="4"><Data ss:Type="String">TẬP ĐOÀN </Data></Cell>
    <Cell ss:Index="9" ss:MergeAcross="6" ss:StyleID="s104"><Data ss:Type="String">CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="4"><Data ss:Type="String">BƯU CHÍNH VIỄN THÔNG VIỆT NAM</Data></Cell>
    <Cell ss:Index="9" ss:MergeAcross="6" ss:StyleID="s105"><Data ss:Type="String">Độc Lập – Tự Do – Hạnh Phúc</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="4" ss:StyleID="s106"><Data ss:Type="String">VNPT <xsl:value-of select="/root/header/tendoitac"/></Data></Cell>
    <Cell ss:Index="9" ss:MergeAcross="6" ss:StyleID="s107"><Data ss:Type="String"
      x:Ticked="1">&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;-</Data></Cell>
   </Row>
   <Row>
    <Cell ss:Index="9" ss:MergeAcross="6" ss:StyleID="s104"><Data ss:Type="String">……………………..., ngày……..tháng….....năm……...</Data></Cell>
   </Row>
   <Row ss:Index="6" ss:AutoFitHeight="0" ss:Height="50.25">
    <Cell ss:MergeAcross="14" ss:StyleID="s112"><Data ss:Type="String">BẢNG ĐỐI SOÁT GIẢM TRỪ MẤT LIÊN LẠC KÊNH THUÊ THÁNG <xsl:value-of select="/root/header/thang"/> GIỮA VNPT <xsl:value-of select="/root/header/tendoitac"/> VÀ TRUNG TÂM THÔNG TIN DI ĐỘNG KHU VỰC VI</Data></Cell>
   </Row>
   <Row ss:Index="8" ss:AutoFitHeight="0" ss:Height="20.25">
    <Cell ss:MergeDown="1" ss:StyleID="m45896412"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="m45896422"><Data ss:Type="String">Tuyến kênh</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896432"><Data ss:Type="String">Giao tiếp</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896442"><Data ss:Type="String">Số lượng</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896504"><Data ss:Type="String">Ngày xảy ra sự cố</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896514"><Data ss:Type="String">Ngày kết thúc sự cố</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896524"><Data ss:Type="String">Thời gian bắt đầu</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896534"><Data ss:Type="String">Thời gian  kết thúc</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896666"><Data ss:Type="String">Thời gian MLL (phút)</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896656"><Data ss:Type="String">Thời gian MLL thực tế giảm trừ(phút)</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896676"><Data ss:Type="String">Nguyên nhân</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896686"><Data ss:Type="String">Hợp đồng/PLHĐ</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896808"><Data ss:Type="String">Cước tháng</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m45896372"><Data ss:Type="String">Số tiền giảm trừ (VNĐ)</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="40.5">
    <Cell ss:Index="2" ss:StyleID="s67"><Data ss:Type="String">Điểm đầu</Data></Cell>
    <Cell ss:StyleID="s67"><Data ss:Type="String">Điểm cuối</Data></Cell>
   </Row>
	<xsl:apply-templates select="/root/data/row"/>
   <Row ss:Height="15">
    <Cell ss:MergeAcross="7" ss:StyleID="s110"><Data ss:Type="String">Tổng: </Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tong"/></Data></Cell>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s74"/>
    <Cell ss:StyleID="s75"/>
   </Row>
   <Row ss:Height="15">
    <Cell ss:MergeAcross="7" ss:StyleID="s110"><Data ss:Type="String">Thuế VAT: </Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="Number"><xsl:value-of select="/root/summary/vat"/></Data></Cell>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s74"/>
    <Cell ss:StyleID="s76"/>
   </Row>
   <Row ss:Height="15">
    <Cell ss:MergeAcross="7" ss:StyleID="s110"><Data ss:Type="String">Tổng cước giảm trừ: </Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongcuocgiamtru"/></Data></Cell>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s73"/>
    <Cell ss:StyleID="s74"/>
    <Cell ss:StyleID="s76"/>
   </Row>
   <Row ss:Height="15">
    <Cell ss:MergeAcross="14" ss:StyleID="m45896838"><Data ss:Type="String">Bằng chữ: <xsl:value-of select="/root/summary/sotienbangchu"/></Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="5" ss:StyleID="s126"><Data ss:Type="String">ĐẠI DIỆN VNPT</Data></Cell>
    <Cell ss:StyleID="s77"/>
    <Cell ss:Index="10" ss:MergeAcross="5" ss:StyleID="s126"><Data ss:Type="String">ĐẠI DIỆN TRUNG TÂM TTDĐ KV VI </Data></Cell>
   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Print>
    <ValidPrinterInfo/>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
   <Selected/>
   <TopRowVisible>6</TopRowVisible>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>24</ActiveRow>
     <RangeSelection>R25C1:R26C8</RangeSelection>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
	<Row>
		<Cell ss:StyleID="s68"><Data ss:Type="Number"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="String"><xsl:value-of select='./madiemdau'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="String"><xsl:value-of select='./madiemcuoi'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="String"><xsl:value-of select='./loaigiaotiep'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="Number"><xsl:value-of select='./soluong'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./ngaybatdau'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./ngayketthuc'/></Data></Cell>
		<Cell ss:StyleID="s70"><Data ss:Type="String"><xsl:value-of select='./thoigianbatdau'/></Data></Cell>
		<Cell ss:StyleID="s70"><Data ss:Type="String"><xsl:value-of select='./thoigianketthuc'/></Data></Cell>
		<Cell ss:StyleID="s71"><Data ss:Type="Number"><xsl:value-of select='./thoigianmll'/></Data></Cell>
		<Cell ss:StyleID="s78"><Data ss:Type="Number"><xsl:value-of select='./thoigianmllchuagiamtru'/></Data></Cell>
		<Cell ss:StyleID="s71"><Data ss:Type="String"><xsl:value-of select='./nguyennhan'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="String"><xsl:value-of select='./hopdong'/></Data></Cell>
		<Cell ss:StyleID="s72"><Data ss:Type="Number"><xsl:value-of select='./cuocthang'/></Data></Cell>
		<Cell ss:StyleID="s72"><Data ss:Type="Number"><xsl:value-of select='./giamtrumll'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>