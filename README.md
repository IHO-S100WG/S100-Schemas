# S100-Schemas
S100 Edition 4.0.0 Schemas uploaded as ZIP file.  See accompanying README docx file for folder organization.

The May 2019 update adds the ID attribute to the generic exchange catalogue schema. It also adds exchange catalogue schemas for S-98, S-101, S-102, S-111, and S-127.

The S-100 Edition 4.0.0 Schemas <em>folder</em> in this branch is now obsolete and awaiting deletion.

2020-04-17: The S-100 4.0.0 schemas zip file has been updated to work around broken links in schemaLocation(s) in ISO schemas. (As of 17 April this fix is only in the FixSchemaLocationLinks branch, it has not been merged with the master.)

## Updated Portrayal schemas
The zip file S100_4_1_0_S100XSLTPR_20191115.zip contains the portrayal files from schemas/S100/4.0.0/S100XSLTPR/ with updates to four files implementing the changes approved at S-100 WG4 (See S-100WG4-4.6, 4.7, and 4.8 for descriptions of the updates). The other files in S100XSLTPR have not been changed in this zip but are included because some of the updated files have import or use dependencies on some of the unchanged files. The S-100 revision number for this zip has been incremented because the proposed changes are extensions to S-100 4.0.0.

## Interoperability schemas
The zip file InteroperabilitySchemasAndSample.zip contains the XML schemas and sample(s) for interoperability as described in the drafts of S-100 Part 16 and S-98. 

The exchange catalog file CATALOG.XML in the sample requires ISO schemas in order to validate, which are not included in this zip. They can be obtained from the S-100 4.0.0 schema distribution zip file on this site.

## XML Catalog
The XMLCatalog.xml file is an "XML Catalog" conforming to the OASIS standard for XML catalogs (URL: https://www.oasis-open.org/standards#xmlcatalogsv1.1), for mapping broken links in the ISO TC211 schemas on standards.iso.org to working links. It can be used with validation tools that implement the XML Catalogs standard. This file works with OxygenXML. The file "CustomCatalog.xml" is an "XML Catalog" for use with Altova XMLSpy. The differences in the two catalog files are minor, and are due to differences in tool behavior.
