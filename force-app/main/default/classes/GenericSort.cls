/**
 * Created by Sergey Krivorotov.
 */

public with sharing class GenericSort {

    public List<CustomComparator> comparatorsList;

    public GenericSort() {
        comparatorsList = new List<CustomComparator>();
    }

    public void sort(List<Object> objects) {
        List<GenericSortWrapper> wrappers = new List<GenericSortWrapper>();
        for (Object obj : objects) wrappers.add(new GenericSortWrapper(obj, comparatorsList));
        wrappers.sort();
        for(Integer i = 0; i < wrappers.size(); i++) objects[i] = wrappers[i].obj;
    }

    public GenericSort addComparator(CustomComparator comparator) {
        this.comparatorsList.add(comparator);
        return this;
    }

}