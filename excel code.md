# Aggregate the specific data



## Aggregate the specific data

- Usage

  - Take the data of specific date, ex. Take the monthly average of time series in table 

- Code: 

  - Assuming you have the months in column D enter this formula in E2 and copy till last month

  - ```
    =AVERAGEIFS($B$1:$B$62,$A$1:$A$62,">="&D2,$A$1:$A$62,"<="&EOMONTH(D2,0))
    ```

    
    
    
    
    

