/**
 * Created by Sergey Krivorotov.
 */

public with sharing class Person {
    public String firstName;
    public String lastName;
    public Gender gender;
    public Integer age;

    public Person(
            String firstName,
            String lastName,
            Gender gender,
            Integer age
    ) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.age = age;
    }

}