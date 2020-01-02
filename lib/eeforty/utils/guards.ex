defmodule Eeforty.Utils.Guards do
  defguard is_empty(value)
           when is_nil(value) or
                  value == "" or
                  value == [] or
                  value == {} or
                  value == %{}
end
