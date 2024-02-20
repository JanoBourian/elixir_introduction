defmodule FlattenExample do
    def func(list) do
        import List, only: [flatten: 1]
        flatten(list)
    end
end

IO.inspect FlattenExample.func([1, [2,3, [4, 5], 6, 7] , 8])