
htmlcontent=$(curl -s http://10.0.17.6/Assignment.html)

table=$(echo "$htmlcontent" | sed -n '/<table/,/<\/table>/p' | sed 's/<[^>]*>//g')

split=$(echo "$table" | grep -n "Pressure" | cut -d ':' -f 1)

table_temp=$(echo "$table" | head -n $((split - 1)) | sed '/^$/d')
table_temp_clean=($(echo "$table_temp" | sed 's/[[:space:]]*$//'))

table_pressure=$(echo "$table" | tail -n +$split | sed '/^$/d')
table_pressure_format=($(echo "$table_pressure" | sed 's/[[:space:]]*$//'))

table_time_clean=($(echo "$table_pressure" | sed -n '/Time/,$p' | sed 's/[[:space:]]*$//'))

for ((i = 2; i < "${#table_time_clean[@]}"; i+=2)); do
    echo "${table_temp_clean[$i]} - ${table_pressure_format[$i]} - ${table_time_clean[$i]}"
done
