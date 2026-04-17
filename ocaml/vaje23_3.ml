type status = { version : string; code : int } ;;
let mystatus = { version = "HTTP/1.1"; code = 200 } ;;

let string_of_status s =
  s.version ^ " " ^
  string_of_int s.code ^ " " ^
  (match s.code with
   | 200 -> "OK"
   | 404 -> "Page not Found"
   | 301 -> "Moved Permanently"
   | _ -> "")

type barva = Red | Black ;;
               
type tencoding = 
    Chunked 
  | Compress
  | Deflate
  | Gzip 
  | Identity

let string_of_tencoding te =     
  match te with
  | Chunked -> "chunked"
  | Compress -> "compress"
  | Deflate -> "deflate"
  | Gzip  -> "gzip"
  | Identity -> "identity"
    
type date = {
  day_of_week : string;
  day_of_month : int;
  month : string;
  year : int;
  hour: int;
  minutes : int;
  seconds : int;
  zone : string;
}

let format_clock i =
  (if i < 10 then "0" else "") ^ string_of_int i

let string_of_date d =
  d.day_of_week
  ^ " " ^
  string_of_int d.day_of_month
  ^ " " ^
  d.month
  ^ " " ^
  string_of_int d.year
  ^ " " ^
  format_clock d.hour
  ^ ":" ^
  format_clock d.minutes
  ^ ":" ^
  format_clock d.seconds
  ^ " " ^
  d.zone
    


type field =
  | Server of string
  | ContentLength of int
  | ContentType of string
  | TransferEncoding of tencoding
  | Date of date
  | Expires of string
  | LastModified of string
  | Location of string

type response = {status: status; headers: field list; body: string}

let string_of_field (f : field) : string =
  match f with
  | Server s -> "Server: " ^ s
  | ContentLength cl -> "ContentLength: " ^ string_of_int cl
  | ContentType ct -> "ContentType: " ^ ct
  | TransferEncoding te -> "TransferEncoding: " ^ string_of_tencoding te
  | Date d -> "Date: " ^ string_of_date d
  | Expires e -> "Expires: " ^ e
  | LastModified lm -> "LastModified: " ^ lm
  | Location l -> "Location: " ^ l

  

let r = {
  status={version="HTTP/1.1"; code=200};
  headers=[
    Server "nginx/1.6.2"; 
    ContentLength 13;
    ContentType "text/html; charset=utf-8";
    TransferEncoding Chunked; 
    Date {
      day_of_week="Fri";
      day_of_month=23;
      month="Mar";
      year=2018;
      hour=6;
      minutes=43;
      seconds=15;
      zone="GMT"};
    Expires "Sun, 19 Nov 1978 05:00:00 GMT";
    LastModified "Sun, 18 Nov 1978 05:00:00 GMT";
    Location "Ljubljana"
  ];
  body="hello world!\n"
}

let string_of_response r =
  string_of_status r.status
  ^ "\n" ^ 
  String.concat "\n" (List.map string_of_field r.headers)
  ^ "\n" ^ 
  r.body
    