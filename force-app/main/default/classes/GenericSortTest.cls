/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class GenericSortTest {

    @IsTest
    static void testYoungPersonsFirst() {
        List<Person> persons = new List<Person>{
                new Person('Petr','Avakov',Gender.MAN,18),
                new Person('Oleg','Ivanov',Gender.MAN,35),
                new Person('Olesya','Petrova',Gender.WOMAN,16),
                new Person('Olesya','Petrova',Gender.WOMAN,26),
                new Person('Oleg','Ivanovich',Gender.MAN,16),
                new Person('Oleg','Ivanov',Gender.MAN,17)
        };

        new GenericSort()
                .addComparator(new PersonComparator('age', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('gender', SortDirection.DESCENDING))
                .addComparator(new PersonComparator('firstName', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('lastName', SortDirection.DESCENDING))
                .sort(persons);

        System.assertEquals(persons[0].firstName, 'Olesya');
        System.assertEquals(persons[1].gender.name(), Gender.MAN.name());
        System.assertEquals(persons[2].age, 17);
        System.assertEquals(persons[3].lastName, 'Avakov');
        System.assertEquals(persons[4].age, 26);
        System.assertEquals(persons[5].gender.name(), Gender.MAN.name());
    }

    @IsTest
    static void testMenFirst() {
        List<Person> persons = new List<Person>{
                new Person('Petr','Avakov',Gender.MAN,18),
                new Person('Oleg','Ivanov',Gender.MAN,35),
                new Person('Olesya','Petrova',Gender.WOMAN,16),
                new Person('Olesya','Petrova',Gender.WOMAN,26),
                new Person('Oleg','Ivanovich',Gender.MAN,16),
                new Person('Oleg','Ivanov',Gender.MAN,17)
        };

        new GenericSort()
                .addComparator(new PersonComparator('gender', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('firstName', SortDirection.DESCENDING))
                .addComparator(new PersonComparator('lastName', SortDirection.ASCENDING))
                .addComparator(new PersonComparator('age', SortDirection.ASCENDING))
                .sort(persons);

        System.assertEquals(persons[0].firstName, 'Petr');
        System.assertEquals(persons[1].age, 17);
        System.assertEquals(persons[2].age, 35);
        System.assertEquals(persons[3].lastName, 'Ivanovich');
        System.assertEquals(persons[4].gender.name(), Gender.WOMAN.name());
        System.assertEquals(persons[5].age, 26);
    }

}