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
  <Style ss:ID="s16" ss:Name="Comma">
   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="m70366976">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m70366996">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m70367016">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m70367036">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m70367056">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s62">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s65" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s68" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s69">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="11" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
  <Style ss:ID="s70" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s71" ss:Parent="s16">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s72">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s73" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s74">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s83" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s84" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s85">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="[$-1010000]d/m/yyyy;@"/>
  </Style>
  <Style ss:ID="s86" ss:Parent="s16">
   <Alignment ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s94" ss:Parent="s16">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s95">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s96" ss:Parent="s16">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s97">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s98" ss:Parent="s16">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s99">
   <Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"
    ss:Italic="1" ss:Underline="Single"/>
  </Style>
  <Style ss:ID="s100">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"
    ss:Italic="1" ss:Underline="Single"/>
  </Style>
  <Style ss:ID="s101">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Italic="1"/>
  </Style>
  <Style ss:ID="s102">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s103">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s104">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="27.75"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="82.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="53.25"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="72.75"/>
   <Column ss:StyleID="s65" ss:Width="110.25"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="43.5"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="40.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="76.5"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="95.25"/>
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="81.75"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="88.5"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="84.75"/>
   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="96.75"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21">
    <Cell ss:Index="4" ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s70"><Data ss:Type="String">BẢNG THỐNG KÊ CƯỚC VIỄN THÔNG CÒN THANH TOÁN TỪ <xsl:value-of select="/root/header/tungay"/> - <xsl:value-of select="/root/header/denngay"/> - MLL TỪ <xsl:value-of select="/root/header/matlienlactu"/> ĐẾN <xsl:value-of select="/root/header/matlienlacden"/></Data></Cell>
    <Cell ss:StyleID="s70"/>
    <Cell ss:StyleID="s71"/>
    <Cell ss:Index="11" ss:StyleID="s63"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18.75">
    <Cell ss:Index="5" ss:StyleID="s63"/>
    <Cell ss:StyleID="s63"/>
    <Cell ss:StyleID="s68"><Data ss:Type="String">GIỮA <xsl:value-of select="/root/header/tendoitac"/> VÀ TRUNG TÂM TTDĐ KHU VỰC VI</Data></Cell>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s71"/>
    <Cell ss:Index="11" ss:StyleID="s63"/>
   </Row>
   <Row ss:Index="5" ss:AutoFitHeight="0" ss:Height="73.5">
    <Cell ss:StyleID="s72"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">SỐ HĐ</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">SỐ PLHĐ</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">GTHĐ</Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="String">THỜI GIAN</Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="String">THÁNG</Data></Cell>
    <Cell ss:StyleID="s73"><Data ss:Type="String">NGÀY</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">SỐ KÊNH</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">THÀNH TIỀN</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">GIẢM TRỪ MLL TỪ <xsl:value-of select="/root/header/matlienlactu"/> ĐẾN <xsl:value-of select="/root/header/matlienlacden"/></Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">ĐNHM</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">ĐÃ TT</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">CÒN TT</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <Cell ss:MergeAcross="7" ss:StyleID="m70367056"><Data ss:Type="String">TỔNG</Data></Cell>
    <Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongthanhtien"/></Data></Cell>
    <Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tonggiamtru"/></Data></Cell>
    <Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongdaunoihoamang"/></Data></Cell>
    <Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongdathanhtoan"/></Data></Cell>
    <Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongconthanhtoan"/></Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <Cell ss:Index="3" ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s95"><Data ss:Type="String">10% VAT :</Data></Cell>
    <Cell ss:StyleID="s96"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongvat"/></Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="25.5">
    <Cell ss:Index="12" ss:StyleID="s97"><Data ss:Type="String">TỔNG CỘNG :</Data></Cell>
    <Cell ss:StyleID="s98"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongcong"/></Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <Cell ss:Index="2" ss:StyleID="s99"><Data ss:Type="String">Xác nhận của Trung tâm TTDĐ Khu vực VI</Data></Cell>
    <Cell ss:StyleID="s100"/>
    <Cell ss:StyleID="s100"/>
    <Cell ss:Index="11" ss:StyleID="s101"><Data ss:Type="String">…………………….. Ngày ………. Tháng ……… Năm ……….</Data></Cell>
    <Cell ss:StyleID="s101"/>
    <Cell ss:StyleID="s101"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:Index="8"><Data ss:Type="String"> </Data></Cell>
    <Cell ss:Index="12" ss:StyleID="s102"><Data ss:Type="String">KẾ TOÁN TRƯỞNG</Data></Cell>
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
     <ActiveRow>7</ActiveRow>
     <ActiveCol>6</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
	<xsl:variable name="mergeDown" select="./num_child"/>
	<Row ss:Hidden="1">
		<Cell ss:MergeDown="{$mergeDown}" ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:MergeDown="{$mergeDown}" ss:StyleID="s103"><Data ss:Type="String"><xsl:value-of select='./sohopdong'/></Data></Cell>
   </Row>
   <xsl:apply-templates select="./childs/child"/>
</xsl:template>
<xsl:template match="child">
	<Row>
		<Cell ss:Index="3" ss:StyleID="s74"><Data ss:Type="String"><xsl:value-of select='./tenphuluc'/></Data></Cell>
		<Cell ss:StyleID="s83"><Data ss:Type="Number"><xsl:value-of select='./giatriphuluc'/></Data></Cell>
		<Cell ss:StyleID="s83"><Data ss:Type="String"><xsl:value-of select='./tungay'/> - <xsl:value-of select='./denngay'/></Data></Cell>
		<Cell ss:StyleID="s84"><Data ss:Type="Number"><xsl:value-of select='./sothang'/></Data></Cell>
		<Cell ss:StyleID="s84"><Data ss:Type="Number"><xsl:value-of select='./songay'/></Data></Cell>
		<Cell ss:StyleID="s85"><Data ss:Type="String"><xsl:value-of select='./soluongkenh'/></Data></Cell>
		<Cell ss:StyleID="s83"><Data ss:Type="Number"><xsl:value-of select='./thanhtien'/></Data></Cell>
		<Cell ss:StyleID="s83"><Data ss:Type="Number"><xsl:value-of select='./giamtrumll'/></Data></Cell>
		<Cell ss:StyleID="s86"><Data ss:Type="Number"><xsl:value-of select='./cuocdaunoi'/></Data></Cell>
		<Cell ss:StyleID="s86"><Data ss:Type="Number"><xsl:value-of select='./dathanhtoan'/></Data></Cell>
		<Cell ss:StyleID="s86"><Data ss:Type="Number"><xsl:value-of select='./conthanhtoan'/></Data></Cell>
	</Row>
</xsl:template>
</xsl:stylesheet>