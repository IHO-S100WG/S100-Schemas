<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" schemaVersion="5.0.0-20220331">
<!-- ================================================================================ -->
<!-- Schematron validation for S-100 interoperabilty catalogue. 			     	  -->
<!-- ================================================================================ -->
    
<!--
© Copyright 2016-2019, 2022
Prepared under contract for NOAA (Original & 2019 update), IHO (2022 update)

License (Draft)
Certain parts of this document refer to or are based on the standards, documents, schemas,
or other material of the International Organization for Standardization (ISO), Open Geospatial
Consortium (OGC), International Hydrographic Organization / Organisation Hydrographique
Internationale (IHO/OHI).
The ISO material can be obtained from any ISO member and from the Web site of the ISO Central
Secretariat at www.iso.org.
The OGC material can be obtained from the OGC Web site at www.opengeospatial.org.
The IHO material can be obtained from the IHO Web site at www.iho.int or from the International
Hydrographic Bureau.

Permission to copy and distribute this document is hereby granted provided that this notice is
retained on all copies, and that IHO, NOAA, C-Map are credited when the material is redistributed
or used in part or whole in derivative works.
Redistributions in binary form must reproduce this notice in the documentation and/or other
materials provided with the distribution.

Disclaimer
This work is provided by the copyright holders and contributors "as is" and any express or implied
warranties, including, but not limited to, the implied warranties of merchantability and fitness
for a particular purpose are disclaimed. In no event shall the copyright owner or contributors be
liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including,
but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or
business interruption) however caused and on any theory of liability, whether in contract, strict
liability, or tort (including negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.

Document history
Version 1.1	2016-07-21	Raphael Malyankar (C-MAP) for NOAA / IIC Technologies
Version 0.1-2017-07-31  Raphael Malyankar. Version number changed to conform to IC specification
    Rules updated to conform to changes to the IC model
Ver. 0.2-201712-12  Raphael Malyankar. Version number updated to conform to XSD 0.2. No changes to Schematron rules.
Ver. 0.3 Build 20180702 Raphael Malyankar. updated to harmonize with S-100 Ed. 4.0.0. Removed 19139 ISO namespaces
            since they are not referenced in any rules.
    1.0.0 Build 20190331 RMM Added check for duplicated product specifications in includedProduct elements of
        predefined combinations and updated schemaversion
    5.0.0 Build 202203331 Version numbering and namespace updated to conform to S-100 5.0.0
-->

    <sch:ns uri="http://www.iho.int/S100/IC/5.0" prefix="S100IC"/>

    <sch:title>IHO S-100 Schematron validation rules for S-100 Interoperability Catalogues</sch:title>

    <xsl:key name="RULE_IDENTIFIER" match="/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules/*" use="ruleIdentifier"/>
    
    <sch:pattern fpi="Level_Rule_Check_1">
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination/derivedFeatures/S100_IC_HybridFeature">
            <sch:let name="level" value="../../interoperabilityLevel"/>
            <sch:let name="crRuleType" value="local-name(key('RULE_IDENTIFIER', creationRule))"/>
            <sch:assert test="($level = 3 and ($crRuleType = 'S100_IC_ThematicRule' or $crRuleType = 'S100_IC_SimpleRule')) or ($level = 4)">
                Rule '<sch:value-of select="creationRule"/>' referenced in <sch:name/> <sch:value-of select="@id"/> (PDC <sch:value-of select="../../name"/>): <sch:value-of select="$crRuleType"/> is not compatible with level <sch:value-of select="$level"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="Level_Rule_Check_2">
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination[interoperabilityLevel = 2]">
            <sch:assert test="empty(derivedFeatures/*)">
                Content of PDC <sch:value-of select="name"/> is incompatible with level 2
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="Feature_Geometry_Check_1">
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/displayPlanes/S100_IC_DisplayPlane/features/S100_IC_Feature/geometryType">
            <sch:let name="gv" value="text()"></sch:let>
            <sch:assert test="not($gv = 'arcByCenterPoint') and not($gv = 'circleByCenterPoint')">
                Content of feature class geometry is <sch:value-of select="$gv"/> in <sch:name/>, feature ID <sch:value-of select="../identifier"/>, display plane ID <sch:value-of select="../../../identifier"/>, but cannot be 'arcByCenterPoint' or 'circleByCenterPoint' in Edition 4.0 features
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="DI_Geometry_Check_1">
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/displayPlanes/S100_IC_DisplayPlane/drawingInstructions/S100_IC_DrawingInstruction/geometryType" role="warn">
            <sch:let name="gv" value="text()"></sch:let>
            <sch:report test="($gv = 'arcByCenterPoint') or ($gv = 'circleByCenterPoint')">
               Warning: Content of drawing instruction geometry is <sch:value-of select="$gv"/> in <sch:name/>, drawing instruction ID <sch:value-of select="../identifier"/>, display plane ID <sch:value-of select="../../../identifier"/>
            </sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Check that the specifications listed in a predefined product combination are distinct -->
    <sch:pattern fpi="S98.pdcproducts">
        <sch:title>Check listed data products for duplication</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination/includedproduct">
            <sch:let name="PRODNAME" value="string()"/>
            <sch:assert test="count(../includedProduct[text() = $PRODNAME]) + count(../includedProduct[substring-after(text(), 'other: ') = $PRODNAME]) &lt; 2">
                Duplicate product in predefined combination element: <sch:value-of select="$PRODNAME"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

</sch:schema>