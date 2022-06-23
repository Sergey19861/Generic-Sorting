/**
 * Created by Sergey Krivorotov.
 *
 * Compare Person by field defined in constructor.
 */

public with sharing class PersonComparator extends CustomComparator {

    private String fieldName;

    public PersonComparator(String fieldName, SortDirection sortDirection) {
        super(sortDirection);
        this.fieldName = fieldName;
    }

    public override Integer compare(Object obj1, Object obj2) {
        Person person1 = (Person) obj1;
        Person person2 = (Person) obj2;
        Integer result;
        if (this.fieldName == 'firstName') {
            result = compareStrings(person1.firstName, person2.firstName);
        } else if (this.fieldName == 'lastName') {
            result = compareStrings(person1.lastName, person2.lastName);
        } else if (this.fieldName == 'gender') {
            result = compareStrings(person1.gender.name(), person2.gender.name());
        } else if (this.fieldName == 'age') {
            result = compareNumbers(person1.age, person2.age);
        }
        return applyDirection(result);
    }

}