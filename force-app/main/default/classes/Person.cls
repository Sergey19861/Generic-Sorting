/**
 * Created by Sergey Krivorotov.
 */

public with sharing class Person {
    public String firstName;
    public String lastName;
    public String gender;
    public Integer age;

    public Person(
            String firstName,
            String lastName,
            String gender,
            Integer age
    ) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.age = age;
    }

}