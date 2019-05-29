drop database if exists isp_db;
create database if not exists ISP_DB;
use isp_db;

/*
drop table if exists person;
CREATE TABLE person (
    id INT PRIMARY KEY auto_increment,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(13),
    address VARCHAR(255)
);
*/
/*    
drop table if exists type_of_service; 
CREATE TABLE type_of_service (
    name VARCHAR(12) PRIMARY KEY
); 
insert into type_of_service(name) values ("Wifi"),("Broadband");
select * from type_of_service;
*/
drop table if exists device;    

create table device(
	id int primary key auto_increment,
    name varchar(50) not null unique key,
    price int not null,
    description varchar(255)
);

insert into device (name, price, description) values
("D-SIM", 200, "data sim"),
("D-USB", 500, "data usb without wifi"),
("DW-USB", 1000, "data usb with 3G wifi,upt0 3 user connection limit"),
("DW2-USB", 1200, "data usb with 3G wifi,upto 5 user connection limit"),
("DW-USB-4G", 1800, "data usb with 4G wifi,upt0 3 user connection limit"),
("DW2-USB-4G", 2200, "data usb with 4G wifi,upto 5 user connection limit"),
("WIFI-Basic", 1200, "Wifi device with 3G wifi,upto 3 user connection limit"),
("WIFI-Basic-Ext", 1500, "Wifi device with 3G wifi,upto 8 user connection limit"),
("WIFI-4G", 3000, "Wifi device with 4G wifi,upto 3 user connection limit"),
("WIFI-4G-Ext", 4500, "Wifi device with 4G wifi,upto 10 user connection limit");

SELECT 
    *
FROM
    device;



drop table if exists sevice;    
create table service(
	id int primary key auto_increment,
    name varchar(50) unique key ,
	data varchar(7) not null,
    validity varchar(15) not null,
    speed varchar(10) not null,
   type enum("Data" , "Broadband"),
   price int not null
);
    
insert into service (type ,data , validity, speed, price, name )  values
("Data","10GB", "1 Day" , "24MBps", 100,'Data 10'),
("Data","20GB", "3 Day", "24MBps", 190, 'Data 20'),
("Data","50GB", "10 Day", "24MBps", 480, 'Data 50'),
("Data","100GB", "20 Day", "24MBps", 940,'Data 100'),
("Data","200GB", "1 Month", "24MBps", 1860,'Data 200'),
("Data","500GB", "45 Day", "24MBps",4660,'Data 500'),
("Data","1TB", "2 Month", "24MBps",9270, 'Data 1TB' ),
("Data","2TB", "3 Month", "24MBps",18440, 'Data 2TB'),


("Broadband", "500GB", "1 Month", "1MBps",700, 'BB Monthly 1MB'),
("Broadband", "500GB", "1 Month", "2MBps",1000, 'BB Monthly 2MB'),
("Broadband", "500GB", "1 month", "4MBps",1200, 'BB Monthly 4MB'),
("Broadband", "500GB", "1 month", "8MBps","1600", 'BB Monthly 8MB'),
("Broadband", "500GB", "1 month", "12MBps",2200, 'BB Monthly 12MB'),
("Broadband", "500GB", "1 month", "16MBps",3000, 'BB Monthly 16MB'),
("Broadband", "500GB", "1 month", "24MBps",4000, 'BB Monthly 24MB'),

("Broadband", "1.5TB", "3 Month", "1MBps",1330, 'BB Quaterly 1MB'),
("Broadband", "1.5TB", "3 Month", "2MBps",1900, 'BB Quaterly 2MB'),
("Broadband", "1.5TB", "3 month", "4MBps",2280, 'BB Quaterly 4MB'),
("Broadband", "1.5TB", "3 month", "8MBps",3040, 'BB Quaterly 8MB'),
("Broadband", "1.5TB", "3 month", "12MBps",4180, 'BB Quaterly 12MB'),
("Broadband", "1.5TB", "3 month", "16MBps",5700, 'BB Quaterly 16MB'),
("Broadband", "1.5TB", "3 month", "24MBps",7600, 'BB Quaterly 24MB'),

("Broadband", "6TB", "12 Month", "1MBps",3300, 'BB Annually 1MB'),
("Broadband", "6TB", "12 Month", "2MBps",4700, 'BB Annually 2MB'),
("Broadband", "6TB", "12 month", "4MBps",5650, 'BB Annually 4MB'),
("Broadband", "6TB", "12 month", "8MBps",7500, 'BB Annually 8MB'),
("Broadband", "6TB", "12 month", "12MBps",10750, 'BB Annually 12MB'),
("Broadband", "6TB", "12 month", "16MBps",14700, 'BB Annually 16MB'),
("Broadband", "6TB", "12 month", "24MBps",18800, 'BB Annually 24MB');

SELECT 
    *
FROM
    service;
    
    
drop table if exists customer;
CREATE TABLE customer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(13),
    address VARCHAR(255),
    service_id INT,
    status VARCHAR(18) DEFAULT 'active',
    device_id INT,
    FOREIGN KEY (service_id)
        REFERENCES service (id)
        ON DELETE CASCADE,
	FOREIGN KEY (device_id)
        REFERENCES device (id)
        ON DELETE CASCADE
);

insert into customer (name,contact,address,service_id,status) values
("James Robinson", "368-058-5149", "009 Johnson Inlet South Brookeside, NY 57365", "5","active"),
("David Martinez", "000-584-1908", "57304 Nelson Stream Apt. 649 Port Emilyton, CA 02211", "2","active"),
("Donald Tucker", "480-791-0848", "35714 Roy Orchard Suite 063 South Joshuatown, CT 73357", "28","active"),
("Kristina Vang", "629-763-5527", "8036 Dale Stravenue Suite 496 New Kevin, DC 67563", "15","active"),
("Sierra Gonzales", "303-266-8441", "9665 Steven Brook Suite 537 New Allison, CA 60123", "15","active"),
("Kaitlyn Carrillo", "679-018-5848", "47854 Lucero Keys New Heathermouth, NJ 81278", "29","active"),
("Ruth Flores", "165-009-5068", "6462 Mitchell Terrace Flemingland, PA 73221", "25","deactive"),
("Michael Martinez", "232-315-5511", "483 Theresa Circle Samanthashire, NY 98200", "2","active"),
("Stephanie Kelley", "434-446-1781", "7924 Cruz Common Suite 607 South Amyfort, HI 07977", "12","active"),
("Erica Martin", "577-453-9550", "21060 Thomas Corner Lake Anitastad, GA 37198", "10","active"),
("Sara Gentry", "307-838-8072", "85527 Justin Streets Apt. 869 South Matthewstad, DE 36969", "27","active"),
("Dale Riley", "554-562-2355", "033 Huynh Street Hicksbury, NM 48192", "7","deactive"),
("Marcus Romero", "015-138-0934", "6838 Ruiz Street New Karaport, MN 24005", "4","active"),
("Kristen Lewis", "996-381-6780", "5842 Christian Key Suite 620 Petersonborough, OK 37080", "6","active"),
("Terry Meyer", "741-642-9643", "364 Christopher Canyon Suite 170 Kennethtown, OK 84141", "21","active"),
("Leah Fischer", "839-029-1441", "61885 Dean Junctions Carriemouth, VT 55296", "17","active"),
("Julia Morales", "500-286-2750", "54248 Judith Point Apt. 632 Katherinehaven, WI 57926", "19","active"),
("Dustin Morrison", "699-832-9204", "4183 Troy Ferry Port Maria, CO 55368", "17","active"),
("Ryan Stanley", "739-994-5348", "6719 Holly Ports West Teresaside, KS 65292", "26","deactive"),
("Dakota Edwards", "439-888-9055", "5513 Cynthia Orchard Michaelfort, LA 42162", "26","active"),
("Nicholas Williams", "277-207-3591", "68486 Liu Plaza Suite 141 Fowlerbury, VA 02225", "4","active"),
("James Welch", "853-037-5270", "3578 Flores Bypass Lake Janet, HI 40836", "14","active"),
("Regina Stein", "431-035-9157", "65958 Cindy Estates Emilyview, UT 46816", "4","active"),
("Isaac Johnson", "909-663-9307", "0144 James Prairie Bowersview, WV 83167", "25","deactive"),
("Brian Harrison", "848-861-8686", "59212 Lori Circle South Daniel, AL 75343", "23","active"),
("Jose Mathews", "019-872-4419", "846 Nelson Alley Apt. 190 Bradleymouth, WI 67482", "7","active"),
("James King", "446-915-2373", "4785 Shelby Pine Suite 777 Lake Ronald, MT 19082", "10","active"),
("Paul Miller", "744-678-1750", "2083 Guerrero Throughway Hectorborough, UT 56558", "27","deactive"),
("Janet Allen", "379-969-6382", "6505 Latoya Ports Apt. 666 New James, WI 94520", "13","deactive"),
("Nathaniel Williams", "375-297-4351", "264 Maurice Spring Apt. 781 Ericfurt, FL 88848", "15","deactive"),
("Lisa Davis", "839-575-5493", "87104 David Springs Lake Amber, AL 34744", "13","active"),
("Abigail Morrison", "497-973-0973", "101 Martinez Brooks West Tonyfort, WA 19995", "27","active"),
("Samantha Collins", "746-355-4561", "587 Hardy View South Feliciafort, KS 11537", "24","deactive"),
("Rhonda Washington", "494-341-5491", "7563 Boyd Throughway Russellfurt, TN 07081", "19","active"),
("Ronald Collins", "433-131-6952", "30502 Jessica View Suite 057 Janiceside, NE 85549", "1","active"),
("David Marquez", "228-919-6941", "8629 Miller Course Apt. 938 Christyport, FL 87846", "3","active"),
("Lawrence Hudson", "352-894-3235", "7828 Hester Streets Suite 859 Brookehaven, ID 72174", "16","active"),
("Yesenia Oliver", "962-309-7810", "44831 Caroline Ridge Apt. 606 South Joseph, WI 81340", "23","active"),
("Christopher Hayes", "053-052-8784", "03955 Mcintyre Flats Garciastad, AL 11324", "3","active"),
("Samantha Weaver", "963-297-7108", "89259 Stephen Pines New Jean, FL 81323", "18","active"),
("Gerald Thomas", "491-647-0393", "1408 Dana Islands Suite 462 Williamshaven, OH 48775", "4","active"),
("Christine Anderson", "602-691-4571", "71714 Cindy Gateway Heatherborough, IL 36204", "1","active"),
("Mary Snyder", "469-062-3843", "2276 Turner Prairie Erinberg, ND 17824", "10","deactive"),
("Gina Alvarado", "697-273-0462", "Unit 4533 Box 1182 DPO AP 74236", "15","active"),
("Stephanie Garza", "050-295-9296", "7837 Walls Road Suite 234 Medinaton, HI 76762", "11","active"),
("Christopher Tran", "838-329-4572", "4844 Mata Viaduct Lake Scott, MT 04301", "27","active"),
("Lauren Santana", "809-647-0497", "PSC 3780, Box 4592 APO AE 11931", "18","active"),
("Ashley Webb", "817-738-5430", "507 Doyle Skyway New Bryceburgh, NV 20688", "2","active"),
("Spencer Murphy", "783-396-6515", "779 Williams Locks Kelliside, UT 72643", "8","active"),
("Christina Thompson", "409-756-1118", "8569 White Pines Jaredmouth, NY 73465", "20","active"),
("Robert Benjamin", "623-252-7684", "9792 Deanna Isle Apt. 279 West Jenniferborough, VT 29378", "17","active"),
("Brandy Davis", "302-272-6498", "2290 Reed Fords Apt. 156 Port Kaylee, NH 42203", "1","active"),
("Katherine Rodgers", "148-017-5494", "0637 Hammond Center Apt. 741 Jenningsfurt, NV 53335", "5","deactive"),
("Amy Anderson", "032-477-6245", "1252 Jones Gardens Port Denise, VA 03085", "25","active"),
("Alexander Harris", "189-870-7894", "945 Rogers Overpass Maldonadoberg, OK 13659", "18","deactive"),
("Sarah Warren", "584-316-8652", "2165 Case Loaf Mcdonaldmouth, OR 21574", "4","deactive"),
("Paul Arias", "630-674-7579", "USS Barnes FPO AE 74772", "12","deactive"),
("Kelly Oliver", "877-527-0568", "416 Brown Cape Apt. 764 North Jessechester, ND 37530", "5","active"),
("William Nunez", "526-676-8113", "87582 Lisa Inlet New Lukeborough, CT 08072", "29","active"),
("Catherine Richards", "724-930-8141", "57443 Nathan Via Apt. 461 New Amberborough, MA 86106", "26","deactive"),
("Blake Williams Jr.", "702-771-4115", "7486 Kimberly Landing Apt. 004 New Maria, WY 66814", "12","active"),
("Edward Brooks", "655-970-3668", "566 Ashley Common South Sarah, GA 88066", "6","active"),
("Cynthia Walters", "407-547-9014", "6128 Donald Ports Apt. 888 Stevenview, NJ 88142", "11","active"),
("Cynthia Berry", "032-832-2607", "668 Jeffrey Crescent Waynefort, UT 41381", "2","active"),
("Jill Hardin", "226-933-1139", "USCGC Johnson FPO AE 71973", "16","deactive"),
("Frank Mack", "668-863-0958", "PSC 8042, Box 4814 APO AE 14725", "10","deactive"),
("Laura Roberts", "205-168-2866", "59342 Sarah Curve Apt. 343 South Rebeccaport, MS 03771", "21","active"),
("Michael Graham", "189-886-7023", "USCGC Wang FPO AE 31813", "18","active"),
("Jennifer Moore", "016-231-2083", "809 Castaneda Neck Mccoyburgh, WA 43684", "14","active"),
("Jill Hernandez DVM", "746-255-6330", "037 Smith Squares Suite 001 North Michellemouth, ID 38889", "21","deactive"),
("Steven Stark", "885-002-1684", "5516 Blackburn Extension Apt. 465 New Michael, TX 78958", "16","active"),
("Todd Suarez", "835-925-9047", "105 Mary Squares Mitchellshire, MI 21527", "16","deactive"),
("Tiffany Weber", "239-695-5506", "1872 Justin Points Apt. 830 West Troy, KS 83133", "2","active"),
("Brent Stark", "878-436-7730", "0565 Sandra Trail East Kristopher, PA 82817", "10","active"),
("Chelsea Peterson", "477-417-2918", "979 Natalie Avenue South Jeremymouth, AK 07190", "22","active"),
("Jacob Thompson", "902-450-3156", "205 Mandy Loaf New Jesse, NC 11308", "11","deactive"),
("Bernard Butler", "989-898-8072", "15284 Marcus Road East Lisatown, AZ 15926", "12","deactive"),
("Brandy Garcia", "311-155-9903", "5572 Wong Estates Portershire, DE 37049", "11","deactive"),
("Sheri Burch", "878-921-3556", "66425 John Cape Jameshaven, FL 93473", "7","active"),
("Donald Olson", "763-713-4210", "583 Aguilar Place Apt. 119 Lake Rachelland, NY 98028", "7","active"),
("Susan Johnston", "442-802-4127", "9661 Mendez Parkways Myersmouth, NH 25109", "12","deactive"),
("Cody Jones", "804-253-2332", "4706 Brown Forges Apt. 023 Michaeltown, NC 47438", "28","active"),
("Keith Rosales", "488-543-0360", "501 Smith Track Powellborough, WA 53299", "23","active"),
("Cynthia Davis", "074-577-0583", "95758 Henry Locks Apt. 160 North Sharon, NJ 80756", "21","deactive"),
("Michael Ellis", "312-498-8591", "53840 Duke Track Apt. 993 Martinberg, AR 86235", "1","active"),
("Mary Payne", "696-253-6793", "872 Ryan Spring Apt. 271 Susanville, CO 56347", "16","active"),
("Timothy Ford", "526-906-5186", "943 Mark Bridge Suite 082 Whitneyberg, MI 25042", "28","active"),
("Natalie Harris", "199-566-8953", "400 Cassidy Turnpike Apt. 387 North Christopher, ND 92003", "12","active"),
("Andrea Bowman", "713-336-2749", "078 Miller Skyway Apt. 470 South Crystal, CO 27492", "11","active"),
("Willie Huang", "835-311-9496", "25652 John Overpass Apt. 687 Guerreroshire, MT 61865", "25","active"),
("Michael Mccarthy DVM", "688-429-6316", "189 Joseph Key Suite 030 New Thomasfurt, NM 27290", "7","active"),
("Penny Robbins", "865-148-6697", "4505 Phillips Trail Apt. 163 West Stephanieberg, NV 47461", "21","active"),
("Nancy Reynolds", "080-820-6238", "79739 Danielle Brooks Apt. 804 North Charlesburgh, NE 73445", "11","active"),
("Aaron Shannon", "938-998-9707", "047 Johnson Estates Suite 069 New Margaret, IL 78482", "12","active"),
("Amanda Bullock", "085-299-1946", "5276 Kelly Viaduct Apt. 142 Lake Lindastad, MI 10080", "20","deactive"),
("Leah Schmidt MD", "209-368-5064", "8811 Marc Expressway Suite 654 Lake Brian, DE 99813", "15","active"),
("Cheryl Schneider", "041-959-9537", "5359 Harper Stream Suite 546 Donnamouth, OH 35651", "17","active"),
("Daniel Tran", "550-192-0575", "664 Andre Knoll Apt. 252 Johnsonburgh, WA 87553", "11","active"),
("Elizabeth Walker", "491-538-3383", "3557 Jacqueline Burg Williamstad, IA 20031", "25","active"),
("David Small", "235-185-2120", "USS Wilson FPO AP 23094", "11","active"),

("Cassandra Maldonado", "870-510-6988", "0346 Johnson Walks Apt. 376 Jonesside, WV 29719", "11","active"),
("Laura Graves", "954-556-4899", "PSC 5487, Box 6187 APO AE 55688", "29","active"),
("Daniel Harris", "666-931-3535", "01709 Nunez Green Apt. 835 South Erinchester, DC 05965", "19","active"),
("Jessica Gordon", "503-646-9189", "278 Madden Mall East Robert, WV 59698", "21","active"),
("Brittany Gardner", "947-857-7624", "31127 Timothy Inlet Apt. 727 New Kevinview, SD 02610", "26","active"),
("Ronnie Hanson III", "770-143-8614", "37841 Brad Freeway Fernandomouth, MO 29229", "24","active"),
("Ann Morris", "761-543-4847", "95358 Jay Islands Port Tina, MT 69348", "6","active"),
("Nicole Patton DVM", "454-194-7338", "563 Phillips Lake Suite 421 Angelicaburgh, MT 98980", "6","active"),
("Amber Luna", "036-762-2262", "12131 Fowler Overpass Suite 574 East Jasonton, HI 21069", "8","active"),
("Melissa Johnson", "396-381-1348", "PSC 5142, Box 3044 APO AE 90311", "14","active"),
("Michael Jackson", "868-458-5499", "225 Wilson Center Apt. 335 Jonesburgh, ID 48414", "9","active"),
("Donna Williams", "224-754-5055", "573 Hamilton Loaf West Joseph, LA 00953", "19","active"),
("Lance Mccarty", "823-945-8071", "458 Sergio Centers Romanstad, KS 87095", "2","deactive"),
("Jennifer Munoz", "115-168-8199", "8904 Martin Locks Suite 401 Gloverland, LA 33798", "1","active"),
("Ryan Oliver", "794-232-7364", "00667 Jonathan Crescent Catherineville, MD 74816", "1","active"),
("Eugene Hines", "995-178-8192", "8471 Vicki Inlet Apt. 216 Peggychester, FL 40660", "4","active"),
("George Herrera", "098-803-5767", "704 Bradley Radial Georgechester, NH 02868", "1","active"),
("Christopher Wilson", "406-890-8525", "98691 Davis Turnpike Suite 241 Nelsonborough, ID 85858", "11","active"),
("Catherine Bell", "383-806-9673", "7638 David Green Apt. 684 New Timothy, OH 12578", "23","active"),
("Brian Scott", "128-046-4850", "591 Sandra Isle New Courtney, NV 13369", "12","active"),
("Roy Gomez", "422-837-7341", "58521 Elizabeth Ville Suite 392 Walshview, WY 39815", "28","active"),
("Keith Ortiz", "429-606-9936", "USS Conley FPO AP 33269", "6","active"),
("Patricia Martin", "111-727-5954", "11003 Bolton Plains West Angela, KY 01894", "10","active"),
("Heidi Parks", "972-768-1893", "8528 Turner Corners Michaelfurt, VT 70669", "8","active"),
("Andrew Diaz", "024-581-9730", "92162 Aguilar Road Apt. 840 Elizabethborough, HI 89759", "13","active"),
("John Duke", "297-756-7215", "54632 Richardson Valley Suite 002 Heiditon, MO 19670", "19","active"),
("James Berry", "702-193-0615", "829 Charles Estate Suite 533 Makaylabury, TN 01358", "24","deactive"),
("Lisa Porter", "034-471-5729", "Unit 9051 Box 0858 DPO AE 12468", "23","active"),
("Steven Hancock", "621-913-5019", "54060 Singleton Flat Johnsonport, WI 93303", "13","active"),
("Olivia Walker", "413-833-0197", "USCGC Ford FPO AE 75606", "2","deactive"),
("Anna Chen", "757-919-2749", "87374 Mark Meadow Hillchester, KY 63804", "14","deactive"),
("Ricky Robinson", "858-108-6312", "536 Garrett Trail Taylorport, UT 55866", "1","deactive"),
("Steven Black", "989-351-8258", "398 Larry Plaza Suite 015 New Meganchester, CT 18339", "12","deactive"),
("Vincent Fernandez", "962-998-1003", "999 Hernandez Stravenue Scottview, AR 36751", "3","active"),
("Frank Medina", "715-360-6045", "8005 Arnold Mountain Suite 128 Danaland, HI 24304", "1","deactive"),
("Julie Miller", "083-406-1474", "44331 Teresa Islands Apt. 649 Shirleyshire, CO 81446", "6","deactive"),
("Valerie Moore", "937-121-7410", "7069 Brian Walks Apt. 806 Jasonshire, DC 79635", "25","active"),
("Melissa Chen", "417-636-9706", "607 Moore Freeway Apt. 700 West Amanda, HI 17177", "27","active"),
("James Johnson", "056-587-9464", "43324 Thomas Tunnel Port Madeline, NH 77740", "5","active"),
("Taylor Lee", "818-075-3044", "991 John Streets South Erinberg, TN 14838", "14","active"),
("Nancy Terry", "719-375-7184", "46481 Davis Crescent Wongside, NJ 83480", "24","deactive"),
("Annette Massey", "791-121-2100", "4522 Robert Groves Suite 713 Lake Vanessa, CA 02015", "1","active"),
("Patrick Mitchell", "416-903-9626", "8665 Glover Brook Apt. 327 Cordovaburgh, TX 37457", "29","active"),
("Joshua Brown", "787-029-2900", "32274 Zoe Lodge Suite 771 Doylefort, TN 41001", "11","deactive"),
("Kimberly Frederick DVM", "561-036-7300", "16394 Kenneth Forks Suite 426 Christineborough, RI 77788", "10","deactive"),
("Jennifer Humphrey", "260-242-8448", "69117 Mitchell Forks Apt. 280 Steinburgh, LA 94181", "20","deactive"),
("Scott Peters", "038-527-5463", "244 Frazier Knoll Apt. 707 Lake Brettburgh, AR 09302", "13","deactive"),
("Abigail Ramos", "186-994-2317", "8876 Theresa Valleys Suite 407 West Jamesmouth, MT 08343", "16","active"),
("Ryan Kirk", "115-381-8638", "47580 Myers Crest Heatherfurt, KY 91445", "5","active"),
("Danny Thompson", "476-846-4127", "1355 Wright Route Youngmouth, NY 79698", "10","active"),
("Deborah Rios", "985-684-6241", "15791 Jones Prairie Suite 135 Kirkshire, WY 37712", "19","active"),
("Dustin Snyder", "425-312-5775", "87699 Reynolds Trace Apt. 679 Snyderburgh, AK 55824", "18","active"),
("Joshua Colon", "098-364-9700", "323 Adams Junctions Suite 035 West Eric, AR 30956", "15","deactive"),
("Alan Mason", "962-860-5719", "367 Marco Points Suite 783 Glendamouth, AZ 18972", "7","active"),
("John Reynolds", "237-170-4518", "4076 Ponce Mountain East Christine, TX 47044", "17","deactive"),
("Brian Harris", "631-239-9261", "PSC 7565, Box 9660 APO AA 77932", "23","active"),
("Linda Chavez", "439-103-0953", "0753 Jones Row Apt. 226 Lake Amystad, LA 91839", "26","active"),
("Miguel Cook", "762-339-2421", "USNS Carroll FPO AA 01248", "29","deactive"),
("Gary Evans", "696-770-0447", "2886 Ball Manor South Melissaburgh, VT 51290", "14","active"),
("Melinda Mercado", "391-247-9496", "463 Mary River Apt. 354 Susanland, NV 13512", "24","active"),
("Anne Riley", "839-071-9172", "320 Jennifer Run South Ryan, IN 10223", "9","deactive"),
("Jeffrey Cox", "669-888-6658", "94086 Phelps Glens Suite 533 New Frank, KS 85391", "9","active"),
("Karen Gonzalez", "077-792-3369", "182 Hubbard Run Apt. 565 Port Christineton, LA 37174", "14","deactive"),
("Thomas Gill", "090-075-3122", "06377 Li Viaduct Suite 450 Vaughnbury, OR 16534", "2","active"),
("Natalie Mason", "553-069-5212", "1783 Austin Valleys Mezafurt, CT 12732", "14","active"),
("Sharon Shah", "822-315-0830", "7375 Donald Spring Reesetown, CT 29077", "18","active"),
("Paul Diaz", "967-654-8859", "911 Melinda Square Solisfurt, TN 14807", "9","deactive"),
("Kevin Wolf", "763-811-0691", "941 David Forges Port Lancemouth, CT 23271", "28","active"),
("Jennifer Heath", "941-730-9967", "4538 Ashley Harbors Port Brettville, NC 45313", "4","active"),
("Debra Boone", "864-943-1472", "PSC 9936, Box 6601 APO AE 37361", "26","active"),
("Bradley Johnson", "035-795-1295", "0328 Dawson Key Suite 890 Cooperport, GA 02974", "5","active"),
("Richard Nelson", "291-072-5579", "3138 Thomas Center Apt. 542 North Meganstad, DE 51009", "19","deactive"),
("Kelly Campos", "933-891-4279", "USS Hayes FPO AA 35078", "6","active"),
("Becky Sanders", "186-335-4283", "815 Fowler Mews Kristenberg, IN 62953", "4","deactive"),
("Hunter Dixon", "852-104-7209", "7875 Bender Path Suite 264 Mirandatown, RI 70471", "2","active"),
("Summer Cross", "545-938-6637", "USCGC Reese FPO AA 78036", "28","active"),
("Diana Smith", "410-490-8997", "PSC 6645, Box 7310 APO AP 48885", "6","active"),
("Justin Pugh", "996-841-3182", "645 Elizabeth Square West Lindamouth, MN 21963", "22","active"),
("Samuel Warner", "847-345-1403", "86390 Gonzalez Brook East Mark, WY 32782", "5","active"),
("Renee Porter", "055-050-7615", "060 Miller Inlet Suite 213 Williamsview, MT 18073", "26","active"),
("Russell Hudson", "287-227-8495", "218 Bennett Rest Port Emily, KY 70687", "26","active"),
("Kathy Parsons", "291-775-9567", "675 Rivera Mount North John, MS 07295", "11","active"),
("Hannah Stephens", "002-957-8909", "40401 Garcia Fork Apt. 071 Cherrymouth, MT 14327", "20","active"),
("Kevin Collins", "002-990-7699", "71686 Matthew Creek Donaldchester, IN 29511", "4","active"),
("Keith Smith", "213-010-2973", "42834 Robin Greens Danielstad, VT 45578", "1","active"),
("Sean Dougherty", "079-674-8934", "31788 Jennifer Land Mitchellside, DC 33133", "24","active"),
("Elizabeth Scott", "709-885-1325", "339 Thomas Corner Apt. 283 Edwardsburgh, NM 60949", "17","active"),
("James House", "176-320-1601", "438 Rice Corners Apt. 580 North Malloryburgh, KY 33375", "10","active"),
("Suzanne Morrison", "718-339-1664", "Unit 6524 Box 4560 DPO AP 36934", "25","active"),
("Timothy Sweeney", "299-387-6422", "PSC 2402, Box 1546 APO AP 19794", "15","deactive"),
("Xavier Nolan", "244-567-8867", "72086 Gregory Lake Apt. 738 East Rebeccaside, NV 21100", "24","deactive"),
("Roberto Strickland", "361-280-0658", "36533 Preston Pine Suite 750 East Teresa, TX 13109", "19","active"),
("Michael Harris", "562-406-2261", "178 Jill Creek West Josephhaven, OR 17095", "22","active"),
("Brittney Freeman DDS", "950-048-1825", "27160 Thomas Drive Kevinhaven, DE 55999", "14","active"),
("Laura Rangel", "677-813-5839", "Unit 4039 Box 6516 DPO AP 77294", "18","deactive"),
("Duane Singleton", "575-634-2426", "86085 Garza Ranch Apt. 294 Rileybury, MD 46560", "18","active"),
("Donald Taylor", "757-913-0938", "70170 Ramirez Junctions Port Robertfurt, DE 44869", "15","active"),
("Jonathan Beard", "921-804-3146", "USNS Morales FPO AA 44856", "15","active"),
("Susan Nelson", "567-885-6767", "79915 Dixon Loaf East Heatherside, NH 90168", "28","active"),
("Jennifer Skinner", "267-483-8948", "3916 Adams Mews Suite 530 Lake Tonytown, VA 58658", "16","active");



select * from customer;



drop procedure procedure_name;

DELIMITER $$
CREATE PROCEDURE customer_data()
BEGIN        

SELECT 
    c.id,
    c.name,
    c.contact,
    c.address,
    c.status,
    s.data_vol AS volume,
    s.validity,
    s.speed,
    s.type_of_service,
    s.price
FROM
    customer c
        JOIN
    subscription s ON c.sub_id = s.sub_id
ORDER BY c.id;


END$$ 
DELIMITER ;

call customer_data();

