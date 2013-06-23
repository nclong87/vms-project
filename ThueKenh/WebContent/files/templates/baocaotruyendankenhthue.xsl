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
   <Font ss:FontName="Arial"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s16" ss:Name="Comma">
   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
  </Style>
  <Style ss:ID="s69">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s70">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s74">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s93" ss:Parent="s16">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s94" ss:Parent="s16">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s95" ss:Parent="s16">
   <Font ss:FontName="Arial"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Báo cáo truyền dẫn kênh thuê">
  <Table ss:ExpandedColumnCount="11" x:FullColumns="1"
   x:FullRows="1">
   <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>
   <Column ss:AutoFitWidth="0" ss:Width="287.25"/>
   <Column ss:AutoFitWidth="0" ss:Width="66"/>
   <Column ss:AutoFitWidth="0" ss:Width="120.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="90.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="74.25"/>
   <Column ss:AutoFitWidth="0" ss:Width="75.75"/>
   <Column ss:StyleID="s95" ss:AutoFitWidth="0" ss:Width="112.5"/>
   <Row ss:AutoFitHeight="0" ss:Height="33">
    <Cell ss:StyleID="s70"><Data ss:Type="String">TT</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Địa chỉ điểm A&#10;(Tỉnh/Huyện/Xã/Số nhà)</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Các node kết&#10;vào điểm A</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Địa chỉ điểm B&#10;(Tỉnh/Huyện/Xã/Số nhà)</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Các node kết&#10;vào điểm B</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Tổng dung lượng&#10;(Mbps)</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Kênh truyền&#10;dẫn cấp 1/2/3</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Đơn vị&#10;cho thuê kênh</Data></Cell>
    <Cell ss:StyleID="s93"><Data ss:Type="String">Kinh phí&#10;thuê hàng tháng(VNĐ)</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Tháng</Data></Cell>
    <Cell ss:StyleID="s70"><Data ss:Type="String">Năm</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Print>
    <ValidPrinterInfo/>
    <HorizontalResolution>300</HorizontalResolution>
    <VerticalResolution>300</VerticalResolution>
   </Print>
   <Selected/>
   <LeftColumnVisible>2</LeftColumnVisible>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>8</ActiveCol>
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
		<Cell ss:StyleID="s74"><Data ss:Type="String"><xsl:value-of select='./trungtam'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./diemdau'/></Data></Cell>
		<Cell ss:StyleID="s69"/>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./diemcuoi'/></Data></Cell>
		<Cell ss:StyleID="s69"/>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./tongdungluong'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./loaikenh'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="String"><xsl:value-of select='./donvithuekenh'/></Data></Cell>
		<Cell ss:StyleID="s94"><Data ss:Type="Number"><xsl:value-of select='./kinhphithuebaothang'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="Number"><xsl:value-of select='./thang'/></Data></Cell>
		<Cell ss:StyleID="s69"><Data ss:Type="Number"><xsl:value-of select='./nam'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>