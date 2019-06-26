ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';

drop database if exists isp_db;
create database if not exists ISP_DB;
use isp_db;


drop table if exists device;    

create table device(
	id int primary key auto_increment,
    device varchar(50) not null unique key,
    price int not null,
    description varchar(255)
);

insert into device (device, price, description) values
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
    service varchar(50) unique key ,
	data varchar(7) not null,
    validity varchar(15) not null,
    speed varchar(10) not null,
   type enum("Data" , "Broadband"),
   price int not null
);
    
insert into service (type ,data , validity, speed, price, service )  values
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
    service_id INT null,
    active_date date,
    device_id INT null,
    FOREIGN KEY (service_id)
        REFERENCES service (id)
        ON DELETE CASCADE,
	FOREIGN KEY (device_id)
        REFERENCES device (id)
        ON DELETE CASCADE
);

insert into customer (name,contact,address,service_id,active_date,device_id) values
("Max Miller", "992-778-6756", "36651 Brandon Parkways Apt. 636 East Georgechester, HI 15039", "27","2019/05/04",null),
("Charles Mcbride", "759-460-8936", "514 Mcconnell Lane Apt. 433 East Joehaven, NE 58906", "19","2019/04/28",null),
("Jacob Pruitt", "041-011-7692", "0718 William Mountains Suite 024 West Danieltown, RI 45229", "20","2019/05/10",null),
("Erica Perez", "504-670-0999", "185 Adams Grove Robertburgh, AZ 15042", "24","2019/05/01",null),
("Darlene Smith", "284-970-9606", "88083 Thompson Divide Apt. 527 North Andrew, AK 84183", "6","2019/04/26",4),
("Justin Little", "108-534-3662", "USCGC Hansen FPO AP 61130", "20","2019/02/01",null),
("Gina Stephens", "994-734-5662", "7695 Hill Wells Suite 698 Benitezfort, OK 89471", "14","2019/03/23",null),
("Lisa Marquez", "040-985-5726", "762 Mays Mission New Christinamouth, RI 77645", "22","2019/04/05",null),
("Yesenia Cooper", "470-727-7379", "700 Cook Course Suite 821 Lynnfurt, CT 29590", "6","2019/05/26",4),
("Devin Day", "796-654-2753", "PSC 3670, Box 0083 APO AA 49869", "15","2019/04/09",null),
("David Garner", "575-665-2027", "83647 Jill Neck Suite 153 New Charles, NM 71798", "1","2019/05/20",6),
("Christopher Trevino", "191-495-0594", "98084 Kenneth Club Apt. 451 Potterfort, TN 99522", "3","2019/04/29",5),
("Juan Woodward", "115-534-8533", "0829 Diana Center Jenniferborough, DE 99755", "5","2019/06/01",2),
("Aimee Mccann", "578-948-3491", "700 Cory Crossroad Apt. 809 Lake Rebeccabury, NY 64982", "3","2019/04/19",4),
("Kayla Taylor", "335-668-8363", "016 Knox Circle Cardenasshire, ND 51901", "1","2019/02/16",1),
("Curtis Bennett", "723-774-7469", "281 Tyler Skyway East Samantha, ME 61013", "14","2019/05/01",null),
("Cheyenne Williams", "967-014-5520", "1343 Wilson Station Suite 712 West Bethany, NC 72497", "25","2019/05/10",null),
("Jason Howard", "292-935-5851", "191 Stacy Street New Maria, AZ 40454", "19","2019/05/29",null),
("Heather Paul", "692-842-9192", "73678 Julie Causeway Jonestown, SD 76082", "21","2019/05/02",null),
("David Khan", "417-556-8280", "47352 White Fords South Michael, MS 55589", "28","2019/04/03",null),
("Mrs. Tracy Reynolds", "990-906-9839", "9613 Nguyen Knolls Suite 980 Weaverport, ND 30342", "5","2019/04/25",1),
("Maria Taylor", "933-892-5220", "9090 Tucker Grove Perezburgh, OH 13788", "8","2019/05/27",5),
("Spencer Rodriguez", "095-829-8605", "64480 Sean Stravenue Suite 800 Sandrabury, CO 33283", "21","2019/04/07",null),
("Manuel Murphy", "977-830-1360", "84823 Evans Squares Suite 627 Port Brooke, RI 28969", "19","2019/03/25",null),
("Jason Benitez", "278-432-2844", "87413 Brown Mountains Suite 319 New Teresa, MS 60790", "9","2019/05/05",null),
("Shannon Bradford", "411-666-4674", "85638 Mccoy Lodge Suite 996 Port Whitney, KS 58236", "26","2019/05/15",null),
("James Morgan", "548-761-4800", "154 Reese Drive South Bobbyside, HI 59422", "7","2019/05/13",8),
("Jill Miller", "923-813-9510", "Unit 0459 Box 8180 DPO AA 46637", "26","2019/05/21",null),
("Brandon Garcia", "654-283-2454", "41017 Bianca Mountains Suite 022 Lake Hannahton, GA 39006", "11","2019/06/01",null),
("Charles Stevens", "875-983-1703", "0175 Brian Pine East Laurenville, GA 22109", "3","2019/05/21",3),
("Isaac Mitchell", "805-811-8176", "532 Lance Manors Suite 143 Mcdonaldmouth, LA 54147", "10","2019/04/21",null),
("Ann Fritz", "853-248-9497", "PSC 6305, Box 4028 APO AP 08684", "11","2019/04/12",null),
("Justin Ramirez", "800-859-2213", "Unit 7833 Box 6067 DPO AA 47908", "12","2019/05/30",null),
("Shawn Gibbs", "314-104-7645", "3847 Ryan Orchard Apt. 943 East Kimberly, WA 02827", "3","2019/04/30",4),
("Eric Blanchard", "168-507-7928", "8200 Natalie Road Suite 108 Brandtbury, IL 46809", "15","2019/02/02",null),
("Tiffany Smith", "862-151-8252", "77620 Sims Brooks Apt. 426 North Caitlin, GA 97198", "5","2019/05/05",6),
("Calvin Wallace", "721-048-9818", "373 Harris Locks Suite 513 South Randy, AL 33225", "3","2019/04/18",6),
("Micheal Price", "987-333-5700", "490 Guzman Rapids East Nicole, FL 73114", "25","2019/02/19",null),
("Rickey Lopez", "528-927-4407", "195 Jesse Lake West Anthony, KS 37740", "18","2019/04/28",null),
("Christian Stevens", "396-444-9281", "651 Schmidt Plaza Apt. 128 West Keithberg, ID 56762", "13","2019/05/02",null),
("Erika Alvarado", "565-836-6843", "883 Rodriguez Locks Apt. 570 Adamland, GA 75234", "20","2019/05/16",null),
("Chris Jones", "734-272-9131", "083 Christopher Forge Suite 806 North Jameschester, OK 99810", "5","2019/04/15",3),
("Phillip Montoya", "821-274-4660", "607 Coffey Plains Apt. 377 East Melissaton, AL 30575", "14","2019/02/14",null),
("Jennifer Dixon", "863-582-8625", "94130 Joanne Trail New Joshua, IA 45981", "2","2019/05/01",5),
("Amy Cooke", "047-818-4463", "USNV Herman FPO AE 09288", "4","2019/04/28",7),
("Lisa Huerta", "073-918-1292", "416 Victor Well Apt. 716 New Tiffanymouth, OK 28772", "23","2019/05/22",null),
("Madison Smith", "234-826-9181", "9373 Wilson Roads Nicholsburgh, WY 21338", "25","2019/04/23",null),
("Robert Williams", "924-640-0169", "Unit 2252 Box 6324 DPO AA 17898", "12","2019/04/12",null),
("Susan Sharp", "288-550-7485", "7981 Pena Island Williamsview, WV 47119", "11","2019/05/27",null),
("Stacey Rojas", "002-887-0387", "PSC 0594, Box 7853 APO AP 49582", "3","2019/05/16",6),
("Linda Terrell", "553-439-3756", "USCGC Duncan FPO AP 44767", "10","2019/05/06",null),
("Donald Chavez", "718-395-3262", "63012 Melissa Passage Brendafurt, SD 84472", "28","2019/05/26",null),
("Glenda Gray", "768-752-1830", "2844 Michael Mountain Denisestad, ND 46765", "26","2019/04/27",null),
("Andrew Mills", "904-181-7061", "53031 Ellis Radial South Caitlynland, CA 53117", "11","2019/05/14",null),
("Robin Bruce", "668-513-9518", "114 Gonzales Views Ericfurt, NC 74947", "10","2019/04/09",null),
("Alexander Berger", "121-610-5354", "481 Christian Ways Apt. 241 East Ericbury, FL 51790", "16","2019/03/21",null),
("Jaime Lopez", "799-525-1705", "83452 Watson Lock Crystalview, CT 33726", "10","2019/05/09",null),
("Darin Joyce", "906-166-0644", "106 Julie Mills Apt. 998 South Matthewburgh, WA 10484", "15","2019/05/18",null),
("Deanna Glenn", "446-217-9021", "46629 Todd Valleys Suite 180 Lake Samuel, TN 64044", "3","2019/05/20",4),
("Adrian Silva", "843-101-8742", "7890 Nguyen Turnpike Warrenview, SD 80078", "17","2019/05/08",null),
("Linda Daniels", "877-024-4880", "8532 Matthew Camp Lake Dan, MS 35841", "3","2019/01/15",6),
("Philip Robertson", "867-043-7089", "USNV Ward FPO AE 58488", "16","2019/05/28",null),
("Nathaniel Miranda", "637-077-0882", "9118 Ashley Route Melissastad, NJ 40124", "6","2019/05/22",6),
("John Hill", "763-476-4105", "646 Austin Valleys Port Elizabeth, AK 96213", "27","2019/05/01",null),
("Michelle Henderson", "149-501-1538", "4131 Andrew Freeway Apt. 472 Graymouth, AZ 21822", "9","2019/05/19",null),
("Bradley Rice", "815-744-1678", "8603 Davis Mountain Apt. 585 North Dana, VA 40350", "24","2019/05/01",null),
("Tyler Cole", "849-802-8778", "27035 Beard Haven South Brenda, SC 66271", "5","2019/05/22",5),
("Jennifer Roberts", "669-879-6955", "486 Romero Stream Apt. 241 New Katherine, CO 47624", "16","2019/05/17",null),
("Stacey Fuller", "045-416-8432", "PSC 1845, Box 5111 APO AP 89863", "19","2019/03/25",null),
("Francis Warner", "452-028-7993", "USCGC Cline FPO AE 15929", "14","2019/05/06",null),
("Matthew Khan", "385-676-0100", "90374 Fields Drive Port Jeremyfort, IA 38789", "10","2019/04/11",null),
("Sara Kelly", "280-021-4997", "2418 Melissa Rest Suite 225 Hernandezmouth, TN 84844", "28","2019/05/26",null),
("Susan Mason", "786-655-1910", "55399 Christine Pass Lake Sharon, NM 60786", "23","2019/05/17",null),
("Dana Mccoy", "600-182-7336", "1086 Harris Plaza Suite 541 Port Tricia, CA 30430", "11","2019/04/02",null),
("Jacob Mccarthy", "204-920-4797", "842 Heath Vista South Carolynchester, IL 61586", "3","2019/04/29",3),
("Nancy Baker", "936-547-4460", "4499 Davidson Glens Suite 608 Andrewfort, PA 47023", "15","2019/05/07",null),
("Matthew Munoz", "843-251-8540", "930 Wyatt Fall Raymondmouth, DE 25633", "8","2019/05/17",3),
("Douglas Mora", "885-641-1276", "1686 Hunt Ridge Apt. 327 New Patrickfurt, LA 72968", "26","2019/04/14",null),
("Teresa Duran", "825-374-5545", "4274 Giles Spurs South Ian, MD 04637", "20","2019/05/21",null),
("James Green", "747-498-5360", "707 Wesley Club Suite 001 Lake Janetmouth, PA 20961", "24","2019/05/28",null),
("David Miller", "581-408-2949", "42005 Massey Shoal Apt. 478 Travischester, NM 99281", "4","2019/04/09",10),
("Kaitlyn Moran", "542-713-8123", "45423 Jennifer Springs Suite 819 West Debbie, WI 79587", "21","2019/05/04",null),
("Robert Kelley", "926-000-2718", "4472 Debra River New Patriciashire, MT 35969", "4","2019/04/15",5),
("Rita Johnson", "313-192-1759", "02210 Dennis Overpass Apt. 717 East Lorraine, NM 28970", "27","2019/04/13",null),
("Christine Jones", "720-399-0188", "7294 Deleon Highway Ryanstad, CO 91499", "2","2019/05/23",7),
("Malik Gonzalez", "737-992-9847", "77548 Gallagher Harbor Lake Chad, PA 07020", "4","2019/05/18",7),
("Alexander Taylor", "082-418-2240", "9211 Dean Trail Apt. 030 New Diane, NV 73684", "15","2019/04/22",null),
("Kristine Haley", "424-337-5638", "92281 Steven Keys North Erikton, NV 28140", "7","2019/05/05",5),
("Robert Blair", "323-761-0582", "7930 Bell Lakes Markchester, UT 40471", "19","2019/05/03",null),

("Dominique Norton", "674-950-2137", "8044 Tom Wells Suite 326 Kristenfort, NE 52342", "19","2019/05/21",null),
("Sydney Gonzalez", "080-343-5145", "670 Dawn Forge Suite 371 South Alison, CT 31926", "8","2019/04/16",1),
("Lisa Vazquez", "898-421-0882", "092 Martinez Extensions Suite 737 South Stephen, NM 72978", "19","2019/03/06",null),
("Brandi Rodriguez", "641-962-4245", "698 Gregory River North Cory, MD 62081", "8","2019/05/09",9),
("Angelica Flores", "995-273-6160", "2528 Johnson Drive Apt. 969 Barrettview, IN 42253", "13","2019/05/25",null),
("Sean Sanders", "576-241-0970", "7136 David Heights North Briana, AK 87900", "4","2019/03/31",1),
("Anthony Johnson", "163-772-0183", "40355 Robert Shoals Port Steven, VA 82245", "25","2019/05/31",null),
("Kimberly Rodriguez", "994-950-3561", "310 Gina Isle East Martinmouth, AK 55575", "10","2019/05/27",null),
("James Ramirez", "377-118-6585", "0357 Church Tunnel Jamieborough, KY 64956", "24","2019/04/18",null),
("Jenny Rodriguez", "743-171-6342", "53569 Randolph Branch Matthewview, ND 19499", "4","2019/05/30",7),
("Laura Green", "434-376-5388", "194 Willis Streets Perezfurt, OK 81400", "24","2019/05/09",null),
("Kathleen Johnson", "660-535-2154", "58812 Sandra Glen Suite 219 Lake Timothyberg, WV 71031", "6","2019/04/06",10),
("Michelle Young", "467-178-2604", "943 Robin Mount Apt. 898 South Allenborough, CT 70812", "7","2019/04/06",1),
("Patricia Smith", "517-698-8417", "07825 Harrison Unions Seanfurt, DE 54513", "24","2019/04/12",null),
("Dr. Devin Chang Jr.", "157-677-8712", "Unit 1234 Box 3906 DPO AP 28628", "25","2019/05/07",null),
("Amanda Cole", "800-174-5202", "0475 Mueller Extensions New Annaview, VT 70750", "29","2019/06/02",null),
("Michael Castillo", "820-576-1181", "40164 Nash Motorway Grayburgh, MD 75585", "9","2019/05/30",null),
("Tracy Rodriguez", "923-418-1134", "76847 Price Lodge Apt. 815 Singhmouth, CO 93052", "9","2019/06/03",null),
("Roberto Porter", "778-806-5198", "56617 Dyer Skyway Mackmouth, SC 26659", "18","2019/05/17",null),
("Sabrina Robinson", "932-327-1601", "Unit 1278 Box 2171 DPO AE 89437", "28","2019/05/16",null),
("Emily Collins", "968-849-0757", "49321 Barbara Park Suite 603 South Michaelstad, AL 24946", "24","2019/03/20",null),
("Olivia Choi", "525-783-9303", "190 Thomas Fords North Micheal, TX 26273", "8","2019/04/25",9),
("Patrick Orozco", "472-506-6862", "PSC 0137, Box 8288 APO AP 04361", "23","2019/04/08",null),
("Sarah Sosa", "737-507-1183", "8953 Gonzalez Springs Suite 363 Port Thomasbury, RI 84132", "28","2019/04/03",null),
("Cynthia Lopez", "065-045-0253", "2641 Mcmillan Land New Danielleborough, CO 68205", "9","2019/03/13",null),
("Holly Flores", "478-635-2346", "98101 Deborah Loop Amberberg, SC 39028", "16","2019/05/24",null),
("Latasha Bass", "686-890-9985", "132 James Spurs West Julia, MN 56807", "25","2019/05/30",null),
("William Mitchell", "764-439-0212", "PSC 5707, Box 0964 APO AP 16642", "23","2019/04/02",null),
("Johnny Jacobs", "490-384-4483", "544 Frey Summit Apt. 359 New Geneville, CO 69553", "1","2019/03/20",10),
("Jerome Bailey", "145-190-4934", "85939 Rodriguez Extensions Port Melanie, NJ 13402", "2","2019/05/08",5),
("Courtney Hunt", "350-849-8123", "2125 Perez Square Apt. 938 West Susanfurt, VT 16040", "10","2019/05/22",null),
("Holly Meza", "951-683-9059", "9191 Adam Divide Joneshaven, MA 43973", "21","2019/05/21",null),
("Clifford Brown", "753-614-2521", "43607 Walker Drive Bryanbury, NH 88363", "8","2019/05/19",8),
("James Barker", "742-518-4925", "13209 Sampson Forks Lake Stacy, AZ 82293", "18","2019/05/17",null),
("Mark Barrett", "851-615-0133", "852 Jacqueline Bypass Apt. 056 New Cliffordport, IL 82221", "3","2019/05/12",5),
("Scott Gomez", "630-849-9437", "3193 Aguilar Loaf Port John, SC 68796", "20","2019/06/01",null),
("Stephanie Munoz", "207-391-6936", "80783 Nicole Flats Suite 592 Port Wendymouth, MA 97810", "2","2019/04/04",1),
("Jeffery Mendez", "922-759-9120", "1640 Erin Canyon Andersonmouth, IA 26834", "19","2019/04/16",null),
("Anthony Compton", "197-802-9218", "7750 Morales Rapids Suite 446 Ramirezburgh, WV 53002", "8","2019/01/17",4),
("Daniel Murphy", "812-921-6721", "520 Soto Points Staceyland, MN 52667", "26","2019/04/26",null),
("Ashley Harris", "082-371-2616", "273 Taylor Harbors Lake Peggy, PA 61913", "14","2019/05/07",null),
("Andrea Kramer", "902-422-9825", "USS Martinez FPO AE 00743", "7","2019/03/14",5),
("Donald White", "425-294-1299", "0868 Mills Port Christinamouth, NJ 08514", "15","2019/05/26",null),
("Larry Cortez", "494-128-2707", "532 Mark Garden Port Kelsey, OH 52423", "13","2019/05/26",null),
("Alexander Crawford", "200-128-7833", "5025 Sean Center Katherinestad, PA 15859", "5","2019/05/01",10),
("Jennifer Mason", "358-123-2240", "PSC 4276, Box 6119 APO AA 26896", "9","2019/05/28",null),
("Alexandra Shepherd", "020-730-3273", "557 Johnson Flat West Aaronberg, UT 85520", "15","2019/05/05",null),
("Pamela Duran", "896-689-9859", "742 Jones Islands Wilsonview, PA 70607", "8","2019/04/24",3),
("Tina Barry", "432-160-8932", "1805 Morris Causeway Apt. 181 Port Shannon, NH 59487", "29","2019/05/11",null),
("Jessica Randall", "518-072-8076", "5475 Wong Mountain Tommyberg, NC 35328", "27","2019/05/31",null),
("Megan Nelson", "223-666-5627", "01119 Stone Loop Lowestad, AL 48614", "2","2019/04/17",2),
("Cindy Little", "448-986-5799", "6045 Murphy Islands Apt. 461 New Jillfort, NC 61608", "26","2019/04/30",null),
("Jessica Moreno", "229-594-9928", "53059 Miller Heights Apt. 688 Brianbury, CO 96501", "10","2019/04/07",null),
("Heather Cooper", "321-315-6328", "43724 Gibson Court Suite 131 New Michelle, ID 13113", "3","2019/05/05",1),
("Shirley Wagner", "477-393-6040", "716 Mccoy Ford Suite 849 North Gregory, IN 26280", "13","2019/05/30",null),
("Lauren Tran", "047-986-9895", "36407 Patton Wall Hardyborough, OR 70012", "9","2019/04/15",null),
("Manuel Morgan", "349-601-4473", "17819 Gray Creek Suite 436 Stanleytown, HI 50956", "24","2019/03/15",null),
("Adam Fuentes", "760-461-6891", "Unit 2928 Box 5575 DPO AE 38840", "21","2019/03/28",null),
("Robert Ray", "882-628-0517", "481 Joseph Hill Anthonyburgh, AL 33707", "19","2019/03/21",null),
("Tabitha Ford", "356-845-7303", "30473 Martinez Keys Paulburgh, NM 75438", "9","2019/05/14",null),
("Brandi White", "780-644-2522", "52344 Davis Road Alexanderstad, MN 19337", "11","2019/04/01",null),
("Leonard Watson", "768-792-7427", "1754 Ashley Ridges Suite 213 Randybury, HI 27559", "14","2019/05/19",null),
("Jesse Medina", "531-828-7528", "31752 Kenneth Shoals Suite 894 Olsenville, MI 56625", "17","2019/05/24",null),
("Carl Sullivan", "622-458-8441", "96985 Schultz Locks New Laurenside, TX 37167", "19","2019/05/29",null),
("Kerry Mckee", "246-996-6178", "27536 Mitchell Prairie South Kevin, MI 67036", "6","2019/05/01",9),
("Bryan Rogers", "445-345-7191", "569 Singh Ferry Suite 491 Lisafurt, WI 69469", "1","2019/04/26",5),
("Sarah Johnson", "093-119-7398", "61859 Sanford Common Kimberlyville, MS 68464", "27","2019/04/08",null),
("Robert Wells", "073-570-0384", "19425 Clark Drive Suite 021 North Peter, UT 16438", "18","2019/03/29",null),
("Ronald Valdez", "945-640-0598", "4033 Patricia Ports New Brian, MA 50227", "29","2019/05/02",null),
("Charles Jones", "831-530-2534", "68497 Bolton Village Andersonville, VA 18137", "16","2019/06/02",null),
("Patricia Deleon", "668-873-2432", "083 Kim Knolls North Robert, AR 19186", "19","2019/05/15",null),
("Joel Matthews", "820-691-4586", "3329 Anthony Valleys Apt. 599 South Kimberlyborough, NY 01202", "12","2019/05/19",null),
("Marissa Perez", "089-457-9386", "949 Heather Lane Apt. 361 New Adamton, WY 46762", "7","2019/05/25",4),
("Taylor Hartman", "471-619-2957", "3710 Greene Trail Suite 964 Port Lee, OR 64502", "10","2019/04/21",null),
("Carlos Lopez", "473-896-7618", "63874 Larson Views Apt. 049 South Ronaldview, NJ 83909", "10","2019/05/26",null),
("Barbara Johns", "972-227-0609", "45925 Anderson Brooks Suite 646 Bridgesshire, AZ 84696", "14","2019/05/06",null),
("Robert Nichols", "030-330-2017", "02015 Garcia Circle Suite 649 New Jacquelinechester, CO 33853", "9","2019/03/20",null),
("Jeremy Lewis", "131-795-2376", "0790 Tina Heights Suite 744 Lake Earl, TN 61833", "29","2019/04/09",null),
("Jason Lewis", "774-453-5422", "436 Harris Route Leemouth, KS 11375", "6","2019/05/10",4),
("Charles Anderson", "796-055-6098", "22209 Obrien Wells Suite 636 East Davidbury, KY 50912", "5","2019/04/03",4),
("Erik Rogers", "856-934-5222", "651 Rivera Loaf Apt. 697 New Jamesborough, GA 85131", "19","2019/06/01",null),
("Gregory Williams", "148-806-6041", "7383 Moore Port South Cynthia, AZ 50759", "21","2019/06/03",null),
("John Rodriguez", "417-110-5448", "4138 Brian Crossing Stephenville, FL 98844", "17","2019/05/18",null),
("Karen Hill MD", "325-624-0177", "800 Hunt Center Paulview, AZ 72832", "29","2019/02/27",null),
("Mr. Jacob Logan", "207-947-7871", "2224 Gray Inlet Suite 100 Natashaport, LA 52816", "25","2019/04/05",null),
("Monica Davis", "859-660-1556", "841 Ryan Ways Friedmanland, WI 24518", "19","2019/05/12",null),
("Edward Torres", "414-801-2168", "7578 Wang Ranch Apt. 968 Williamstad, TX 36567", "5","2019/05/24",1),
("Jessica Ayers", "411-164-3090", "59057 Karen Stream Cherylhaven, NE 85594", "27","2019/06/02",null),
("David Johnson", "366-423-1657", "32724 Jones Rue New Jameshaven, TX 64302", "18","2019/05/06",null),
("Jessica Moore", "540-017-0836", "1823 French Spur North Manuelbury, NY 27834", "24","2019/04/25",null),
("Derek Robinson", "858-928-6179", "041 Morgan Harbor Apt. 095 Zacharyfort, RI 08365", "15","2019/05/12",null),
("Tiffany Garcia", "969-417-3025", "77769 Sherri Parkways New Victorshire, HI 58729", "9","2019/03/17",null),
("Christian Wilcox", "895-860-9067", "1872 Kenneth Lights Apt. 921 Jessicafort, PA 96891", "26","2019/03/23",null),
("Krystal Walker", "757-625-5891", "3119 English Summit Suite 664 South Elizabeth, VA 80276", "2","2019/04/21",4),
("Taylor Simpson", "532-553-8920", "375 Johnson Ways West Angela, KY 78048", "14","2019/06/01",null),
("Beth Robertson", "888-547-6207", "664 Eugene Inlet Meganchester, SC 58796", "26","2019/05/06",null),
("Rebecca Parker", "778-056-6144", "05752 Goodwin Coves Gibsonstad, NE 99942", "25","2019/05/09",null),
("John Fry", "436-906-0565", "179 Rita Lake Apt. 187 Port Josephberg, FL 45762", "19","2019/05/15",null),
("Mrs. Ashley Sullivan", "853-718-0181", "824 Heather Village New Marystad, CO 78392", "4","2019/03/21",10),
("Malik Schmidt", "101-136-6111", "8425 Holland Pass Apt. 555 Samuelmouth, IA 16925", "26","2019/05/25",null),
("Craig Morse", "715-933-0468", "623 Smith Key Shelbyport, AL 79633", "7","2019/05/11",5),
("Brandon Smith", "538-647-2638", "3610 Autumn Loaf New Melanie, NE 23544", "11","2019/04/11",null),
("Oscar Miller", "351-086-3014", "69472 Andrew Stream Apt. 001 Lake Gregory, NM 12627", "9","2019/05/27",null),
("Wendy Kline", "076-308-9075", "67221 Murphy Shoal Apt. 055 Walkerchester, KY 14903", "28","2019/04/04",null),
("Julie Fisher", "151-211-6440", "2017 Thomas Mission South Allisonland, IL 91759", "28","2019/04/07",null),
("David Velazquez", "497-516-4219", "71766 Sullivan Villages Lake Rachelfurt, ND 63558", "23","2019/05/15",null),

("Karen Perez", "169-976-7291", "8563 Miranda Burg Apt. 096 South Katherineberg, OK 53084", "11","2019/04/20",null),
("Vincent Rivers", "301-738-9469", "814 Jordan Landing Kayleehaven, SC 07462", "16","2019/05/18",null),
("James Robinson", "825-943-5112", "7884 Ashley Lights Apt. 596 Stevenfurt, WV 14582", "13","2019/05/22",null),
("Luis Hernandez", "945-012-8163", "5654 Christopher Curve Hardyville, NV 40921", "10","2019/03/26",null),
("Levi Torres", "362-041-0167", "29940 Sean Summit Apt. 856 West Michele, TN 70742", "25","2019/03/14",null);


select * from customer;



drop procedure if exists customer_data;
DELIMITER $$
CREATE PROCEDURE customer_data(id int)
BEGIN        
SELECT 
    c.id,
    c.name,
    c.contact,
    c.address,
    c.active_date,
    s.service AS s_name,
    s.validity AS s_validity,
    s.data AS s_volume,
    s.speed AS s_speed,
    s.price AS s_price,
    s.type AS s_type,
    d.device AS d_name,
    d.description AS d_description,
    d.price AS d_price
FROM
    customer c
        LEFT OUTER JOIN
    service s ON c.service_id = s.id
        LEFT OUTER JOIN
    device d ON c.device_id = d.id OR c.device_id = NULL
	WHERE c.id =id;
END$$ 
DELIMITER ;

call customer_data(1);


drop procedure if exists customers_data;

DELIMITER $$
CREATE PROCEDURE customers_data()
BEGIN        

SELECT 
    c.id,
    c.name,
    c.contact,
    c.address,
    c.active_date,
    s.service AS s_name,
    s.validity AS s_validity,
    s.data AS s_volume,
    s.speed AS s_speed,
    s.price AS s_price,
    s.type AS s_type,
    d.device AS d_name,
    d.description AS d_description,
    d.price AS d_price
FROM
    customer c
        LEFT OUTER JOIN
    service s ON c.service_id = s.id
        LEFT OUTER JOIN
    device d ON c.device_id = d.id OR c.device_id = NULL

GROUP BY c.id
ORDER BY c.id;

END$$ 
DELIMITER ;

call customers_data();


drop table if exists fa_Cash;
CREATE TABLE fa_Cash (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT UNSIGNED NOT NULL,
    date date
);

INSERT into fa_Cash (type, amount, date) values ("Debit", 1000, "2019/05/15");

drop table if exists fa_AP;
CREATE TABLE fa_AP (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);

drop table if exists fa_AR;
CREATE TABLE fa_AR (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);

CREATE TABLE fa_Rev (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);

drop table if exists fa_Exp;
CREATE TABLE fa_Exp (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);


drop table if exists fa_OW;
CREATE TABLE fa_OW (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);


drop table if exists fa_OC;
CREATE TABLE fa_OC (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT NOT NULL,
    date date
);

insert into fa_OC (type, amount, date) values ("Credit", 1000, "2019/05/15");

drop table if exists fa_Account;
create table fa_Account(
	id int not null primary key auto_increment,
    name varchar(50) not null unique key,
    type ENUM('Cash', 'Asset', 'Liability', 'OC', 'OW', 'Revenue', 'Expense')
);

insert into fa_Account(name, type) values 
("Cash", "Cash"),
("AP", "Liability"),
("AR", "Asset"),
("OC", "OC"),
("OW", "OW");

SELECT 
    *
FROM
    fa_Account;

CREATE TABLE fa_Transaction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    trans_type ENUM('Normal', 'Closing', 'Adjustment')
);

drop table if exists fa_Entry;
CREATE TABLE fa_Entry (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('Debit', 'Credit'),
    amount INT UNSIGNED NOT NULL,
    account_name VARCHAR(50) NOT NULL,
    trans_id INT NOT NULL,
    FOREIGN KEY (trans_id)
        REFERENCES fa_Transaction (id)
        ON DELETE CASCADE,
    FOREIGN KEY (account_name)
        REFERENCES fa_Account (name)
        ON DELETE CASCADE
);

insert into fa_Transaction (id, date, trans_type) values
(1, "2019/05/15", "Normal");

insert into fa_Entry (type,amount,account_name,trans_id) values
("Debit", 1000, "Cash", 1),
("Credit", 1000, "OC", 1);

select * from fa_Entry;

drop procedure if exists entries_data;

DELIMITER $$
CREATE PROCEDURE entries_data()
BEGIN        

SELECT 
    e.*,
    t.date as trans_date,
    t.trans_type as trans_type,
    a.type as account_type
FROM
    fa_Entry e
        LEFT OUTER JOIN
    fa_Transaction t ON e.trans_id = t.id
        LEFT OUTER JOIN
    fa_Account a ON e.account_name = a.name
ORDER BY e.type, t.id ;

END$$ 
DELIMITER ;

call entries_data();

drop procedure if exists entry_data;

DELIMITER $$
CREATE PROCEDURE entry_data(id int)
BEGIN        

SELECT 
    e.*,
    t.date as t_date,
    t.trans_type as t_type,
    a.type as a_type
FROM
    fa_Entry e
        LEFT OUTER JOIN
    fa_Transaction t ON e.trans_id = t.id
        LEFT OUTER JOIN
    fa_Account a ON e.account_name = a.name
	where e.id = id;
		
END$$ 
DELIMITER ;

call entry_data(1);

