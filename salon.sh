#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
   then
   echo -e "\n$1"
  fi 

echo -e "~~ Welcome To Salaam Salon ~~\n"
echo -e "What would you like us to do for you:"

echo -e "1) Cutting \n2) Treaming\n3) Dreadlock\n4) Exit\n"
read SERVICE_ID_SELECTED
case $SERVICE_ID_SELECTED in
    1) ARRENGE_AN_APPOINTMENT ;;
    2) ARRENGE_AN_APPOINTMENT ;;
    3) ARRENGE_AN_APPOINTMENT ;;
    4) exit ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac  
}

ARRENGE_AN_APPOINTMENT() {
  echo -e "\nPlease enter a phone number"
   read CUSTOMER_PHONE
 # Check if he is already a customer
 ALREADYACUSTOMER=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
 echo $ALREADYACUSTOMER
   if [[ -z $ALREADYACUSTOMER ]]
     then
     #WE HAVE A NEW CUSTOMER

     #get customer name
     echo -e "\nPlease enter you name:"
      read CUSTOMER_NAME 

     #Add customer phone and name to the table
    ADD_TO_CUSTOMERS=$($PSQL "INSERT INTO customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")  
     #get appointment time

      #get customer_id 
     CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
     echo "customer_id $CUSTOMER_ID"

     echo -e "\nWhen are you coming boss, please enter the time:"
     read SERVICE_TIME
     
     #create appointment
     CREATE_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo "Check km imefanikiwa $CREATE_APPOINTMENT_RESULT"
    SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
   if [[ $CREATE_APPOINTMENT_RESULT == 'INSERT 0 1' ]]
    then
    echo "I have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
     fi

     else
   #get customer_id
     CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

   #get customer name
   CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE' ")

   #ask for time
    echo -e "\nWhen are you coming boss, please enter the time:"
     read SERVICE_TIME
     CREATE_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) values($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
   fi
}

MAIN_MENU