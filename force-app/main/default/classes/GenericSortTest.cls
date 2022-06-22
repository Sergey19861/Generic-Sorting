/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class GenericSortTest {

    @IsTest
    static void testBehavior() {
        List<Person> persons = new List<Person> {
                new Person('Sergey', 'Ivanov', Gender.MAN, 25),
                new Person('Alex', 'Petrov', Gender.MAN, 32),
                new Person('Egor', 'Gorbuniv', Gender.MAN, 15),
                new Person('Viktor', 'Ivanov', Gender.MAN, 26),
                new Person('Alex', 'Aleksandro', Gender.MAN, 26),
                new Person('Alex', 'Aleksandro', Gender.WOMAN, 26),
                new Person('Alex', 'Aleksandro', Gender.WOMAN, 16)
        };

        new GenericSort()
                .addComparator(new PersonComparator('firstName', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('lastName', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('gender', SortDirection.DESCENDING))
                .addComparator(new PersonComparator('age', SortDirection.DESCENDING))
                .sort(persons);

        System.assertEquals(persons[0].firstName, 'Alex');
        System.assertEquals(persons[0].lastName, 'Aleksandro');
        System.assertEquals(persons[2].gender.name(), Gender.MAN.name());
        System.assertEquals(persons[0].gender.name(), Gender.WOMAN.name());
        System.assertEquals(persons[1].age, 16);
        System.assertEquals(persons[0].age, 26);
    }

}