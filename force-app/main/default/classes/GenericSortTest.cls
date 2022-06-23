/**
 * Created by Sergey Krivorotov.
 */

@IsTest
private class GenericSortTest {

    @TestSetup
    static void setup() {
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(
                LastName = 'Safonov',
                Birthdate = Date.newInstance(1996, 12, 12),
                Age__c = 26,
                Weight__c = 104.5,
                DoNotCall = true
        ));
        contacts.add(new Contact(
                LastName = 'Krivorotov',
                Birthdate = Date.newInstance(1986, 12, 12),
                Age__c = 36,
                Weight__c = 84.5,
                DoNotCall = false
        ));
        contacts.add(new Contact(
                LastName = 'Morozov',
                Birthdate = Date.newInstance(1986, 12, 12),
                Age__c = 38,
                Weight__c = 104.5,
                DoNotCall = true
        ));
        contacts.add(new Contact(
                LastName = 'Nikitin',
                Birthdate = Date.newInstance(1984, 12, 12),
                Age__c = 38,
                Weight__c = 80.45,
                DoNotCall = false
        ));
        contacts.add(new Contact(
                LastName = 'Makarov',
                Birthdate = Date.newInstance(1984, 12, 12),
                Age__c = 36,
                Weight__c = 104.5,
                DoNotCall = true
        ));
        contacts.add(new Contact(
                LastName = 'Safonov',
                Birthdate = Date.newInstance(1984, 12, 12),
                Age__c = 36,
                Weight__c = 74.5,
                DoNotCall = false
        ));
            insert contacts;
    }

    @IsTest
    static void testSObjectComparatorUnsupportedType() {
        List<Contact> contacts = [SELECT LastName, Age__c, DoNotCall FROM Contact];
        String errorMessage = '';
        try {
            new GenericSort()
                    .addComparator(new SObjectFieldComparator(Contact.DoNotCall, SortDirection.ASCENDING))
                    .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.DESCENDING))
                    .sort(contacts);
        } catch (CustomComparator.CustomComparatorException e) {
            errorMessage = e.getMessage();
        }
        System.assert(errorMessage.length() > 0);
    }

    @IsTest
    static void testSObjectComparatorIntegerType() {
        List<Contact> contacts = [SELECT LastName, Age__c FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Age__c, SortDirection.ASCENDING))
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.DESCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].Age__c, 26);
        System.assertEquals(contacts[contacts.size() - 1].LastName, 'Morozov');
    }

    @IsTest
    static void testSObjectComparatorDateType() {
        List<Contact> contacts = [SELECT LastName, Birthdate FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Birthdate, SortDirection.DESCENDING))
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.ASCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].Birthdate, Date.newInstance(1996, 12, 12));
        System.assertEquals(contacts[contacts.size() - 1].LastName, 'Safonov');
    }

    @IsTest
    static void testSObjectComparatorDoubleType() {
        List<Contact> contacts = [SELECT LastName, Weight__c, Birthdate FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.Weight__c, SortDirection.DESCENDING))
                .addComparator(new SObjectFieldComparator(Contact.Birthdate, SortDirection.ASCENDING))
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.ASCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].LastName, 'Makarov');
        System.assertEquals(contacts[0].Weight__c, 104.5);
        System.assertEquals(contacts[1].LastName, 'Morozov');
        System.assertEquals(contacts[contacts.size() - 1].Weight__c, 74.5);
    }

    @IsTest
    static void testSObjectComparatorStringType() {
        List<Contact> contacts = [SELECT LastName, Age__c FROM Contact];
        new GenericSort()
                .addComparator(new SObjectFieldComparator(Contact.LastName, SortDirection.ASCENDING))
                .addComparator(new SObjectFieldComparator(Contact.Age__c, SortDirection.DESCENDING))
                .sort(contacts);

        System.assertEquals(contacts[0].LastName, 'Krivorotov');
        System.assertEquals(contacts[3].LastName, 'Nikitin');
        System.assertEquals(contacts[3].Age__c, 38);
        System.assertEquals(contacts[5].LastName, 'Safonov');
        System.assertEquals(contacts[5].Age__c, 26);
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