#!/bin/fish

for file in $(fd -e pdf . papers/) ;
    echo "Converting $file";
    set base_name (path change-extension "" $file);
    pdftoppm -jpeg -r 500 -singlefile $file $base_name ;
end