<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!-- Schematron rules for ISO 19115+Cor.1 / ISO 19139 metadata for individual dataset files        -->
<!-- ============================================================================================= -->

<!--
	© Copyright 2015 ... (Draft - Copyright statement tbd)
	Prepared under NOAA contract/sub-contract.

  Certain parts of the text of this document refer to or are based on the standards of the International
  Organization for Standardization (ISO). The ISO standards can be obtained from any ISO member and from the
  Web site of the ISO Central Secretariat at www.iso.org.

	Certain parts of this work are derived from or were originally prepared as works for the UK Location Programme
  (UKLP) and GEMINI project and are (C) Crown copyright (UK). These parts are included under and subject to the
  terms of the Open Government license.

  Permission to copy and distribute this work is hereby granted provided that this notice and the notice for the
  GEMINI and UKLP programs included below are retained on all copies, and that IHO & NOAA are credited when the
  material is redistributed or used in part or whole in derivative works.
  Redistributions in binary form must reproduce this notice and the notice for the GEMINI/UKLP program in the
  documentation and/or other materials provided with the distribution.

	Disclaimer	(Draft)
  This work is provided by the copyright holders and contributors "as is" and any express or implied warranties,
  including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose
  are disclaimed. In no event shall the copyright owner or contributors be liable for any direct, indirect,
  incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute
  goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of
  liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way
  out of the use of this software, even if advised of the possibility of such damage.
	
	Document history
	Version 1.0	2015-08-18	Raphael Malyankar (Jeppesen) for NOAA / IIC Technologies / IHO
  Version 1.1 2015-08-21  Updated copyright/license/disclaimer notice.
  3.0.0-20170430  Raphael Malyankar schema version number convention now <S-100 version>-<file build date (YYYYMMDD)>
  4.0.0-20180502  Raphael Malyankar Updated for 4.0.0. The 19115-3 distribution from ISO includes .sch files in some folders.
    The ISO .sch files have not been tested as of 2018-06-11.
    Does not include imagery and gridded information metadata checks.
    Scope of this file is limited to metadata encoded with mdb:MD_Metadata
-->
<!--
    Notes:
    (1) These rules are intended for a standalone dataset discovery metadata file and would have to be adapted
        if discovery metadata is embedded in the exchange catalogue.
    (2) Written for xslt1 as least common denominator; discuss if use of XSLT 2 is acceptable.
    (3) Allows for derivations of MD_Metadata (with the isoType attribute) but not derivations of its sub-elements,
        this will have to be updated if derivations of sub-elements are used.
-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="4.0.0-20180502">
  <sch:ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>
  <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
  <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
  <sch:ns prefix="mas" uri="http://standards.iso.org/iso/19115/-3/mas/1.0"/>
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <sch:ns prefix="mdb" uri="http://standards.iso.org/iso/19115/-3/mdb/2.0"/>
  <sch:ns prefix="mri" uri="http://standards.iso.org/iso/19115/-3/mri/1.0"/>
  <sch:ns prefix="gmi" uri="http://standards.iso.org/iso/19115/-2/gmi/1.0"/>
  <sch:ns prefix="mex" uri="http://standards.iso.org/iso/19115/-3/mex/1.0"/>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>

  <sch:title>IHO S-100 additional Schematron validation rules</sch:title>

  <sch:p>Supplements ISO validation</sch:p>

  <!-- Rule to test that fileIdentifier is present and encoded as a characterString of length > 0 -->
  <sch:pattern fpi="S100_2.0.0_Table4a-2_R1">
    <sch:title>Rule for mandatory MD_Metadata.fileIdentifier</sch:title>
    <sch:rule context="/mdb:MD_Metadata | /*[gco:isoType='mdb:MD_Metadata']">
      <sch:assert test="mdb:metadataIdentifier and (count(mdb:metadataIdentifier/@gco:nilReason) = 0)">
        A metadataIdentifier element is mandatory in S-100 and cannot be nilled.
      </sch:assert>
    </sch:rule>
    <sch:rule context="/mdb:MD_Metadata/mdb:metadataIdentifier | /*[gco:isoType='mdb:MD_Metadata']/mdb:metadataIdentifier">
      <sch:assert test="string-length(normalize-space()) > 0">Metadata identifier element <sch:name/> must not be empty.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- The rule for language permits either a gco:CharacterString or a lan:LanguageCode entry -->
  <sch:pattern fpi="S100_MD_language">
    <sch:title>Rule to check that MD_Metadata.language is not empty</sch:title>
    <sch:rule context="/mdb:MD_Metadata//lan:language | /*[gco:isoType='mdb:MD_Metadata']//lan:language">
      <sch:assert test="lan:LanguageCode[(string-length(normalize-space(@codeList)) > 0) and (string-length(@codeListValue) > 0)]
                       | gco:CharacterString[string-length(normalize-space()) > 0]">
        If the element lan:language is present its content must be a non-empty gco:CharacterString or a LanguageCode from the ISO 19139 codelists.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule to check that MD_Metadata.contact is not nilled and has at least one of organisation name, individual
        name, or positionName elements.
        NOTE: This rule checks only MD_Metadata.contact, not "contact" elements under other elements like resourceSpecificUsage.
        S-100 does not state that this requirement applies in other possible locations of "contact". 
  -->
  <sch:pattern fpi="S100_2.0.0_Table4a-2_R5">
    <sch:title>Contact information presence test</sch:title>
    <sch:rule context="/mdb:MD_Metadata/mdb:contact |/*[gco:isoType='mdb:MD_Metadata']/mdb:contact">
      <sch:assert test="count(@gco:nilReason) = 0">Contact is not nillable.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- rule to check for presence of title in identificationInfo elements -->
  <sch:pattern fpi="S100_2.0.0_Table4a-2_R9-11">
    <sch:title>Dataset title, reference date, and abstract presence test</sch:title>
    <sch:p>This pattern checks the presence of title, date and abstract even if a citation element is (wrongly) nilled.</sch:p>
    <sch:p>Absence of identificationInfo is permitted</sch:p>
    <sch:rule context="/mdb:MD_Metadata | /*[gco:isoType='mdb:MD_Metadata']">
      <sch:assert test="mdb:identificationInfo/mri:MD_DataIdentification/mri:citation/cit:CI_Citation/cit:title">
        MD_Metadata/MD_identificationInfo/MD_DataIdentification.citation/CI_Citation.title is required
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Rules to test validity of bounding box coordinates (if any) in extent elements. Assumes lat/lon in decimal degrees, ranges +/-90.0 and +/-180.0. -->
  <sch:pattern is-a="S100_ValidBBoxPattern">
    <sch:title>Validity of bounding box corners</sch:title>
    <sch:param name="bbox" value="//mri:extent/gex:EX_Extent/gex:geographicElement/gex:EX_GeographicBoundingBox"></sch:param>
  </sch:pattern>
  
  <sch:pattern id="S100_ValidBBoxPattern" abstract="true" fpi="S100_BBox_LLDD_MinMax">
    <sch:title>Check the values of the bounding box min/max. Assumes values are latitude and longitude in decimal degrees in +/-90 or +/-180 range respectively.</sch:title>
    <sch:rule context="$bbox">
      <sch:assert test="gex:westBoundLongitude and (string-length(gex:westBoundLongitude) > 0) and (gex:westBoundLongitude >= -180.0) and (gex:westBoundLongitude &lt;= 180.0)" flag="badWB">
        westBoundLongitude must be present and in the range [-180.0, 180.0].
      </sch:assert>
      <sch:assert test="gex:eastBoundLongitude and (string-length(gex:eastBoundLongitude) > 0) and (gex:eastBoundLongitude >= -180.0) and (gex:eastBoundLongitude &lt;= 180.0)" flag="badEB">
        eastBoundLongitude must be present and in the range [-180.0, 180.0].
      </sch:assert>
      <sch:assert test="gex:southBoundLatitude and (string-length(gex:southBoundLatitude) > 0) and (gex:southBoundLatitude >= -90.0) and (gex:southBoundLatitude &lt;= 90.0)" flag="badSB">
        southBoundLatitude must be present and in the range [-90.0, 90.0].
      </sch:assert>
      <sch:assert test="gex:northBoundLatitude and (string-length(gex:northBoundLatitude) > 0) and (gex:northBoundLatitude >= -90.0) and (gex:northBoundLatitude &lt;= 90.0)" flag="badNB">
        northBoundLatitude must be present and in the range [-90.0, 90.0].
      </sch:assert>
      <sch:assert test="not(badEB or badWB) and (gex:westBoundLongitude &lt; gex:eastBoundLongitude)">
        westBoundLongitude (<sch:value-of select="gex:westBoundLongitude"/>) must be less than eastBoundLongitude (<sch:value-of select="gex:eastBoundLongitude"/>)
      </sch:assert>
      <sch:assert test="not(badNB or badSB) and (gex:southBoundLatitude &lt; gex:northBoundLatitude)">
        northBoundLatitude (<sch:value-of select="gex:northBoundLatitude"/>) must be greater than southBoundLatitude (<sch:value-of select="gex:southBoundLatitude"/>)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- ========================================================================================== -->
  <!-- The following rule is from the Schematron Schema for the UK GEMINI Standard Version 2.1 and
        is included under the licence terms below:
        (C) Crown copyright, 2011
        You may use and re-use the information in this publication (not including logos) free of charge
        in any format or medium, under the terms of the Open Government Licence.
        Adapted for 19115-3 by RMM (201806-14). To do: check if the ISO-provided Schematron files include this.
  -->
  <!-- ========================================================================================== -->
  <sch:pattern fpi="Gemini2-at5">
    <sch:title>Creation date type</sch:title>
    <sch:p>Constrain citation date type = creation to one occurrence.</sch:p>
    <sch:rule context="//cit:CI_Citation | //*[@gco:isoType='cit:CI_Citation'][1]">
      <sch:assert test="count(cit:date/*[1]/cit:dateType/*[1][@codeListValue='creation']) &lt;= 1">
        There shall not be more than one creation date.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- End of extract from UK GEMINI Standard Version 2.1  -->
</sch:schema>