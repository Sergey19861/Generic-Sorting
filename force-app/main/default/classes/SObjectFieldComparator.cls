/**
 * Created by Sergey Krivorotov.
 */

public with sharing class SObjectFieldComparator extends CustomComparator {
//compare date, strings, numbers, or throw
    private SObjectField field;

    public SObjectFieldComparator(SObjectField field, SortDirection sortDirection) {
        super(sortDirection);
        this.field = field;
    }

    public override Integer compare(Object obj1, Object obj2) {
        SObject sobj1 = (SObject) obj1;
        SObject sobj2 = (SObject) obj2;
        Integer result;
        DisplayType fieldType = field.getDescribe().getType();
        if (fieldType == DisplayType.INTEGER) {
            result = compareNumbers((Integer)sobj1.get(field), (Integer)sobj2.get(field));
        } else if (fieldType == DisplayType.DOUBLE) {
            result = compareNumbers((Double)sobj1.get(field), (Double)sobj2.get(field));
        } else if (fieldType == DisplayType.DATE) {
            result = compareDates((Date)sobj1.get(field), (Date)sobj2.get(field));
        } else if (fieldType == DisplayType.DATETIME) {
            result = compareDateTimes((Datetime)sobj1.get(field), (Datetime)sobj2.get(field));
        } else if (fieldType == DisplayType.STRING) {
            result = compareStrings((String)sobj1.get(field), (String)sobj2.get(field));
        } else {
            throw new CustomComparatorException();
        }
        return applyDirection(result);
    }
}