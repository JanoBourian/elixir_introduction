defmodule Withexample do
    def mean(values) do 
        with count = Enum.count(values),
            sum = Enum.sum(values)
            do
                sum/count
            end
    end
end

IO.puts Withexample.mean([1,2,3])