/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class GenericSortTest {

    @IsTest
    static void testBehavior() {
        List<Person> persons = new List<Person> {
                new Person('Sergey', 'Ivanov', 'm', 25),
                new Person('Alex', 'Petrov', 'm', 32),
                new Person('Egor', 'Gorbuniv', 'm', 15),
                new Person('Viktor', 'Ivanov', 'm', 26)
        };

        new GenericSort()
                .addComparator(new PersonComparator('firstName', 1))
                .addComparator(new PersonComparator('lastName', 1))
                .sort(persons);

        System.assertEquals(persons[0].firstName, 'Alex');

        //add Enum
    }
}