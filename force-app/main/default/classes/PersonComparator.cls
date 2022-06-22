/**
 * Created by Sergey Krivorotov.
 */

public with sharing class PersonComparator implements CustomComparator {

    private String fieldName;
    private SortDirection sortDirection;

    public PersonComparator(String fieldName, SortDirection sortDirection) {
        this.fieldName = fieldName;
        this.sortDirection = sortDirection;
    }
//TO DO add sortDirection
    public Integer compare(Object obj1, Object obj2) {
        Person person1 = (Person) obj1;
        Person person2 = (Person) obj2;
        Integer result;
        if (this.fieldName == 'firstName') {
            if (person1.firstName > person2.firstName) result = 1;
            else if (person1.firstName == person2.firstName) result = 0;
            else result = -1;
        } else if (this.fieldName == 'lastName') {
            if (person1.lastName > person2.lastName) result = 1;
            else if (person1.lastName == person2.lastName) result = 0;
            else result = -1;
        } else if (this.fieldName == 'gender') {
            if (person1.gender.name() > person2.gender.name()) result = 1;
            else if (person1.gender.name() == person2.gender.name()) result = 0;
            else result = -1;
        }

        if (sortDirection.name() == 'DESCENDING') return result * -1;

        return result;
    }

}