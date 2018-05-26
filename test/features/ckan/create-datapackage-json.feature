@draft @v0.2.0

Feature: Create new Data Package JSON using CKAN
  As a Data Publisher  
  I want to create a datapackage.json file from the dataset, resources and metadata I have added to CKAN for the first time  
  So that data consumers can use [Frictionless Data software](https://frictionlessdata.io/software/) to work with the data  

  RULES
  =====
  
  - The datapackage.json file should be the same regardless of how that the data is added to CKAN (i.e. via user interface or API)
  - The [Data Package](https://frictionlessdata.io/specs/data-package/) follows v1.0 of the specification
  - The datapackage.json contains:
    - [data package](https://frictionlessdata.io/specs/data-package/) metadata properties converted, derived, or defaulted  from the CKAN dataset metadata using the [data package mapping](https://app.cucumber.pro/projects/ckan-data-curator-integration/documents/branch/master/test/features/metadata-mapping.md#data-package-mapping)
    - [data resource](https://frictionlessdata.io/specs/data-resource/) metadata properties converted, derived, or defaulted from the CKAN resource metadatausing the [data resource mapping](https://app.cucumber.pro/projects/ckan-data-curator-integration/documents/branch/master/test/features/metadata-mapping.md#data-resource-mapping)
  - The datapackage.json does not contain:
    - [table schemas](https://frictionlessdata.io/specs/table-schema/)
    - [CSV dialects](https://frictionlessdata.io/specs/csv-dialect/) in-line 
    - non-data resources such as README.md or README.txt files
  
  QUESTIONS
  =========
  
  - How do you determine if a resource is/isn't a data resource?
  - How are additional CKAN metadata properties handled - drop or include?
  
  NOTES
  =====
  
  - In docs, see [Publish a data package to CKAN for the first time](https://github.com/ODIQueensland/ckan-data-curator-integration/tree/master/docs#2-publish-a-data-package-to-ckan-for-the-first-time)

  Scenario: Create new data package JSON using CKAN
    Given a dataset has been published in CKAN
    And one or more resources have been published with the dataset
    When I invoke "Download Data Package" 
    Then a datapackage.json file should be downloaded
    And the CKAN Dataset metadata properties should be mapped to the Data Package metadata properties in the datapackage.json
    And the CKAN Resource metadata properties should be mapped to the Data Resource metadata properties in the datapackage.json
    And CKAN Resources that are not data should not be included in the datapackage.json
    And CKAN metadata that is not specified in the Frictionless Data specification should not be included as metadata properties in the datapackage.json
