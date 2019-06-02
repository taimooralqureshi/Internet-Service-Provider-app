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
    status VARCHAR(18) DEFAULT 'active',
    device_id INT null,
    FOREIGN KEY (service_id)
        REFERENCES service (id)
        ON DELETE CASCADE,
	FOREIGN KEY (device_id)
        REFERENCES device (id)
        ON DELETE CASCADE
);

insert into customer (name,contact,address,service_id,status,device_id) values
("Cynthia Shepard", "666-892-9419", "44071 Taylor Island Suite 587 East Matthewport, RI 72635", "18","active",null),
("Patricia Mullins", "421-355-3059", "0988 Ramos Shoals Apt. 713 West Joe, SD 63850", "20","active",null),
("Jessica French", "936-209-1107", "68183 Daniel Light Apt. 957 South Devinside, ID 06097", "24","active",null),
("Joshua Orr", "834-388-7568", "02755 Diana Road Apt. 217 Andrewberg, NM 56825", "5","active",3),
("Christopher Kennedy", "120-668-4941", "95395 Johnson Center Apt. 144 Lauraburgh, MN 41371", "12","deactive",null),
("Robert Henderson", "116-090-7631", "568 Walker Road Suite 886 Taylorside, TN 85754", "3","deactive",10),
("Robert Ayala", "720-541-6887", "9178 Payne Street Meaganmouth, AZ 27983", "3","deactive",3),
("Nicole Singh", "574-702-7463", "207 Green Dale Apt. 109 New James, IL 40356", "1","active",9),
("Jonathan Jones", "950-796-2740", "5279 Rhonda Springs South Christinachester, MA 49185", "8","active",9),
("Rebecca Nelson DDS", "257-574-5339", "20449 Holt Landing Apt. 809 Port Kimberlyport, NH 38270", "18","active",null),
("Julie Flores", "791-990-7705", "1595 Justin Cliff Suite 669 Kevinhaven, OK 85203", "9","active",null),
("Elizabeth Turner", "048-564-8017", "499 Gordon Centers Port Samantha, FL 09164", "14","deactive",null),
("James Ramos", "155-923-6410", "581 Thompson Prairie South Michellehaven, OR 00948", "20","active",null),
("Nicholas Brown", "318-861-3616", "USNS Schultz FPO AA 89954", "25","deactive",null),
("Shannon Miller", "885-346-2265", "696 Rowe Pike Mitchellbury, AL 76680", "9","active",null),
("Rachel Hughes", "168-179-4404", "711 Craig Locks Lake Adamstad, MS 06297", "18","deactive",null),
("Lauren Whitehead", "061-957-2679", "194 Tonya Street West Chelseyton, ND 95307", "1","active",6),
("Troy Young", "164-012-0878", "PSC 3364, Box 1961 APO AA 09622", "27","deactive",null),
("Margaret Reyes", "308-667-1916", "146 Carrie Loop Apt. 177 Traceyhaven, SC 51467", "8","active",6),
("Kristine Romero", "226-994-8508", "0061 Timothy Hills Apt. 861 New Scott, MI 70047", "10","deactive",null),
("Cheryl Price", "352-443-3882", "833 Howard Hollow Apt. 307 East Joshuabury, LA 79753", "6","active",3),
("Melissa Jones", "083-447-5299", "853 Bishop Islands New Michael, NC 18897", "1","active",8),
("Mr. Kevin Kane", "279-393-4348", "66834 Johnson Coves Apt. 580 Meganville, VA 82297", "27","deactive",null),
("Sandra Williamson", "468-988-0488", "56779 Teresa Harbor Suite 131 Franciscoview, FL 46884", "24","active",null),
("Melissa Hamilton", "560-730-5636", "3462 Leah Courts Hamptonfurt, IA 73211", "20","active",null),
("Abigail Davis", "530-428-3667", "51631 Rice Lights Vincentton, NJ 67213", "3","deactive",10),
("Christopher Arias", "296-953-9790", "USCGC Ortiz FPO AA 46212", "11","active",null),
("Anthony Mcclain", "675-131-0935", "028 Mary Pike Suite 810 Jonesfort, AK 51469", "29","active",null),
("Ashley Velez", "321-966-9587", "29183 Jonathan Forest Suite 636 Lake Tiffanybury, ND 34121", "10","deactive",null),
("Daniel Bradford", "692-577-3412", "277 Katrina Ramp Suite 166 Jermainefurt, ID 41618", "19","active",null),
("Joel Johnson", "903-864-7310", "8047 Andrew Stravenue Johnsonville, FL 09898", "25","deactive",null),
("Jeremy Burnett", "164-582-7022", "9057 Lucero Village Apt. 143 North Kathy, CO 26337", "5","active",7),
("Michelle Duran", "675-070-4297", "2665 David Cliff Theresaburgh, AK 42430", "3","active",5),
("Michelle Fry", "596-770-3485", "55785 Campos Curve Aliciaburgh, MI 43808", "5","active",7),
("Christina Morrison", "443-655-9553", "780 Peterson Spurs Apt. 992 Jasonside, UT 13727", "24","active",null),
("Reginald Hill", "896-445-6653", "3236 Tyler Highway Antonioborough, NY 18194", "8","active",9),
("Kim Larson", "932-604-3152", "8974 Silva Point Lake Michaelside, MO 77873", "25","active",null),
("Emily Coleman", "179-886-7739", "14984 Wood Stravenue Apt. 541 Davidstad, NV 90102", "3","active",2),
("Sabrina Hayes", "071-458-8979", "684 Woods Mills Suite 888 Glennland, CA 77187", "29","active",null),
("Nicholas Freeman", "932-999-2230", "87594 Ray Shores Suite 203 Timothyton, TX 26679", "9","active",null),
("Nancy Johnson", "356-173-3347", "449 Blankenship Turnpike Suite 865 Kaneland, LA 32565", "21","active",null),
("Jason Johnson", "141-699-0703", "USNV Simpson FPO AA 44645", "12","active",null),
("Laurie Bender", "808-733-8244", "90678 Shari Drive Nicholsstad, IL 18252", "6","deactive",8),
("Ann Barnes", "077-078-0234", "79318 Aaron Divide Suite 134 Sarahhaven, DE 09764", "15","deactive",null),
("Stephanie Knapp", "902-043-7513", "461 Reed Meadows Suite 371 Davidmouth, NH 68505", "1","active",7),
("Tom Johnson", "455-664-3318", "Unit 6213 Box 2450 DPO AE 94284", "10","active",null),
("Michael Nichols", "093-667-1417", "40880 Jamie Lights Suite 512 East Jodymouth, FL 16971", "12","active",null),
("Seth Cabrera Jr.", "825-595-8441", "01000 Kara Ports Suite 931 Marshallside, ID 56509", "12","active",null),
("Thomas Floyd", "705-503-2926", "60886 Jessica Rapid Apt. 484 Markstown, CT 72588", "27","active",null),
("Megan Hale", "023-719-0565", "89068 Michelle Views Ginaland, VT 60770", "5","deactive",9),
("Colin Watson", "192-286-4760", "89480 Scott Groves Apt. 226 Markland, PA 19404", "24","deactive",null),
("Briana Warren", "057-442-1175", "30387 James Mountains North Jamesmouth, VA 06497", "13","active",null),
("Brian Price", "331-510-1658", "1476 Robinson Motorway South Reneebury, ND 86063", "20","deactive",null),
("Sarah Wu", "056-136-8045", "128 Kevin Crescent Barnesshire, UT 24496", "11","active",null),
("Donald Thomas", "409-373-6259", "7625 Jackson Run Daniellefort, NY 32500", "8","active",3),
("Michael Greer", "454-107-4151", "969 Elizabeth Rest Davidton, MS 86383", "13","active",null),
("Kevin Wright", "862-044-0406", "434 Jennifer Manor Orozcochester, MN 02871", "29","active",null),
("Benjamin Fischer", "624-447-1435", "20994 Sweeney Square East Robert, PA 19845", "11","active",null),
("Dwayne Keller", "162-743-5797", "67209 Ryan Drive Whitebury, NH 24628", "21","active",null),
("Rachel Mcdonald", "770-442-3907", "4257 Stephen Forest Suite 749 West Jeffreybury, NH 39955", "28","active",null),
("Melissa Flores", "589-087-6308", "USCGC Edwards FPO AE 14547", "1","active",6),
("Vanessa Massey", "761-876-5381", "1260 Louis Expressway Apt. 817 Watsonberg, OH 17297", "5","active",7),
("Lori Copeland", "472-114-4647", "29681 Parks Summit Suite 917 Lake Ashley, FL 77686", "11","active",null),
("Robert Sanchez", "172-666-0253", "77532 Sheppard Mills Gomezbury, PA 46804", "17","deactive",null),
("Ashley Campbell", "476-393-5451", "USNV Martin FPO AE 05204", "14","active",null),
("James Bray", "354-600-5187", "79235 Sharon Turnpike Apt. 627 East Christineside, MO 31421", "14","active",null),
("Cheryl Mathews", "879-771-6789", "2745 Kathy Islands West Levifurt, CA 15780", "28","active",null),
("David Franklin", "540-768-5162", "17975 Ballard Camp Port Jessicachester, MI 42615", "14","deactive",null),
("Jessica Rodriguez", "016-586-2812", "94199 Kimberly Locks Port Beverlyborough, MT 28443", "14","active",null),
("Christine Sandoval", "390-385-6246", "13812 Reeves Island Suite 463 Davidsonside, SC 65394", "23","deactive",null),
("Tammy Collins", "021-456-8907", "351 Sarah Course Erinshire, NJ 52184", "1","active",7),
("Elizabeth Foster", "157-673-1527", "846 Anderson Mews Rileyview, ND 74246", "27","active",null),
("Michael Zimmerman", "056-432-2644", "4878 Cassandra Dale South Barbaraburgh, MI 80162", "10","active",null),
("Matthew Daniels", "907-649-0128", "0889 April Wall Suite 513 South Codyfurt, NH 35701", "4","active",9),
("Wayne Jacobs", "014-321-1629", "85852 Jensen Green Lake Jenniferport, KS 36005", "19","active",null),
("Christine Diaz", "192-267-8359", "6192 Herman Groves Lake Jessicabury, ID 76004", "21","active",null),
("Sandra Simmons", "054-813-1112", "11984 John Ford North Russell, OK 03555", "25","deactive",null),
("Joe Smith", "066-219-2848", "4644 Jason Orchard Apt. 332 East Joshuamouth, NH 00855", "18","active",null),
("Jessica Hansen", "320-489-8874", "1107 Anthony Ferry Apt. 509 North Jorgefort, DE 68926", "29","active",null),
("Tiffany Warren", "522-858-8564", "374 Garcia Roads Suite 054 Lake Juliemouth, KY 40752", "21","deactive",null),
("Kimberly Rodriguez", "701-258-6238", "PSC 4258, Box 0396 APO AP 53462", "2","deactive",10),
("Jordan Johnson", "325-121-2552", "09497 Dunn Prairie Lake Michael, MI 29536", "24","active",null),
("Jacqueline Price", "344-564-4665", "11105 Heather Crest Jeffreyside, OR 72373", "19","deactive",null),
("Michelle Jackson", "645-115-8763", "806 Joseph Extension New Troy, WA 87890", "26","active",null),
("Amy Turner", "131-926-7986", "35824 Kelly Station Apt. 968 Angelaberg, IL 37739", "21","active",null),
("Rachel Bauer", "416-948-6169", "4117 Kathleen Courts Abigailton, DC 46715", "13","deactive",null),
("Tabitha Lambert", "930-156-7779", "13783 Sandra Mountain Suite 397 Tiffanyshire, MT 43264", "26","active",null),
("Pamela French", "008-026-6486", "08351 Christensen Glens Nataliefurt, KS 18126", "15","deactive",null),
("Jesse Stewart", "295-576-8652", "3699 Ortiz Valleys Apt. 852 Port Edward, DE 27348", "19","active",null),
("Tyler Hall", "597-724-2953", "2355 John Ville Suite 211 Briannachester, NE 81736", "24","deactive",null),
("Adam Baker", "037-952-9044", "9799 Flores Mountain Suite 285 North Christopher, KS 42079", "9","active",null),
("Alexander Turner", "411-570-9008", "87215 Brown Burg Suite 584 New Tara, NM 31889", "21","active",null),
("Tanya Spencer", "589-004-4234", "5207 Derek Islands Evanston, LA 65351", "8","active",9),
("Logan Peterson", "720-733-7884", "9316 Amber Path Sheltonville, MS 09450", "6","active",4),
("Samantha Day", "264-999-8002", "5817 Houston Lake North Jeremiahfort, DC 55939", "11","deactive",null),
("Sean Tucker", "959-805-2863", "846 James Cove Suite 330 Carolberg, SC 55183", "24","active",null),
("Julie Zhang", "905-494-5323", "128 Michelle Parkways South Michaelmouth, AZ 11017", "27","deactive",null),
("Bradley Bright", "700-240-0835", "46799 Lisa Mountains Apt. 229 Smithberg, SD 93797", "3","active",2),
("Virginia Welch", "067-259-6158", "5424 Christopher Light Lake Michael, NE 45045", "22","active",null),
("Derrick Clark", "092-116-8358", "10900 Kimberly Heights Suite 408 West Nicoleport, AZ 84064", "11","deactive",null),
("Brian Stephenson", "190-398-3007", "83241 Harmon Trafficway East Peggy, LA 89919", "13","deactive",null),
("Dr. Patricia Browning", "074-699-0963", "USS Gallagher FPO AP 15832", "10","active",null),
("John Smith", "654-765-4005", "27740 Michael Shoal Apt. 697 Zimmermanland, AL 45278", "28","deactive",null),
("Stephen Collier", "149-139-5439", "0040 Matthew Center Rogerburgh, IA 76360", "21","active",null),
("Latoya Clements", "722-710-8034", "76658 Dixon Crest East Lindaburgh, AR 27685", "14","active",null),
("Miss Melissa Gay", "008-019-9944", "Unit 1180 Box 6141 DPO AP 31874", "18","active",null),
("Matthew Mcintosh", "743-092-4642", "041 Kenneth Manor Suite 778 East Sandra, LA 91956", "13","active",null),
("Brett Marshall", "146-874-5132", "1911 Katherine Lane Apt. 651 Pamelahaven, GA 56093", "28","deactive",null),
("Wayne May", "420-255-9835", "81354 Alexis Wall New Nicole, MS 70897", "23","active",null),

("Mason Hansen", "235-819-5654", "26564 Baldwin Lakes North Paulstad, IL 12941", "12","active",null),
("Donald King", "137-025-7468", "USCGC Clark FPO AE 02401", "11","active",null),
("Mr. Charles Cummings", "580-239-1922", "7425 James Flat Port Dawn, NH 43368", "21","deactive",null),
("Michael Jimenez", "334-737-1306", "2638 Rebecca Roads Ericstad, MD 13426", "24","active",null),
("Christy Moore", "161-141-0860", "Unit 1005 Box 1268 DPO AE 60977", "27","active",null),
("Stephen Gray", "734-770-4841", "640 Watkins Wells Suite 265 Rileyside, ND 86437", "15","deactive",null),
("Jo Patterson", "427-338-1516", "964 Cannon Manor Apt. 536 Port Bradleymouth, RI 23808", "6","deactive",4),
("Jason Sharp", "054-537-6603", "5978 Sanchez Stream Apt. 724 Port Joycefort, MA 40778", "9","active",null),
("Andrew Rios", "373-254-3566", "1024 Doyle Valley Suite 735 Washingtonshire, KS 58711", "15","deactive",null),
("Tiffany Levine", "183-187-3462", "1488 Brian Fort Apt. 114 New Jessica, NJ 63080", "16","deactive",null),
("Megan Leon", "368-860-3237", "Unit 2327 Box 7984 DPO AA 97981", "22","active",null),
("Andrew Smith", "751-036-4865", "840 Janet Grove Suite 462 Fostertown, SD 53629", "2","active",4),
("David Campbell", "498-197-1535", "61701 Newman Common East Alexanderburgh, NM 53306", "1","active",6),
("Hannah Chase", "085-928-5325", "102 Mendez Street Suite 496 North William, AZ 21588", "24","active",null),
("Jeremy Page", "879-824-1372", "63783 Kimberly Falls Lake Derrickberg, MN 38707", "25","active",null),
("Annette Hendrix", "200-705-1549", "4929 Crane Cliff Apt. 431 Garciaville, OH 98767", "11","active",null),
("Matthew Oliver", "922-362-3126", "80824 Richard Island Maryhaven, NE 75398", "14","active",null),
("Dr. Robert Farmer", "045-191-0002", "082 Buchanan Islands Suite 186 Cobbborough, SD 32714", "5","active",7),
("Jonathan Avery", "883-213-4808", "354 Barbara Ramp Apt. 759 Darrenhaven, CT 33535", "5","active",10),
("Jeffery Arnold", "415-755-9846", "956 Webb Well Suite 189 Georgehaven, ID 73181", "20","active",null),
("Jessica Thornton", "850-748-0040", "05523 Jackson Ramp Suite 893 Jonesberg, ND 84943", "21","active",null),
("Matthew Patterson", "920-154-8706", "2283 Jacob Spring North Victoria, UT 29951", "23","deactive",null),
("Mary Edwards", "514-600-6526", "561 Nicholas Mount Garciamouth, IL 69641", "4","deactive",1),
("Heather Gillespie", "435-249-3369", "PSC 3400, Box 5509 APO AE 98566", "14","deactive",null),
("Carol Morse", "790-716-2503", "2367 Dustin Grove Apt. 669 East Michael, MI 05977", "9","deactive",null),
("Mary Macias", "391-955-9463", "5597 Amy Highway Apt. 917 South Matthewchester, AZ 19333", "6","active",4),
("Chelsea Soto", "653-775-2889", "USCGC Rangel FPO AA 70041", "4","deactive",8),
("Nicholas Romero", "662-467-0170", "6103 Smith Village Apt. 683 Nicholasport, AR 72682", "4","active",2),
("Elizabeth Hancock", "391-878-6188", "1532 Debbie Orchard West Christinaborough, AZ 01115", "10","deactive",null),
("Theresa Santana", "935-382-9272", "53191 Alexis Lock East Evelynberg, IN 10409", "1","active",9),
("Heather Williams", "417-398-0221", "594 Lopez Junction Suite 415 New Dean, NM 45163", "24","active",null),
("Maria Bradley", "051-783-6089", "363 Morgan Village Suite 970 Lake Donna, NC 92740", "2","active",2),
("Kelly Jordan", "592-213-1458", "18977 Sarah Ville Williamfurt, CA 13162", "28","active",null),
("John Lee", "130-682-4355", "96050 Kline Bypass New Allisontown, AZ 23439", "6","active",3),
("Megan Collins", "437-613-0174", "56010 Ochoa Loop Suite 645 Lake Gregoryberg, MO 31849", "29","active",null),
("Rachel Mccarthy", "343-047-2023", "252 Adams Rapid Deborahtown, IN 97679", "23","active",null),
("Samuel Rodriguez", "017-547-3915", "8695 Martin Squares Lake Luis, OH 91376", "13","active",null),
("John Melton", "199-006-6829", "9488 Roger Mountains Pamborough, MI 37862", "12","deactive",null),
("Trevor Parks", "157-889-4097", "069 Kelley Mountains Lake Christopher, KY 41080", "29","active",null),
("Tracy Murphy", "149-187-1165", "49767 Martin Ramp Andradeport, SC 54295", "16","active",null),
("Courtney Shannon", "742-139-2004", "02893 Jessica Pike Apt. 109 Jodibury, IN 23524", "21","active",null),
("Nathan Gomez", "573-015-7354", "795 Farmer Garden Kathrynstad, IL 79732", "13","active",null),
("Denise Coleman", "619-789-9074", "1074 Harris Port Suite 900 Jamesburgh, ND 67043", "13","active",null),
("Ernest Benitez", "032-245-0636", "USNV Robinson FPO AP 68775", "24","active",null),
("Michael Martin", "205-918-6422", "9751 Robin Hollow South Christina, GA 85651", "18","active",null),
("Marc Wilson", "920-145-8880", "50262 Sandra Crossing Heathertown, KS 97255", "11","deactive",null),
("Kyle Patton", "255-545-7866", "USCGC Oconnell FPO AP 14764", "12","active",null),
("Daniel Austin", "542-948-1805", "7701 Bradley Hill Hugheston, OH 93459", "20","active",null),
("Tiffany Moran", "144-485-4055", "3357 Miller Causeway Russelltown, NM 68041", "8","active",7),
("James Romero", "918-524-1917", "PSC 5071, Box 6217 APO AE 57661", "28","active",null),
("Angela Reyes", "173-808-1612", "870 Jillian Haven Suite 006 Lake Anthony, VT 92182", "18","deactive",null),
("Susan Brown", "060-084-5000", "5004 Rich Crest Castroport, IN 02917", "23","active",null),
("Angela Gonzalez", "606-134-0907", "09938 Lauren Port Suite 129 Williammouth, WA 44733", "6","active",9),
("Connor Perez", "442-119-4034", "Unit 5136 Box 6083 DPO AA 44008", "16","deactive",null),
("Alicia Ramirez", "146-712-6283", "534 Kevin Squares Suite 653 Lake Ianmouth, NC 85524", "13","active",null),
("Caleb Jones", "291-470-1748", "48665 Scott Fords Leonardberg, KS 74796", "4","active",4),
("Bridget Parker", "402-355-5329", "7871 Petty Valley Suite 733 Port Jason, UT 26326", "2","active",10),
("Dylan Pearson", "264-974-2845", "596 Maldonado Points East Nancy, OK 18783", "5","active",6),
("Tyler Castro", "230-692-4990", "3125 Powers Point Suite 391 Angelatown, DC 22866", "25","active",null),
("Katherine Schmidt", "403-325-1904", "07165 Diane Camp Helenmouth, FL 26133", "14","deactive",null),
("Cindy Hopkins", "206-831-3856", "PSC 2125, Box 2666 APO AP 49340", "1","active",8),
("George Hill", "457-739-8473", "PSC 2856, Box 2969 APO AE 79090", "17","active",null),
("Devon Chung", "100-272-5022", "69926 Joseph Coves Apt. 101 South Andrew, IL 05175", "1","deactive",6),
("Jason Jones", "092-074-0238", "USCGC Bennett FPO AE 81671", "3","active",9),
("Sharon Gordon", "827-659-4310", "48730 Castillo Lights North Juan, MI 33891", "7","active",2),
("Crystal Davila", "211-091-6048", "427 John Lake East Paulmouth, IL 66735", "11","active",null),
("Mr. Johnny Roy", "412-424-8378", "500 Williams Stravenue Apt. 010 North Jeremy, CO 23491", "9","deactive",null),
("James Benjamin", "831-306-3858", "1657 Cannon Stravenue Apt. 665 Emilymouth, MI 17808", "22","active",null),
("Mark Martin", "726-992-3452", "493 Ashlee Courts Apt. 694 North Amy, WA 88147", "26","active",null),
("Jennifer Brown", "182-692-1415", "69509 Martin Bridge Guerrerofurt, TN 10095", "13","active",null),
("Richard Farmer", "127-831-1474", "287 Johnson Field Suite 299 Edwardstown, ID 48383", "21","active",null),
("Jasmine Hall", "378-486-0927", "1869 Chen Road East Stevebury, NM 98094", "5","deactive",4),
("Debbie Williams", "849-736-7428", "7367 Vasquez Manors Apt. 304 Brownland, GA 67258", "12","active",null),
("Roy Hill", "796-145-2826", "7694 Booth Pine South Harry, HI 25130", "12","active",null),
("Daniel Gordon", "085-788-4623", "6106 Jennifer Prairie Suite 954 Stewartton, RI 12248", "1","active",4),
("William Wyatt", "815-393-4767", "03291 Tate Landing Suite 077 Port Keithfort, MS 74437", "22","active",null),
("Diane Garza", "752-982-8607", "6771 Garrett Manors South Carrie, AR 28826", "5","active",1),
("Spencer Olson", "994-295-8330", "734 Brian Squares Port Debbie, MI 81335", "23","active",null),
("Jennifer Higgins", "019-933-0956", "91653 Diaz Shore Phillipchester, PA 11862", "7","active",6),
("Melissa Gonzalez", "821-009-9816", "6916 Bradley Cliff Austinborough, NE 57246", "23","deactive",null),
("Robert Bailey", "323-329-5658", "429 Patel Neck Suite 281 Sarafurt, PA 24972", "26","deactive",null),
("Gina Smith", "576-310-8199", "64822 Harrison Parks Port Brookeside, IA 86610", "3","active",3),
("Chelsea Becker", "140-713-9557", "14782 Tucker Pines West Jasonstad, ID 15187", "27","active",null),
("Johnathan Sims", "604-889-0914", "508 Willis Mill Apt. 376 Spencerside, SD 80517", "26","active",null),
("Stephanie Lee", "361-719-9218", "6208 John Pass Apt. 285 Maureenstad, AZ 89970", "19","active",null),
("Tyler Perez", "233-579-6550", "685 Torres Plains Suite 272 Salazarside, WY 91839", "26","deactive",null),
("Brian Scott", "026-186-8856", "4506 Michael Tunnel Gardnermouth, AK 47360", "24","deactive",null),
("Stacey Marquez", "713-048-9188", "Unit 9876 Box 7257 DPO AP 10199", "18","active",null),
("Elizabeth Brown", "708-206-9677", "612 Heather Prairie Apt. 552 North Rebeccaport, UT 79126", "5","active",1),
("Christopher Torres", "872-070-0440", "1775 Joseph Junction Apt. 860 East Erin, AR 84681", "3","active",1),
("Deanna Patel", "138-466-9495", "192 Pierce Lodge Jonfort, OR 30380", "23","active",null);


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
    c.status,
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
    c.status,
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

/*
SELECT 
    c.id,
    c.name,
    c.contact,
    c.address,
    c.status,
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
*/