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
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="11" ss:Color="#000000"
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
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="d/m/yyyy"/>
  </Style>
  <Style ss:ID="s69" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s70" ss:Parent="s43">
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s71" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s72" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s73" ss:Parent="s43">
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
  <Style ss:ID="s74" ss:Parent="s43">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s75" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s76">
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
  <Style ss:ID="s77" ss:Parent="s43">
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="36"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="101.25"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="91.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="84.75"/>
   <Column ss:StyleID="s75" ss:Width="110.25"/>
   <Column ss:StyleID="s75" ss:Width="101.25"/>
   <Column ss:StyleID="s70" ss:Width="123"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="85.5"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="90"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="96"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
   </Row>
   <Row ss:Height="15.75">
    <Cell ss:Index="2" ss:StyleID="s67"/>
    <Cell ss:StyleID="s67"/>
    <Cell ss:StyleID="s67"/>
    <Cell ss:StyleID="s71"><Data ss:Type="String">DANH SÁCH HỢP ĐỒNG CHƯA THANH TOÁN</Data></Cell>
    <Cell ss:StyleID="s71"/>
   </Row>
   <Row ss:Index="4" ss:AutoFitHeight="0" ss:Height="18.75">
    <Cell ss:StyleID="s63"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Tên phụ lục</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Hợp đồng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Số lượng kênh</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">Thành tiền trước thuế</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">Thành tiền sau thuế</Data></Cell>
    <Cell ss:StyleID="s72"><Data ss:Type="String">Cước đấu nối hòa mạng</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày ký phụ lục</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày có hiệu lực</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">Ngày hết hiệu lực</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row>
    <Cell ss:Index="3" ss:StyleID="s65"><Data ss:Type="String">Tổng cộng</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongkenh"/></Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongtientruocthue"/></Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongtiensauthue"/></Data></Cell>
    <Cell ss:StyleID="s77"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongcuocdaunoi"/></Data></Cell>
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
     <ActiveRow>16</ActiveRow>
     <ActiveCol>4</ActiveCol>
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
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./tenphuluc'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="String"><xsl:value-of select='./tenhopdong'/></Data></Cell>
		<Cell ss:StyleID="s66"><Data ss:Type="Number"><xsl:value-of select='./soluongkenh'/></Data></Cell>
		<Cell ss:StyleID="s73"><Data ss:Type="Number"><xsl:value-of select='./giatritruocthue'/></Data></Cell>
		<Cell ss:StyleID="s73"><Data ss:Type="Number"><xsl:value-of select='./giatrisauthue'/></Data></Cell>
		<Cell ss:StyleID="s74"><Data ss:Type="Number"><xsl:value-of select='./cuocdaunoi'/></Data></Cell>
		<Cell ss:StyleID="s76"><Data ss:Type="DateTime"><xsl:value-of select='./ngayky'/></Data></Cell>
		<Cell ss:StyleID="s76"><Data ss:Type="DateTime"><xsl:value-of select='./ngayhieuluc'/></Data></Cell>
		<Cell ss:StyleID="s68"><Data ss:Type="DateTime"><xsl:value-of select='./ngayhethieuluc'/></Data></Cell>
   </Row>
</xsl:template>
</xsl:stylesheet>