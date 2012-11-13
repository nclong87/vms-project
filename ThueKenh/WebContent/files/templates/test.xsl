﻿<?xml version="1.0" encoding="UTF-8"?>
<?mso-application progid="Excel.Sheet"?>
<xsl:stylesheet version="1.0" 
xmlns:html="http://www.w3.org/TR/REC-html40"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office" 
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">

<xsl:template match="/">
<Workbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s21">
   <Font x:Family="Swiss" ss:Size="22" ss:Color="#FF0000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s22">
   <Font x:Family="Swiss" ss:Color="#FF0000"/>
  </Style>
  <Style ss:ID="s24">
   <Font ss:Size="12" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s25">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font x:Family="Swiss" ss:Color="#FFFFFF" ss:Bold="1"/>
   <Interior ss:Color="#99CCFF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s26">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s27">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s29">
   <Alignment ss:Vertical="Center"/>
   <Font x:Family="Swiss" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s30">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Font ss:Size="14" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s31">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font x:Family="Swiss" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s34">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Reporting">
  <Table>
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
    <Cell ss:MergeAcross="3" ss:StyleID="s30"><Data ss:Type="String">Reporting</Data></Cell>
   </Row>
   <Row>
	<Cell ss:MergeAcross="3" ss:StyleID="s34"><ss:Data ss:Type="String"
      xmlns="http://www.w3.org/TR/REC-html40">Từ ngày <B><xsl:value-of select="/root/header/tungay"/></B><Font> đến ngày </Font><B> <xsl:value-of select="/root/header/denngay"/></B></ss:Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:StyleID="s24"><Data ss:Type="String">Staff Memeber Report</Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="s25"><Data ss:Type="String">User Id</Data></Cell>
    <Cell ss:StyleID="s25"><Data ss:Type="String">Account Name</Data></Cell>
    <Cell ss:StyleID="s25"><Data ss:Type="String">Số lượng</Data></Cell>
    <Cell ss:StyleID="s25"><Data ss:Type="String">Thành tiền</Data></Cell>
   </Row>
    <xsl:apply-templates select="/root/data/row"/>
    <xsl:apply-templates select="/root/summary"/>
  </Table>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
<Row>
	<Cell ss:StyleID="s26"><Data ss:Type="String"><xsl:value-of select="./uid"/></Data></Cell>
    <Cell ss:StyleID="s26"><Data ss:Type="String"><xsl:value-of select="./name"/></Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="Number"><xsl:value-of select="./soluong"/></Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="Number"><xsl:value-of select="./thanhtien"/></Data></Cell>
</Row>
</xsl:template>
<xsl:template match="summary">
 <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:MergeAcross="1" ss:StyleID="s31"><Data ss:Type="String">Tổng cộng :</Data></Cell>
    <Cell ss:StyleID="s29"><Data ss:Type="Number"><xsl:value-of select="./soluong"/></Data></Cell>
    <Cell ss:StyleID="s29"><Data ss:Type="Number"><xsl:value-of select="./thanhtien"/></Data></Cell>
   </Row>
</xsl:template>

</xsl:stylesheet>