type status = {version:string; code:int};;
type date = {dof:string; ddmmyy:string; time:string; zone: string}
type contentType = {ctype:string; charset:string}
type transferEncoding =
  | Chunked
  | Compress
  | Deflate
  | GZIP
  | Identity
  | UNKNOWN

let te_to_string = function
  | Chunked -> "chunked"
  | Compress -> "compress"
  | Deflate -> "deflate"
  | GZIP -> "gzip"
  | Identity -> "identity"
  | _ -> "unknown"

let string_to_te = function
  | "chunked" -> Chunked
  | "compress" -> Compress
  | "deflate" -> Deflate
  | "gzip" -> GZIP
  | "identity" -> Identity
  | _ -> UNKNOWN

type field = 
  | Server of string
  | Date of date
  | ContentType of string
  | Connection of string
  | TransferEncoding of transferEncoding
  | Expires of date
type response = {status:status; headers:field list; body: string}
let myStatus = {version="HTTP/1.1"; code=200};;

let res = {
  status={version="HTTP/1.1"; code=200};
  headers = [
    Server "nginx"; 
    Date {dof="Sun"; ddmmyy="31 May 2026"; time="08:12:17"; zone="GMT"}; 
    ContentType "text"; 
    Connection "keep-alive"; 
    TransferEncoding GZIP;
    Expires {dof="Mon"; ddmmyy="31 May 2027"; time="08:12:17"; zone="GMT"}];
  body="body"
}

let string_of_status s =
  s.version ^ " " ^
  string_of_int s.code ^ " " ^
  (match s.code with
  | 200 -> "OK" 
  | _ -> "")
  
let string_of_date d =
  d.dof ^ ", " ^ d.ddmmyy ^ " " ^ d.time ^ " " ^ d.zone

let string_of_field f =
  match f with
  | Server s -> "Server: " ^ s
  | Date d -> "Date: " ^ string_of_date d
  | ContentType ct -> "Content-Type: " ^ ct
  | Connection c -> "Connection: " ^ c
  | TransferEncoding te -> "Transfer-Encoding: " ^ te_to_string te
  | Expires d -> "Expires: " ^ string_of_date d

  

let string_of_response r =
  print_endline               (*treba dat print_endline drugace se vidijo samo \n v izpisu namesto new line*)
  (
  string_of_status r.status
  ^ "\n" ^
  String.concat "\n" (List.map string_of_field r.headers)
  ^ "\n\n" ^
  r.body
  )
