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
   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s62">
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s65">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
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
   <NumberFormat ss:Format="d/m/yyyy"/>
  </Style>
  <Style ss:ID="s68">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Italic="1"/>
  </Style>
  <Style ss:ID="s69">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s70">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="h:mm:ss"/>
  </Style>
  <Style ss:ID="s72" ss:Parent="s43">
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s73">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="28.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="71.25"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="60"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="66"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="82.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="57.75"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="45.75"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="81"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="78.75"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="79.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="65.25"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="68.25"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="63.75"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="84"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="108"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="69.75"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="72.75"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s64"/>
    <Cell ss:StyleID="s64"/>
    <Cell ss:StyleID="s64"/>
    <Cell ss:StyleID="s64"/>
   </Row>
   <Row ss:Height="15.75">
    <Cell ss:Index="7" ss:StyleID="s64"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"><Data ss:Type="String">BÁO CÁO SỰ CỐ THEO THỜI GIAN</Data></Cell>
    <Cell ss:StyleID="s65"/>
   </Row>
   <Row>
    <Cell ss:Index="9" ss:StyleID="s68"><Data ss:Type="String">Đối tác <xsl:value-of select="/root/header/tendoitac"/> - <xsl:value-of select="/root/header/thang"/></Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18.75"/>
   <Row ss:AutoFitHeight="0" ss:Height="49.5">
    <Cell ss:StyleID="s69"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Mã Tuyến Kênh</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Mã điểm đầu</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Mã điểm cuối</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Loại giao tiếp</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Dung lượng</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Số lượng</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Hợp đồng</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Ngày bắt đầu</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Ngày kết thúc</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Thời gian bắt đầu</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Thời gian kết thúc</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Thời gian mất liên lạc</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Nguyên nhân</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Phương án xử lý</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Loại sự cố</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">Người xác nhận</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row>
    <Cell ss:Index="2" ss:MergeAcross="10" ss:StyleID="s73"><Data ss:Type="String">Tổng thời gian mất liên lạc: </Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tong"/></Data></Cell>
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
     <ActiveRow>19</ActiveRow>
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
		<Cell ss:StyleID="s66"><Data ss:Type="Number"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./id'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./madiemdau'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./madiemcuoi'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./loaigiaotiep'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="Number"><xsl:value-of select='./dungluong'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="Number"><xsl:value-of select='./soluong'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./hopdong'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngaybatdau'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngayketthuc'/></Data></Cell>
		<Cell ss:StyleID="s70"><Data ss:Type="String"><xsl:value-of select='./thoigianbatdau'/></Data></Cell>
		<Cell ss:StyleID="s70"><Data ss:Type="String"><xsl:value-of select='./thoigianketthuc'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="Number"><xsl:value-of select='./thoigianmll'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./nguyennhan'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./phuonganxuly'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./loaisuco'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./nguoixacnhan'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>