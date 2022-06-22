/**
 * Created by Sergey Krivorotov.
 */

public abstract class CustomComparator {

     private SortDirection sortingDirection;

     public CustomComparator(SortDirection sortDirection) {
          this.sortingDirection = sortDirection;
     }

     public abstract Integer compare(Object obj1, Object obj2);

     protected Integer compareStrings(String str1, String str2) {
          if (str1 > str2) return 1;
          if (str1 < str2) return -1;
          return 0;
     }

     protected Integer compareNumbers(Decimal num1, Decimal num2) {
          if (num1 > num2) return 1;
          if (num1 < num2) return -1;
          return 0;
     }

     protected Integer compareDates(Date date1, Date date2) {
          if (date1 > date2) return 1;
          if (date1 < date2) return -1;
          return 0;
     }

     protected Integer compareDateTimes(Datetime date1, Datetime date2) {
          if (date1 > date2) return 1;
          if (date1 < date2) return -1;
          return 0;
     }

     protected Integer applyDirection(Integer compareResult) {
          return sortingDirection == SortDirection.DESCENDING ? compareResult * -1 : compareResult;
     }

     public class CustomComparatorException extends Exception {

     }
}