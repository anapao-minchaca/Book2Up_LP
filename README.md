# Project: Book2 Up
<p align="center">
  <img src="logo.png" alt="book2up"/>
</p>

## Team
* *Karen Isabel Morgado Castillo A01027446 [CSF]*
* *Ana Paola Minchaca García A01026744 [CSF]*

## Problem description 
Managing inventory is a daunting task. Nowadays there are business that are not quite on track with today's technology and are still using manual inventory management procedures. With this come a lot of inconsistent tracking, innacurate data, overstocking, inventory loss, inefficient processes that can be challenging to overcome. 

## Language
- Elixir
 
## Topics used
1. Functional programming
        
        We are going to use Elixir to solve this problem, as it is a functional language designed to build 
        scalable and maintainable applications.
2. Recursion
        
        Functional languages like elixir rely on recursion, a function is called recursively until a condition 
        is reached that stops the recursive action from continuing. Elixir normally uses recursion for looping 
        over data structures like lists. 
3. Lists
        
        Lists are particularly suitable for functional programming because they go well together with recursion, 
        since they are like linked lists, modification and sharing is pretty easy.
4. File I/O
        
        File I/O is a very important part of any programming language as it allows the language to interact 
        with files on a file system. Reading, writing and modifying the files are part of this. 

## Proposed solution
To solve the problem listed before, our project consist in simulating a bookstore inventory management system, we have seen this scenario being solved in multiple programming languages, in this case we are going to be using elixir as it was one of the languages we saw in class. 

First, we are planning to have a CSV file containing all the books with the following information: SKU, title, author, description, price and the quantity. We are going to open the file, as seen in class, modify it's contents depending on what the option to be done is like, adding a book, modifying books or deleting them. This CSV will be stored as a list of lists. 

As for lists, we will use them as a shopping cart, in this we would keep track of what every customer has chosen, like if a customer has chosen a book, then it will append to a list (SKU, title, price, quantity), and with the help of recursion we will make the operations on the quantity, like decreasing and calculating the price. 

As something additional, we are going to use other files, for example a table for book requests, in this we would store books that clients have asked for but the store doesn't currently have, maybe even have a table to keep track of the sales made by each employee. 

Forseeing the functions we are going to make in order to complete the project, we are thinking of the next ones:
* convert CSV to matrix/list
* append to list
* delete from list
* sum and substraction function (calculating the price)
* updating the files
* TBA

## What does it include?
### Files
- [x] README.md
- [x] book2up.exs (main file)
- [x] books.csv 
- [x] logo.png

## Functions
1. read_data
        
         Function that reads our CSV, it takes a string with the full path to a CSV file and returns a matrix with the contents of a CSV file indicated as the argument.
2. make_numeric
        
        Function that converts into int or float the fields that require it and uses a second list that indicates the type of each column.
3. write_data
        
        Function that writes the results in a CSV, the result must be in a list of lists.
4. append
        
        Function to append data, it takes the data and the list to append then it adds a book to the CSV.
- Example
``` 
new = [[6, "Karana", "Ana Karen", "This is the adventure of Ana Karen in the elixir project", 230, 1]]
new2 = append(data, new) 
```
- Screenshot

![image](https://i.imgur.com/kzLCf3Y.png)

5. erase_book
        
        Function that takes the data, an identifier and sku, it returns the list with the deleted book
- Example
``` 
book_delete = erase_book(book_update, 0, 5)
```
- Screenshot

![image](https://i.imgur.com/ffmOYPl.png)

6. unwrap
        
        Auxiliar function that takes a list of lists and returns the list unwrapped using recursion. We call this function in the function erase_book, because it was returning a list inside a list inside a list.
7. add_stock
        
        Function that takes the data, two identifiers, the sku and value to change, it changes the value of the stock, increasing it.
- Example
``` 
book_update = add_stock(new2, 0, 5, 5, 3)
```     
- Screenshot (Before & after)

![image](https://i.imgur.com/uyRFgCq.png)

![image](https://i.imgur.com/Os0q7F7.png)

8. remove_stock
        
         Function that takes the data, two identifiers, the sku and value to change, it changes the value of the stock, decreasing it.
- Example
 ``` 
book_update1 = remove_stock(book_delete, 0, 5, 4, 1)
```  
- Screenshot (Before & after)

![image](https://i.imgur.com/PQ0EJHJ.png)

![image](https://i.imgur.com/MUpGX91.png)

9. add
        
        Function that takes the data, an identifier and the sku, it adds a book to the customer's CSV.
- Example
``` 
item = add(data, 0, 3)
item2 = add(data, 0, 4)
``` 
- Screenshot

![image](https://i.imgur.com/hCNGQ5q.png)

10. total
        
        Function that takes the data and it calculates the total price of the books in the custome's CSV.
- Example
``` 
total_price = total(item2)
``` 
- Screenshot

![image](https://i.imgur.com/N2qQ9Ii.png)

11. main
        
        Where we call all of our functions.

## How to execute it?
First of all, you will need to clone the repository
```
git clone https://github.com/anapao-minchaca/Book2Up_PL
```
Then, just run the main file book2up.exs with the next line of code, there should be no errors or warnings

    iex book2up.exs

Depending on which function you are using on the main method, then just run the following line of code, as all of our functionalities are executed there, but as for now by just writing this there should be no problem on the csv generated

    FP.main()
    
## Video
- Link to video: https://drive.google.com/file/d/1k9HxvBub7RMpEfUhUf9CfIOMyDMorYWp/view?usp=sharing
