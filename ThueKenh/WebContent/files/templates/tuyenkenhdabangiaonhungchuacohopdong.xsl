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
  <Style ss:ID="s62">
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s65">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s67">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s68">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="36"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="94.5"/>
   <Column ss:StyleID="s64" ss:Width="72.75"/>
   <Column ss:StyleID="s64" ss:Width="75.75"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="84"/>
   <Column ss:StyleID="s64" ss:Width="70.5"/>
   <Column ss:StyleID="s64" ss:Width="55.5"/>
   <Column ss:StyleID="s64" ss:Width="124.5"/>
   <Column ss:StyleID="s64" ss:Width="104.25"/>
   <Column ss:StyleID="s64" ss:Width="89.25"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="179.25"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
   </Row>
   <Row ss:Height="15.75">
    <Cell ss:Index="4" ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"><Data ss:Type="String">DANH SÁCH TUYẾN KÊNH ĐÃ BÀN GIAO NHƯNG CHƯA CÓ HỢP ĐỒNG</Data></Cell>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s65"/>
   </Row>
	<Row ss:Index="4" ss:AutoFitHeight="0" ss:Height="18.75">
    <Cell ss:StyleID="s63"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Mã Tuyến Kênh</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Mã điểm đầu</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Mã điểm cuối</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Loại giao tiếp</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Dung lượng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Số lượng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày đề nghị bàn giao</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày hẹn bàn giao</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Số lượng đề xuất</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Đối tác</Data></Cell>
   </Row>
	<xsl:apply-templates select="/root/data/row"/>
   <Row>
    <Cell ss:Index="2" ss:StyleID="s65"><Data ss:Type="String">Tổng cộng: </Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="Number"><xsl:value-of select="/root/summary/sokenhchuabangiao"/></Data></Cell>
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
    <HorizontalResolution>300</HorizontalResolution>
    <VerticalResolution>0</VerticalResolution>
    <NumberofCopies>0</NumberofCopies>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>13</ActiveRow>
     <ActiveCol>7</ActiveCol>
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
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./id'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./madiemdau'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./madiemcuoi'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./loaigiaotiep'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./dungluong'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./soluong'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngaydenghibangiao'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngayhenbangiao'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./soluongdexuat'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="String"><xsl:value-of select='./tendoitac'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>