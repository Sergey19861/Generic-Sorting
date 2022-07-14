# Salesforce Technical  Design

## Functional Module: Generic Sorting

### Technical Design Specification

#### DOCUMENT INFORMATION AND APPROVALS

***

##### Version History

| Version # |   Date    |      Author       |     Reason for Change     |
|:---------:|:---------:|:-----------------:|:-------------------------:|
|    0.1    | 6.07.2022 | Sergey Krivorotov | Creation of functionality | 


***

### 1. Overview

This functionality is designed to give developers a tool to create different types of Custom Sort logic.

- **Purpose and Audience**

This functionality is designed to simplify and generalize the creation and execution of Custom Sort logic.

- **Supporting Project References**

[Git Hub](https://github.com/Sergey19861/Generic-Sorting)

***

### 2. Business UseCase
- The project has a class that shows how to sort Persons by different criteria.

***

### 3. Design Overview

- **Entity Relationship Diagram**

  ![Project Diagram](/images/GenericSortingDiagram.jpg)

***

### 4. Objects Definition and Configuration

- **Picklist Value Set**

No new global picklists were introduced to implement this feature.

- **Standard Objects**

No changes have been delivered for this implementation

- **Custom Objects**

No new Custom Objects were introduced to implement this feature.

***

### 5. Security Setup

- **Profiles**

There are no new profiles introduced for this feature.

- **Permission Sets**

| Permission Set | License Type |        Description (Access and assignment)        |
|:--------------:|:------------:|:-------------------------------------------------:|
|  Generic Sort  |     None     | Uses to give access to Generic Sort functionality |

- **Sharing Settings**

No changes in sharing setting related to any object as part of this feature.

***

### 6. User experience

To use this functionality, extend the CustomComparator class then override compare(Object obj1, Object obj2) method with your logic inside.

***

### 7. Standard Setup Configurations

- **List View Change**

There are no new List View introduced for this feature.

***

### 8. Custom Setup Configurations

There are no new Custom Setup Configurations introduced for this feature.

***

### 9. Apex Business Logic

| Name                   | Type            | Description                                                                                   |
|:-----------------------|:----------------|:----------------------------------------------------------------------------------------------|
| CustomComparator       | Apex Class      | Parent class for all Comparators. Extend this class to implement Comparators for GenericSort. | 
| Gender                 | Enum            | Created to store values to Gender.                                                            |
| GenericSort            | Apex Class      | Used for setup sorting process and sort.                                                      |
| GenericSortTest        | Unit Test Class | Contains test logic for GenericSort.                                                          |
| GenericSortWrapper     | Apex Class      | Designed to adapt custom compare logic with built-in Salesforce sort logic.                   |
| Person                 | Apex Class      | Designed to store information about Person.                                                   |
| PersonComparator       | Apex Class      | Compare Persons by field defined in constructor.                                              |
| SObjectFieldComparator | Apex Class      | Compare SObjects by field defined in constructor.                                             |
| SortDirection          | Enum            | Created to store values to Sort Direction.                                                    |

***

### 10. Lightning Components

No new Lightning Components were introduced to implement this feature.

***

### 11. Destructive Changes

List of classes, components, fields, objects, rule and other entities which were deleted during work on Epic/Feature.

***

### 12. Review and Sign Off

- **DOCUMENT REVIEWS**


- **DOCUMENT APPROVALS**
 
