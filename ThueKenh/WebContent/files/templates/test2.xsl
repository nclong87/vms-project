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
   <Font/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="m29574032">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s21">
   <Font x:Family="Swiss" ss:Size="22" ss:Color="#FF0000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s22">
   <Font x:Family="Swiss" ss:Color="#FF0000"/>
  </Style>
  <Style ss:ID="s24">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:Size="14" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s26">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
  </Style>
  <Style ss:ID="s27">
   <Font ss:Size="12" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s28">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font x:Family="Swiss" ss:Color="#FFFFFF" ss:Bold="1"/>
   <Interior ss:Color="#008080" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s36">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s37">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s39">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders/>
   <Font x:Family="Swiss" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s41">
   <Alignment ss:Vertical="Center"/>
   <Font x:Family="Swiss" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Reporting">
  <Table >
   <Column ss:AutoFitWidth="0" ss:Width="84.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="114.75" ss:Span="1"/>
   <Column ss:Index="4" ss:AutoFitWidth="0" ss:Width="159.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="114.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="84.75" ss:Span="1"/>
   <Column ss:Index="8" ss:AutoFitWidth="0" ss:Width="159.75"/>
   <Row ss:AutoFitHeight="0" ss:Height="27.75">
    <Cell ss:StyleID="s21"><Data ss:Type="String">Example Spreadsheet</Data></Cell>
    <Cell ss:StyleID="s22"/>
    <Cell ss:StyleID="s22"/>
    <Cell ss:StyleID="s22"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:MergeAcross="3" ss:StyleID="s24"><Data ss:Type="String">Reporting</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="3" ss:StyleID="s26"><Data ss:Type="String">Từ ngày #### đến ngày ####</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:StyleID="s27"><Data ss:Type="String">Staff Memeber Report</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="12">
    <Cell ss:StyleID="s28"><Data ss:Type="String">User Id</Data></Cell>
    <Cell ss:StyleID="s28"><Data ss:Type="String">Account Name</Data></Cell>
    <Cell ss:StyleID="s28"><Data ss:Type="String">Số lượng</Data></Cell>
    <Cell ss:StyleID="s28"><Data ss:Type="String">Thành tiền</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:MergeAcross="1" ss:StyleID="s39"><Data ss:Type="String">Tổng cộng :</Data></Cell>
    <Cell ss:StyleID="s41"><Data ss:Type="Number">14</Data></Cell>
    <Cell ss:StyleID="s41"><Data ss:Type="Number">8000</Data></Cell>
   </Row>
  </Table>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
	<xsl:variable name="mergeDown" select="./num_child"/>
	<Row ss:Hidden="1">
		<Cell ss:MergeDown="{$mergeDown}" ss:StyleID="m29574032"><Data ss:Type="String"><xsl:value-of select='./uid'/></Data></Cell>
	</Row>
	<xsl:apply-templates select="./childs/child"/>
</xsl:template>
<xsl:template match="child">
	<Row>
		<Cell ss:Index="2" ss:StyleID="s36"><Data ss:Type="String"><xsl:value-of select='./name'/></Data></Cell>
		<Cell ss:StyleID="s37"><Data ss:Type="Number"><xsl:value-of select='./soluong'/></Data></Cell>
		<Cell ss:StyleID="s37"><Data ss:Type="Number"><xsl:value-of select='./thanhtien'/></Data></Cell>
	</Row>
</xsl:template>
<xsl:template match="summary">
<Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:MergeAcross="1" ss:StyleID="s32"><Data ss:Type="String">Tổng cộng :</Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="Number"><xsl:value-of select="./soluong"/></Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="Number"><xsl:value-of select="./thanhtien"/></Data></Cell>
   </Row>
</xsl:template>

</xsl:stylesheet>