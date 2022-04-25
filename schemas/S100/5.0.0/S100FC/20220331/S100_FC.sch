<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!--
	© Copyright 2022 International Hydrographic Organization (IHO)
	
	License
  Certain parts of the text of this document refer to or are based on the standards of the International
  Organization for Standardization (ISO). The ISO standards can be obtained from any ISO member and from the
  Web site of the ISO Central Secretariat at www.iso.org.
    
  Permission to copy and distribute this document is hereby granted provided that this notice is retained
  on all copies, and that IHO are credited when the material is redistributed or used in part or
	whole in derivative works.
	
  Certain parts of this work are derived from or were originally prepared as works for the UK Location Programme
  (UKLP) and GEMINI project and are (C) Crown copyright (UK). These parts are included under and subject to the
  terms of the Open Government license.

	Disclaimer
	This work is provided without warranty, expressed or implied, that it is complete or accurate or that it
	is fit for any particular purpose.  All such warranties are expressly disclaimed and excluded.
	
	Document history
	Version 5.0.0 2022-03-31	Raphael Malyankar (Portolan Sciences LLC) for S-100 Edition 5.0.0.
    Version 5.0.0 is the first version of this file. The number is set for compatibility with the corresponding edition of S-100.
	-->
<!-- ============================================================================================= -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="5.0.0-20220331">
  <!--<sch:ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>-->
  <!-- S-100 namespaces -->
  <sch:ns prefix="S100FC"   uri="http://www.iho.int/S100FC/5.0"/>
  <sch:ns prefix="S100Base" uri="http://www.iho.int/S100Base/5.0"/>
  <sch:ns prefix="S100CI"   uri="http://www.iho.int/S100CI/5.0"/>
  <sch:ns prefix="S100CD"   uri="http://www.iho.int/S100CD/5.0"/>

  <!-- ISO and OGC namespaces -->
  <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>

<!--
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <sch:ns prefix="gmw" uri="http://standards.iso.org/iso/19115/-3/gmw/1.0"/>
-->
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
<!--  
  <sch:ns prefix="mac" uri="http://standards.iso.org/iso/19115/-3/mac/1.0"/>
  <sch:ns prefix="mas" uri="http://standards.iso.org/iso/19115/-3/mas/1.0"/>
  <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <sch:ns prefix="mdb" uri="http://standards.iso.org/iso/19115/-3/mdb/1.0"/>
  <sch:ns prefix="mex" uri="http://standards.iso.org/iso/19115/-3/mex/1.0"/>
  <sch:ns prefix="mmi" uri="http://standards.iso.org/iso/19115/-3/mmi/1.0"/>
  <sch:ns prefix="mpc" uri="http://standards.iso.org/iso/19115/-3/mpc/1.0"/>
  <sch:ns prefix="mrc" uri="http://standards.iso.org/iso/19115/-3/mrc/2.0"/>
  <sch:ns prefix="mrd" uri="http://standards.iso.org/iso/19115/-3/mrd/1.0"/>
  <sch:ns prefix="mri" uri="http://standards.iso.org/iso/19115/-3/mri/1.0"/>
  <sch:ns prefix="mrl" uri="http://standards.iso.org/iso/19115/-3/mrl/2.0"/>
  <sch:ns prefix="mrs" uri="http://standards.iso.org/iso/19115/-3/mrs/1.0"/>
  <sch:ns prefix="msr" uri="http://standards.iso.org/iso/19115/-3/msr/2.0"/>
  <sch:ns prefix="srv" uri="http://standards.iso.org/iso/19115/-3/srv/2.0"/>
  
  <sch:ns prefix="mds" uri="http://standards.iso.org/iso/19115/-3/mds/1.0"/>
  <sch:ns prefix="md1" uri="http://standards.iso.org/iso/19115/-3/md1/1.0"/>
  <sch:ns prefix="mda" uri="http://standards.iso.org/iso/19115/-3/mda/1.0"/>
  <sch:ns prefix="mdt" uri="http://standards.iso.org/iso/19115/-3/mdt/1.0"/>
  <sch:ns prefix="md2" uri="http://standards.iso.org/iso/19115/-3/md2/1.0"/>
-->
  
<!--
  <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
  <sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
-->
  <!--<sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>-->
  <!--<sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>-->

  <sch:title>IHO S-100 Schematron validation rules for S-100 Feature Catalogues</sch:title>

  <sch:pattern fpi="S100_5.0.5-A.16_permittedValues" >
    <sch:rule context="//S100FC:attributeBinding[S100FC:permittedValues]">
      <sch:let name="ATTR" value="S100FC:attribute/@ref"/>
      <sch:report test="/S100FC:S100_FC_FeatureCatalogue/S100FC:S100_FC_SimpleAttributes/S100FC:S100_FC_SimpleAttribute[(S100FC:code = $ATTR) and ((S100FC:valueType != 'enumeration') and (S100FC:valueType != 'S100_CodeList'))]" role="warning">
        <sch:value-of select="../S100FC:code"/> / <sch:value-of select="S100FC:attribute/@ref"/>: permittedValues applies only to attributes of type enumeration or S100_Codelist
      </sch:report>
    </sch:rule>
  </sch:pattern>




</sch:schema>