less:

When defining a variable twice, the last definition of the variable is used, searching from the current scope upwards. 


The & operator represents the parent selectors of a nested rule and is most commonly used when applying a modifying class or pseudo-class to an existing selector:

```
a {
  color: blue;
  &:hover {
    color: green;
  }
}
```


