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
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="11" ss:Color="#000000"
    ss:Bold="1"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="36"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="94.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="112.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="147"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="100.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="97.5"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
   </Row>
   <Row ss:Height="15.75">
    <Cell ss:Index="2" ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"><Data ss:Type="String">DANH SÁCH HỢP ĐỒNG CHƯA THANH TOÁN</Data></Cell>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
   </Row>
   <Row ss:Index="4" ss:AutoFitHeight="0" ss:Height="18.75">
    <Cell ss:StyleID="s63"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Số hợp đồng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Loại hợp đồng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Đối tác</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày ký</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày hết hạn</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row>
    <Cell ss:Index="2" ss:StyleID="s65"><Data ss:Type="String">Tổng cộng: </Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="Number"><xsl:value-of select="/root/summary/sohopdongchuathanhtoan"/></Data></Cell>
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
     <ActiveRow>11</ActiveRow>
     <ActiveCol>4</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 <Worksheet ss:Name="Sheet2">
  <Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"
   x:FullRows="1" ss:DefaultRowHeight="15">
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 <Worksheet ss:Name="Sheet3">
  <Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"
   x:FullRows="1" ss:DefaultRowHeight="15">
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
	<Row>
		<Cell ss:StyleID="s67"><Data ss:Type="Number"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./sohopdong'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./loaihopdong'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./doitac'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngayky'/></Data></Cell>
		<Cell ss:StyleID="s67"><Data ss:Type="String"><xsl:value-of select='./ngayhethan'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>