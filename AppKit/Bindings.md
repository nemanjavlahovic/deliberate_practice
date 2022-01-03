# Bindings

- Each AppKit component can have its bindings, for example, a text field can be bound to User Defaults Controller which can handle savings after editing is finished. 
- There is a Value Transformer, so for example if you are inputing Int, and saving to User Defaults, you don't have to worry about transforming value before saving it. 
- If there is a need for value to be saved when window is closed without finishing editing in text field, you can set `Continuously Updates Value` to true.