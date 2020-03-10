# Controlled Access for Makerspace Machines

## Software

https://github.com/esprfid/esp-rfid

## Parts list

|Item|Image|URL|
|----|-----|---|
|USB cable|![](https://m.media-amazon.com/images/I/519HG6LZAOL._AC_UY218_ML3_.jpg)|https://smile.amazon.com/Spater-Micro-USB-Cable-Motorola/dp/B01FSYBQ9Q|
|USB wall adapter|![](https://m.media-amazon.com/images/I/51fx88WRmSL._AC_UY218_ML3_.jpg)|https://smile.amazon.com/Charger-Adapter-Charging-Compatible-Samsung/dp/B07SK6GW33|
|Outlet|![](https://m.media-amazon.com/images/I/31d3DLX1ubL._AC_UL320_ML3_.jpg)|https://smile.amazon.com/Iot-Relay-Enclosed-High-Power-Raspberry/dp/B00WV7GMA2|
|RFID-rc522|![](https://m.media-amazon.com/images/I/61tuyjNxBTL._AC_UL320_ML3_.jpg)|https://smile.amazon.com/Qunqi-Sensor-Module-Arduino-Raspberry/dp/B07QBPGYBF|
|WEMOS d1 mini|![](https://m.media-amazon.com/images/I/71MHflGwU7L._AC_UY218_ML3_.jpg)|https://smile.amazon.com/IZOKEE-NodeMcu-Internet-Development-Compatible/dp/B076F52NQD|
|RFID-rc522 WEMOS d1 mini shield|![](https://github.com/nmorgret/BuckleBerry-Boards/raw/master/RFID-access/board-bottom.png)|https://github.com/nmorgret/BuckleBerry-Boards/tree/master/RFID-access|
|screw terminals|![](https://m.media-amazon.com/images/I/71MwYrdtczL._AC_UY218_ML3_.jpg)|https://smile.amazon.com/Pieces-Pinch-Mount-Terminal-Connector/dp/B01MT4LC0F|
|2.54mm jst connectors (optional)|![](https://m.media-amazon.com/images/I/71dhR-uqn6L._AC_UY218_ML3_.jpg)|https://smile.amazon.com/gp/product/B0731NHS9R|
|5ft power cable (optional)|![](https://m.media-amazon.com/images/I/71wWBoWj1iL._AC_UL320_ML3_.jpg)|https://smile.amazon.com/Aurum-Cables-Approved-Universal-Computer/dp/B01J4M3QDW|
|15ft power cable (optional)|![](https://m.media-amazon.com/images/I/51JsNNBojjL._AC_UY218_ML3_.jpg)|https://smile.amazon.com/C2G-09482-Universal-Power-Cord/dp/B000067RWH|

## Abstract

The goal of this project is to design a way that an unmanned makerspace can allow a particular user to access only the machines that they have been trained to use. The method of controlling access needed to have the ability to remove a user's access without requiring the user's presents. An RFID controlled outlet was the most obvious choice. After some research, the [esp-rfid software](https://github.com/esprfid/esp-rfid) was chosen for it's web interface and intuitive method of creating new users. A circuit-board and housing were designed to complete the project. The circuit-board connects all of the electronics together. The housing is manufactured using machines commonly found in makerspaces. The housing also locks to prevent unauthorized access to the power cables. This system will provide a semi-secure method of controlling bench-top machinery for authorized users.
