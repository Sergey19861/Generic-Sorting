/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class GenericSortTest {

    @TestSetup
    static void setup() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 20; i++) {
            contacts.add(new Contact(FirstName = 'Contact ' + i,
                    LastName = 'TestContact ' + i,
                    Birthdate = Date.newInstance(1980 + i, 12, 12),
                    Age__c = 42 - i,
                    Weight__c = 85.34 - i
            ));
        }
            contacts.add(new Contact(FirstName = 'Vitaliy',
                    LastName = 'Safonov',
                    Birthdate = Date.newInstance(1996, 12, 12),
                    Age__c = 26,
                    Weight__c = 104.5
            ));
        contacts.add(new Contact(FirstName = 'Sergey',
                LastName = 'Krivorotov',
                Birthdate = Date.newInstance(1986, 12, 12),
                Age__c = 36,
                Weight__c = 104.5
        ));
            insert contacts;
    }

    @IsTest
    static void testSObjectComparatorStringType() {
        List<Contact> contacts = [SELECT LastName, Age__c FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.ASCENDING))
                .addComparator(new SObjectFieldComparator(Contact.Age__c, SortDirection.DESCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].LastName, 'Krivorotov');
        System.assertEquals(contacts[1].Age__c, 26);
    }

    @IsTest
    static void testSObjectComparatorDoubleType() {
        List<Contact> contacts = [SELECT LastName, Weight__c, Birthdate FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Weight__c, SortDirection.DESCENDING))
                .addComparator(new SObjectFieldComparator(Contact.Birthdate, SortDirection.ASCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].LastName, 'Krivorotov');
        System.assertEquals(contacts[0].Weight__c, 104.5);
        System.assertEquals(contacts[1].LastName, 'Safonov');
        System.assertEquals(contacts[contacts.size() - 1].Weight__c, 66.34);
    }

    @IsTest
    static void testSObjectComparatorDateType() {
        List<Contact> contacts = [SELECT LastName, Birthdate FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Birthdate, SortDirection.DESCENDING))
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.ASCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].Birthdate, Date.newInstance(1999, 12, 12));
        System.assertEquals(contacts[contacts.size() - 1].LastName, 'TestContact 0');
    }

    @IsTest
    static void testSObjectComparatorIntegerType() {
        List<Contact> contacts = [SELECT LastName, Age__c FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Age__c, SortDirection.ASCENDING))
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.DESCENDING))
                .sort(contacts);

        for (Contact con : contacts) {
            System.debug(con);
        }

        System.assertEquals(contacts[1].Age__c, 24);
        System.assertEquals(contacts[contacts.size() - 1].LastName, 'TestContact 0');
    }

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