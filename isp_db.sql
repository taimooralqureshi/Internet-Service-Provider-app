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
("Kristen Mcmillan", "266-060-4356", "USS Reed FPO AP 35781", "17","active",null),
("Dakota Mejia", "208-017-6255", "316 Gina Crossroad Fieldsstad, MO 52307", "22","deactive",null),
("David Rodgers", "056-067-8301", "Unit 8409 Box 2618 DPO AE 07433", "23","deactive",null),
("Meghan Turner", "072-892-3025", "6831 Amanda Orchard Port Lauren, AK 38126", "10","deactive",null),
("Darlene Beasley", "694-786-3246", "87093 Tran Circle South Christine, MO 07624", "17","active",null),
("Brenda Burke", "439-303-4309", "8846 Gregory Freeway West Rita, HI 56976", "8","deactive",null),
("Melissa Arnold", "785-535-7150", "56235 Daniel Stream Apt. 955 Christopherborough, MN 36136", "29","active",null),
("John Brooks", "667-824-1721", "597 Mckee Park Pattersonhaven, NY 51903", "18","active",null),
("Daniel Zuniga", "657-373-2403", "6708 Jacobs Turnpike Suite 054 New Jenniferchester, NE 15181", "14","deactive",null),
("David Young", "399-516-9906", "Unit 6104 Box 0024 DPO AA 83360", "1","active",7),
("Patrick Richardson", "293-464-8730", "62662 Peter Roads Carsonfurt, SD 83552", "17","active",null),
("Steven Walter", "322-464-7307", "68351 Anthony Villages Clinefurt, HI 18291", "8","deactive",null),
("Tanya Nelson", "675-579-8592", "66704 Thomas Pines West Davidberg, LA 47548", "6","deactive",9),
("Jamie Burns", "273-689-0031", "3594 Joel Walks Suite 160 Leeport, IN 43593", "25","active",null),
("William Lucas", "697-896-9001", "USCGC Gonzalez FPO AE 87165", "15","active",null),
("Andrea Melton", "912-861-9951", "453 Adriana Trafficway Lake Sierra, OH 47567", "20","active",null),
("Joshua Ramos", "536-096-1261", "11562 Phillips Green Stevenstown, IN 12429", "4","active",9),
("Richard Boyer", "047-599-9642", "419 Francisco Mill Suite 900 North Michelle, NV 16228", "24","deactive",null),
("Kara Mckee", "076-667-8758", "00760 Ian Point East Jeremybury, MI 22783", "26","active",null),
("Amanda Cunningham", "965-947-9584", "5516 Joanne Ford New Richard, IL 33944", "26","active",null),
("Erica Francis", "686-319-1995", "6486 Davidson Manor Apt. 254 East Pamela, ND 31854", "28","deactive",null),
("Megan Vaughn", "322-794-3353", "764 Felicia Rapid Port Laura, OK 07548", "14","deactive",null),
("Trevor Hudson", "294-050-4839", "PSC 2772, Box 5705 APO AE 19703", "22","active",null),
("Christopher Thompson", "478-893-0618", "024 Cody Mission South Dennisborough, RI 87682", "2","active",4),
("Donald Matthews", "876-187-2488", "PSC 4508, Box 4224 APO AP 90914", "21","active",null),
("Renee Higgins", "841-993-4949", "977 Turner Roads New Jorge, IA 25318", "5","active",2),
("Joy Barnes", "153-504-5505", "6206 Howard Garden Apt. 765 New Daniellechester, IN 71617", "29","active",null),
("Anthony Anderson", "994-143-5741", "45027 Brewer Fords Perkinsborough, MN 01385", "25","active",null),
("David Powell", "523-206-3394", "2717 Petty Forks Mariaside, NV 43530", "27","active",null),
("Jessica Munoz", "141-773-8668", "57060 Matthew Stream Suite 027 Andrewbury, MI 92524", "7","active",8),
("Cory Graves", "562-407-4683", "059 James Lodge Apt. 117 Dillonton, ME 44186", "27","active",null),
("Ashley Carrillo", "129-817-1981", "96068 Jeremy Stream Apt. 361 South Paul, VT 10678", "27","active",null),
("Dr. Aaron Santiago DVM", "661-355-9952", "73504 Garza Creek Port Brian, RI 48523", "16","active",null),
("Stephanie Aguilar", "468-133-9442", "USS House FPO AP 21049", "28","deactive",null),
("Troy Nichols", "485-703-9009", "126 Lisa Extensions North Joannchester, DE 64217", "27","active",null),
("Matthew Adams", "468-132-9512", "70765 Tracy Row Suite 136 South Philip, WV 16300", "4","deactive",4),
("Amanda Reed", "351-343-4694", "97973 Timothy Drive North Kathrynstad, KY 05258", "21","active",null),
("Jill Dillon MD", "612-263-6135", "90777 Andrew View Suite 540 Lake Tracy, AR 51513", "12","active",null),
("Andrea Manning", "402-446-9395", "4317 Gonzalez Union Rodriguezshire, MA 93375", "1","active",9),
("Gina Rodriguez", "587-926-5705", "48825 Holland Mountain Tonyhaven, WV 38342", "12","active",null),
("Brian Myers", "328-062-4179", "00063 Russell Cliffs Joannechester, NV 35892", "20","active",null),
("Richard Leon", "169-666-7114", "21776 Smith Parkway Apt. 210 Montgomerychester, WV 58092", "6","deactive",2),
("Michele Ramsey", "174-432-1523", "531 Torres Centers Apt. 956 Parkermouth, GA 83472", "18","active",null),
("David Nguyen", "898-613-7612", "1661 Solomon Orchard Langburgh, SC 66906", "5","deactive",5),
("Sergio Barnes", "289-438-0582", "14161 Lynn Cape East Scottton, IL 07695", "3","active",3),
("Tyler Brown", "274-450-9400", "112 Jenkins Tunnel West Patrickport, IL 56996", "22","active",null),
("Victor Thomas", "244-015-8921", "4827 Darrell Creek Acostashire, HI 71600", "2","active",8),
("Christopher Mendez", "212-173-7678", "Unit 4271 Box 1255 DPO AA 07469", "9","active",null),
("Jimmy Mcknight", "017-312-3930", "30630 Smith Meadows Apt. 250 East Johnny, KS 40999", "24","active",null),
("Brittany Medina", "334-588-1501", "623 Jocelyn Terrace Apt. 734 New Travisfurt, NE 08425", "9","active",null),
("John Ferguson", "772-485-7308", "35880 Ashley Motorway Suite 052 Andersonhaven, WA 33779", "23","active",null),
("David Williams", "769-782-3685", "6683 Camacho Mission West Ann, NY 83593", "1","active",2),
("Evan Sanders", "198-874-0820", "74575 Martinez Port New Jenniferborough, NJ 24014", "4","active",9),
("Connie Haney", "744-996-9747", "1628 Johnson Cape Suite 629 New Christinashire, VT 33365", "12","active",null),
("Karen Wilson", "467-724-9951", "839 Carrie Summit West Danielville, WI 75297", "20","active",null),
("Robert Davis", "130-426-6374", "USNS Lewis FPO AP 67755", "20","active",null),
("Jeremy Baker", "831-074-4781", "7957 Max Course Suite 019 Nicholasmouth, MN 80751", "20","active",null),
("Kari Rodriguez", "885-807-7820", "725 Christina Square Bautistaville, CT 09181", "24","active",null),
("Carrie Kane", "042-703-8152", "2500 Daniels Glens Stevenmouth, CA 76289", "4","active",10),
("Mr. Aaron Miller", "577-837-7144", "54656 Wilson Roads Bakershire, VA 51339", "10","deactive",null),
("Karen Carter", "144-212-4801", "Unit 2113 Box 5584 DPO AP 63036", "25","active",null),
("Nathaniel Braun", "722-516-8865", "9575 Gabriel Forks Suite 619 New Paulfurt, NC 83118", "22","active",null),
("Maria Ortiz", "287-604-8802", "7217 Francisco Islands Apt. 757 Brandonland, IL 91704", "25","active",null),
("David Smith", "625-542-9836", "348 Stephanie Valleys Suite 665 North Bryan, NJ 26771", "6","active",6),
("Matthew Miller", "512-800-6917", "823 Newton Ports North Amanda, NH 44138", "4","active",9),
("Matthew Hernandez", "269-766-6943", "5477 Williams Route Apt. 421 Port Jeffreyfort, TN 33550", "20","deactive",null),
("Kelli Hall", "292-911-8301", "PSC 5790, Box 2628 APO AP 87026", "8","active",null),
("Frank Dickerson", "421-202-6384", "0736 Christine Roads West Charles, CO 78721", "13","active",null),
("John Wilson", "932-952-0201", "77972 Destiny Throughway Suite 372 West Lori, CT 18769", "14","active",null),
("Linda Campbell", "989-862-6675", "19910 Hart Points Mooreside, MI 51389", "11","active",null),
("Derek Hicks", "385-983-3925", "384 Hernandez Circles Bergstad, PA 80760", "5","active",10),
("Kelly Yates", "462-216-5843", "6596 Ramos Lock North Aprilfort, WV 45410", "26","active",null),
("Patty Mclaughlin", "495-535-2912", "395 Gonzalez Radial Apt. 120 West Brittanyport, WV 38758", "8","active",null),
("Andre Edwards", "364-168-4052", "31717 Anna Point North Danielland, CO 01685", "8","active",null),
("Daniel Anderson", "591-050-6193", "0642 Jeffrey Rapids Lake Amy, KS 92870", "21","active",null),
("Brenda Thomas", "411-070-2120", "92487 Heather Square Apt. 638 Lake Melissaberg, WA 31174", "6","deactive",7),
("Nicole Dennis", "355-316-4111", "87566 Harris Tunnel Apt. 583 Halestad, MI 72630", "16","active",null),
("Pamela Barton", "114-017-7241", "811 Steven Corner Apt. 373 Maryhaven, CA 63071", "28","deactive",null),
("Maria Tyler", "996-211-5677", "33465 Greer Divide West Brianna, OR 95248", "21","active",null),
("Crystal Williams", "477-106-5987", "99997 Wilson Villages Apt. 892 North Kimberly, SC 38509", "1","active",7),
("Felicia Thompson", "819-512-8714", "574 Gonzalez Junction Lake Jacob, AZ 52706", "24","deactive",null),
("Emily Brooks", "104-757-7243", "PSC 6176, Box 9730 APO AA 87179", "5","active",1),
("Kathy Cameron", "439-705-6726", "38533 Gonzalez Springs Shawnport, ND 96682", "13","active",null),
("Phillip Williams", "414-619-0414", "792 Katherine Port Lake Nicole, HI 54947", "19","deactive",null),
("Natalie Parker", "183-361-3768", "2856 Joseph Passage Lake Joel, VT 58825", "13","active",null),
("Amanda Chavez", "227-687-8334", "343 James Square Suite 337 Port Victor, VT 59665", "10","active",null),
("Todd Barrera", "078-204-4157", "743 Christopher Trafficway West Rachelside, MS 92566", "11","deactive",null),
("Nicole Walker", "498-419-5423", "99043 Michael Well Suite 904 West Veronicaport, SC 96455", "2","active",9),
("Phillip Wood", "927-319-9647", "418 Robbins Parks Apt. 736 Wallertown, WY 35242", "6","active",4),
("Maria Ross", "500-372-1840", "4192 Jessica Pass Suite 794 Smithberg, SD 61617", "8","active",null),
("Richard Rogers", "952-092-6326", "11518 Shane Club Suite 693 Boydville, NE 63303", "14","active",null),
("Leslie Torres", "109-115-1003", "5682 Aaron Estates East Carlahaven, MD 36321", "15","deactive",null),
("Jessica Garcia", "862-901-1951", "9471 Jonathan Drives Lake Samuel, TX 30834", "28","active",null),
("Kent Drake", "470-013-5793", "91821 Drake Courts Apt. 791 Port Ruben, AZ 85576", "2","active",2),
("Neil Johnson", "777-918-5054", "7089 Jessica Gateway New Tyler, MS 07103", "29","active",null),
("Karen Stokes", "053-143-2435", "6710 Coleman Mills North Jeffreychester, AZ 76536", "22","active",null),
("Micheal Ford", "130-728-5626", "61383 Darrell Heights Port Michael, HI 50157", "13","active",null),
("James Hernandez", "301-611-0984", "93892 Abigail Skyway Davisville, SD 50459", "9","active",null),
("Michelle Harrison", "814-078-7806", "Unit 3003 Box 5593 DPO AA 51883", "23","deactive",null),
("John Andrews", "800-470-2668", "Unit 9779 Box 5957 DPO AP 80709", "15","active",null),
("Whitney Martinez", "681-137-1153", "90223 Roberts Branch East Travis, OK 66952", "27","active",null),
("Steven Hughes", "732-624-4855", "10666 Hall Well Mccartyshire, IL 25136", "23","deactive",null),
("Lindsey Smith", "378-300-2746", "USS Clark FPO AE 93998", "18","active",null),
("Gerald Gibson", "117-620-7553", "25031 Stark Parkways Port Rachel, NC 76269", "20","deactive",null),
("Adam Clark", "939-222-4876", "10444 Kathleen Route West Evan, AL 49162", "7","deactive",4),
("Rachel Cooley", "162-073-1633", "Unit 6497 Box 9362 DPO AA 37200", "5","active",6),
("Carol Lopez DDS", "455-132-8357", "77178 Henry Junction New Heather, MT 22670", "17","active",null),
("Mary Rodriguez", "007-687-8772", "3013 Chavez Plains Suite 925 East Brianberg, PA 72932", "18","active",null),
("Gabrielle Chapman", "255-665-4665", "PSC 9267, Box 7760 APO AE 39574", "7","active",10),
("Gregory Hansen", "332-420-7902", "922 Gaines Mews Suite 224 Port Daniel, OR 73026", "6","active",2),
("Rebecca Mendez", "175-582-0833", "5840 Hammond Port Aliciaview, MO 13828", "23","active",null),
("Amber Pratt", "382-440-5354", "Unit 5950 Box 6175 DPO AP 08876", "5","deactive",9),
("Sean Parker", "668-487-3039", "622 Scott Shoals Suite 703 Hoffmanberg, WA 64149", "16","active",null),
("Alexander Guerrero", "772-632-5933", "029 Judy Points Lake Hunterside, TN 61715", "19","deactive",null),

("Paige Zamora", "582-757-4027", "80518 West Ports Apt. 022 Port Aliciaport, TX 51834", "17","active",null),
("Robert Collins", "473-324-5038", "9870 Sara Field Apt. 384 Justinton, IN 01877", "19","deactive",null),
("Kevin Ross", "124-966-4239", "148 Rodriguez Throughway Apt. 669 East Katelynmouth, NJ 30259", "13","active",null),
("Alan Beck", "849-938-0629", "22665 Alex Manors Lake Ericmouth, KY 80631", "10","active",null),
("Victoria Johnson", "512-520-8929", "11761 Boyd Valleys Suite 778 Port Taylormouth, MD 56789", "21","deactive",null),
("Nathan Avila", "483-794-9534", "Unit 0540 Box 7232 DPO AE 73392", "5","active",3),
("Jeffrey Allen", "010-768-2276", "62464 Eric Junction New Danielville, AR 50406", "23","deactive",null),
("David Bell", "168-873-9681", "198 Elizabeth Pines New David, MT 46258", "11","active",null),
("David Mccullough", "413-934-9427", "9483 Paula Neck Apt. 233 North Brandonburgh, IL 29758", "21","active",null),
("Becky Kelly", "464-573-2235", "156 White Ferry Apt. 739 Matthewtown, CO 61183", "11","active",null),
("Tyler Lee", "582-818-5577", "435 Fernandez River Port Maryborough, VA 00560", "22","deactive",null),
("Kristie White", "531-491-1149", "USS Hood FPO AE 98761", "29","active",null),
("Meredith Arroyo", "683-214-9738", "82808 Taylor Summit Vasquezstad, VA 78998", "13","active",null),
("Michael Ramirez", "296-580-9834", "20020 Rocha Run Wendychester, OK 42662", "2","deactive",2),
("Benjamin Lawson", "411-767-4523", "162 Katherine Lane New Kellyside, IL 37706", "28","active",null),
("Terri Lee", "374-203-1607", "457 Black Court Reyesville, KS 09568", "7","active",3),
("George Stephens", "095-828-5975", "3839 Mcdonald Expressway Apt. 175 Davisfort, HI 80991", "5","active",7),
("Daniel Bradley", "457-117-4628", "Unit 6658 Box 4921 DPO AA 62274", "15","active",null),
("Eric Payne", "190-903-3811", "219 Karen Villages Coleburgh, SD 60761", "4","active",10),
("Michael Armstrong", "266-918-7383", "7592 Williams Vista Travisshire, KY 88694", "25","active",null),
("Jacqueline Gonzalez", "132-588-6347", "19648 Brad Shores Suite 956 South Amberbury, IL 01201", "12","active",null),
("Kimberly Frederick", "089-375-7426", "9855 Bryant Center Apt. 088 Lake Ryan, NY 24819", "8","active",null),
("Jessica Smith", "574-375-2486", "9831 Contreras Throughway Cooperborough, UT 13763", "15","deactive",null),
("Kari Massey", "182-113-5742", "202 Lindsay Roads Apt. 452 Davidton, AZ 84760", "21","active",null),
("Virginia Howard", "899-604-8290", "09923 Paul Square Apt. 985 Barnetttown, MD 19904", "10","active",null),
("Joy Dalton", "181-002-0683", "062 Ford Fork Apt. 000 Sandersbury, CO 75519", "22","active",null),
("Eric Tucker", "500-498-9269", "9868 Johnson Heights New Thomas, SD 29578", "6","active",4),
("Jennifer Mcintyre", "539-949-5718", "257 Williams Junctions West Michelleland, WA 82419", "14","active",null),
("Emily Mitchell", "180-702-5703", "742 Courtney Land Apt. 065 Jenniferhaven, IL 36751", "18","active",null),
("Kevin Berry", "951-005-8435", "5669 Matthews Spring West Jamestown, IN 67537", "12","active",null),
("Donald Khan", "663-883-5755", "935 Fox Plaza Suite 910 Ashleeshire, AR 47359", "17","active",null),
("Jared Holmes", "040-461-8298", "5815 Brown Cliff North Jennifer, WV 64674", "19","active",null),
("James Chase", "657-366-9720", "21293 Thomas Extension Kathleenview, TX 96162", "22","active",null),
("Lauren Deleon", "747-635-7848", "098 James Terrace East Michelle, WA 22070", "13","active",null),
("Ana Martinez", "052-758-4196", "Unit 8166 Box 3738 DPO AA 98155", "25","active",null),
("David Simmons", "039-539-2702", "630 Miller Lights Leonardmouth, IL 41971", "1","active",2),
("Richard Rodriguez", "726-650-3753", "6518 Brandon Port Smithborough, CA 01786", "23","active",null),
("Pamela Daniels", "154-718-2167", "9033 Brooks Parks Evansfort, OH 97778", "18","active",null),
("Michael Edwards", "983-589-4751", "4392 Oscar Coves Dennisborough, NE 90852", "15","active",null),
("Donald Cole", "991-932-6466", "8897 Matthew Lights Suite 061 Lake Melody, ID 75648", "9","deactive",null),
("Rhonda Foster", "309-689-7080", "PSC 8643, Box 4357 APO AA 73017", "10","active",null),
("Ashley Sanchez DVM", "440-309-2445", "Unit 7665 Box 9951 DPO AA 75101", "15","active",null),
("Terry Underwood", "262-328-7941", "548 Reyes Course West Joelmouth, KS 42176", "12","deactive",null),
("Jeffrey Wright", "358-034-6528", "55763 Alexandra Roads Port Jennifershire, WA 66985", "21","active",null),
("Joseph Castaneda", "827-627-8755", "0988 Simpson Stream Joshuaborough, CT 36118", "12","active",null),
("Garrett Phillips", "289-231-4392", "1642 Amanda Loaf Suite 137 Grahammouth, RI 73067", "9","active",null),
("Jeffrey Barnes", "947-636-7250", "694 Joy Mountain Apt. 424 New Yvettefurt, NH 78240", "25","active",null),
("Timothy Donovan", "547-551-0790", "3027 Andrew Plains Lake Richard, MA 53879", "5","active",2),
("Erin Rowe", "817-321-5995", "368 Ware Orchard Apt. 555 Lake Jesus, IN 76339", "7","active",8),
("Jacob Washington", "824-629-8324", "0867 Russell Ports Suite 396 Danielville, VT 55986", "1","active",3),
("Sean Mccoy", "065-452-1741", "6771 Kelly Divide Lake Jason, ID 75703", "18","active",null),
("Kristopher Lee", "401-943-0074", "8744 Angela Dale Jennifertown, VA 69920", "21","active",null),
("Dylan Gallegos", "049-101-5462", "48340 Alexander Lights Suite 537 Port Lisa, UT 78354", "9","active",null),
("John Gonzalez", "020-020-8526", "83211 Morales Crest Port Madisonchester, NM 11247", "25","active",null),
("Richard Ramirez", "465-792-3890", "1970 Elizabeth Club Apt. 680 Riverastad, ND 58692", "14","active",null),
("Emily Ayala", "354-980-9808", "534 Moyer Plains Apt. 640 Valenciaborough, ID 16299", "2","deactive",5),
("Kristy Johnson", "856-996-9072", "618 Smith Walks Apt. 557 Joshuaborough, AR 91931", "10","active",null),
("Bridget Johnson", "105-689-6064", "1596 Floyd Union South Jenniferhaven, KY 55795", "5","deactive",2),
("Christina Norman", "147-983-1042", "327 Deleon Rue Erikburgh, TN 44747", "19","deactive",null),
("Kimberly Jordan", "400-373-3438", "Unit 6161 Box 3747 DPO AE 90071", "2","active",4),
("Thomas Wang", "947-720-4650", "890 Stephanie Turnpike Rachelville, IA 18902", "12","deactive",null),
("Mary Hayes", "861-574-0035", "898 Cruz Summit Apt. 398 East Chelseachester, ND 25168", "25","deactive",null),
("Madison Gonzales", "774-880-1216", "USCGC Powell FPO AA 11867", "13","active",null),
("Jose Sheppard", "119-780-6123", "419 Michael Knoll Suite 851 New Emma, WA 67153", "11","deactive",null),
("Rita Brown", "690-642-3000", "PSC 0801, Box 4814 APO AA 52456", "17","deactive",null),
("Christina Jackson", "032-438-3503", "53074 Turner Pike Apt. 759 West Cynthiafurt, NC 56455", "8","active",null),
("Nicholas Zamora", "675-530-2118", "144 Floyd Circles Joshuamouth, MD 49752", "7","active",4),
("Jeffrey Price", "008-124-7073", "56167 Parker Path Apt. 759 New Amandamouth, SD 39402", "1","active",10),
("Kim Park", "633-828-8182", "13814 Hardy Forest Apt. 839 Thomasshire, SC 14755", "9","active",null),
("Erik Mccall", "737-127-6694", "PSC 2754, Box 6490 APO AE 39790", "12","active",null),
("Jeffery Dunlap", "000-416-0573", "09114 Brandon Drive Suite 817 East Pamela, MI 45599", "12","active",null),
("Ryan Spencer", "230-884-2342", "065 Anderson Square Suite 944 South Anthony, IL 22417", "22","active",null),
("Kathryn Williams", "588-786-3876", "651 Allen Land Suite 673 Lorifort, VA 78432", "14","active",null),
("Ann Roberts", "818-614-6023", "0010 Edward Ridge New Markshire, OH 53813", "20","active",null),
("Cory Cross", "237-509-4550", "09088 Laura Divide Lake Chad, DE 46818", "3","active",5),
("Mr. Omar Meza", "154-971-3704", "1187 Tonya Greens Lake Crystalchester, ND 24444", "9","active",null),
("Autumn Joseph", "950-908-6754", "864 Hernandez Plains Apt. 353 North Rachel, TX 92698", "10","active",null),
("Daniel Andrews", "741-487-5964", "22162 Eric Stravenue Suite 122 East Brianstad, TN 07771", "14","active",null),
("Lisa Payne", "327-422-3489", "066 Martin Gateway Suite 744 Brandiside, ND 88313", "16","active",null),
("Emily White", "491-106-4390", "711 Nathaniel Parks Tonymouth, NJ 98881", "12","active",null),
("Samantha Cobb", "344-953-6876", "97324 Walters Oval Suite 043 South Katrina, MA 80076", "24","active",null),
("Michelle Miller", "734-241-7683", "94217 Melendez Dale Apt. 249 Paigefurt, SC 59756", "23","deactive",null),
("Justin Mcgee", "134-342-0129", "3626 Peterson Burg Karenville, NC 62564", "8","active",null),
("Robert Marquez", "256-262-4486", "6396 Melissa Fort Apt. 178 Lake Michael, WA 28652", "3","active",9),
("Douglas Mejia", "915-233-9269", "PSC 7071, Box 8182 APO AA 27706", "2","active",4),
("Jessica Snyder", "410-004-6072", "746 Laurie Orchard Apt. 079 Mikeview, RI 54667", "5","active",4);


select * from customer;



drop procedure if exists customer_data;
call customer_data(7);
DELIMITER $$
CREATE PROCEDURE customer_data(id int)
BEGIN        

SELECT 
    c.id,
    c.name,
    c.contact,
    c.address,
    c.status,
    s.service as subscription,
    s.data AS volume,
    s.validity,
    s.speed,
    s.type as type_of_service,
    s.price as flat_charges
FROM
    customer c
	left join
    service s ON c.service_id = s.id 
	where c.id = id  
     
     group by c.id;
END$$ 
DELIMITER ;



drop procedure if exists customers_data;

DELIMITER $$
CREATE PROCEDURE customers_data()
BEGIN        

SELECT 
    c.id,
    c.name,
    c.contact,
    c.status,
    s.service
FROM
    customer c
        JOIN
    service s on s.id = c.service_id
    group by c.id
	order by c.id;
	

END$$ 
DELIMITER ;

call customers_data();
