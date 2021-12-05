# Final Project: Book2Up

# Ana Paola Minchaca - A01026744
# Karen Isabel Morgado - A01027446
# 2021-11-19

defmodule FP do

    @doc """
    FUNCTION: read_data
    INPUT: takes a string with the full path to a CSV file
    OUTPUT: return a matrix with the contents of a CSV file indicated as the argument
    """
    def read_data(filename) do
        _data = filename
            |> File.stream!()
            |> Enum.map(&String.trim/1)
            # Using the 'capture' syntax
            |> Enum.map(&(String.split(&1, ",")))
    end

    @doc """
    Convert into int or float the fields that require it
    Use a second list that indicates the type of each column
    """
    def make_numeric([header | data], types) do
        # The first list comprehension works on each row of the matrix
        new_data = for row <- data do
                    # The second comprehension works on each column of the row
                    # pairs the columns with the types, using zip
                    for {value, type} <- Enum.zip(row, types) do
                        # Convert the value in the column depending on the type
                        case type do
                        # Just to see the changes, add 10 to the stock
                        :int -> String.to_integer(value)
                        :float -> String.to_float(value)
                        _ -> value
                        end
                    end
                    end
        # Join back the header that was separated when getting the arguments
        [header | new_data]
    end

    def write_data(data, filename) do
        {:ok, out_file} = File.open(filename, [:write])
        for row <- data do
            IO.puts(out_file, Enum.join(row, ","))
        end
        File.close(out_file)
    end

    @doc """
    FUNCTION: append
    INPUT: takes the data and the list to append
    OUTPUT: add a book to the CSV
    """
    def append(data, list) do
        Enum.concat(data, list)
    end

    @doc """
    FUNCTION: erase_book
    INPUT: takes the data, an identifier and sku
    OUTPUT: the list with the deleted book
    """
    def erase_book(data, identifier, sku) do
        new_data = for row <- data do
        # we find the column
            if Enum.at(row, identifier) == sku, do:
            # we delete the whole row where the sku is equals to the one we search
                List.delete_at(data, sku)
        end
        # we filter the nils on the list and unwrap it
        new_data2 = Enum.filter(new_data, & !is_nil(&1))
        unwrap(new_data2)
    end

    @doc """
    FUNCTION: unwrap
    INPUT: takes a list of lists
    OUTPUT: list unwrapped using recursion
    """
    def unwrap(list) when is_list(list) do
        do_unwrap list
    end
    defp do_unwrap([list | []]) when is_list(list) do
        do_unwrap list
    end
    defp do_unwrap(list) when is_list(list) do
        Enum.map(list, &do_unwrap/1)
    end
    defp do_unwrap(other), do: other

    @doc """
    FUNCTION: add_stock
    INPUT: takes the data, two identifiers, the sku and value to change
    OUTPUT: adds the stock
    """
    def add_stock(data, identifier, identifier2, sku, value) do
        new_data = for row <- data do
        # we find the column
            if Enum.at(row, identifier) == sku, do:
                # we return the whole row
                row
        end
        # now we find the row where we have the stock
        data1 = Enum.at(new_data, identifier2)
        # we make an update on the stock row, by adding the value and replace it
        data2 = List.update_at(data1, identifier2, &(&1 + value))
        List.replace_at(data, sku, data2)
    end

    @doc """
    FUNCTION: remove_stock
    INPUT: takes the data, two identifiers, the sku and value to change
    OUTPUT: substracts the stock
    """
    def remove_stock(data, identifier, identifier2, sku, value) do
        new_data = for row <- data do
        # we find the column
            if Enum.at(row, identifier) == sku, do:
            # we return the whole row
                row
        end
        # now we find the row where we have the stock
        data1 = Enum.at(new_data, identifier2)
        # we make an update on the stock row, by decreasing the value and replace it
        data2 = List.update_at(data1, identifier2, &(&1 - value))
        List.replace_at(data, sku, data2)
    end

    @doc """
    FUNCTION: add
    INPUT: takes the data, an identifier and the sku
    OUTPUT: add a book to the customer's CSV
    """
    def add(data, identifier, sku) do
        new_data = for row <- data do
            # we find the column
                if Enum.at(row, identifier) == sku, do:
                # we return the whole row without the stock
                    List.delete_at(row, 5)
        end
        # filter the nils on the list
        Enum.filter(new_data, & !is_nil(&1))
    end

    @doc """
    FUNCTION: total
    INPUT: takes the data
    OUTPUT: the total price of the books
    """
    def total(data) do
        new_data = for row <- data do
            # we find the price colum
            Enum.at(row, 4)
        end

        # sum the values stored in new data (price)
        total = [["Total:", Enum.sum(new_data)]]
        append(data, total)
    end

    def main() do
        # csv where our books are stored
        filename = "books.csv"

        # defining the types for the csv
        types = [:int, :str, :str, :str, :int, :int]

        # pipes for reading file
        data = filename
            |> read_data()
            |> make_numeric(types)

        # variables to add a book to the csv
        new = [[6, "Karana", "Ana Karen", "This is the adventure of Ana Karen in the elixir project", 230, 1]]
        new2 = append(data, new)
        write_data(new2, "booksnew.csv")

        # variables to add stock of a book in the csv
        book_update = add_stock(new2, 0, 5, 5, 3)
        write_data(book_update, "booksnew.csv")

        # variables to delete a book in the csv
        book_delete = erase_book(book_update, 0, 5)
        write_data(book_delete, "booksnew_update.csv")

        # variables to add stock of a book in the csv
        #book_update1 = remove_stock(book_delete, 0, 5, 4, 1)
        #write_data(book_update1, "booksnew_update.csv")

        # variables for adding books to a customer's cart
        item = add(data, 0, 3)
        write_data(item, "ana.csv")
        item2 = add(data, 0, 4)
        item2 = append(item, item2)
        write_data(item2, "ana.csv")

        # variables for calculating the price on a customer's cart
        total_price = total(item2)
        write_data(total_price, "ana.csv")
    end
end
