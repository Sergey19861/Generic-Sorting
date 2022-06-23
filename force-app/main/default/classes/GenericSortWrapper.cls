/**
 * Created by Sergey Krivorotov.
 *
 * Designed to adapt custom compare logic with built-in Salesforce sort logic.
 */

public with sharing class GenericSortWrapper implements Comparable {

    public Object obj;
    public List<CustomComparator> comparatorsList;

    public GenericSortWrapper(Object obj, List<CustomComparator> comparatorsList) {
        this.obj = obj;
        this.comparatorsList = comparatorsList;
    }

    public Integer compareTo(Object compareTo) {
        for (CustomComparator comparator : comparatorsList) {
            Integer result = comparator.compare(obj, ((GenericSortWrapper) compareTo).obj);
            if (result != 0) return result;
        }
        return 0;
    }
}