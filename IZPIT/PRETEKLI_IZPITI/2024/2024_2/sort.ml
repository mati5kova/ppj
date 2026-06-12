type size = Small | Medium | Large
type 'a classes = { small : 'a list; medium : 'a list; large : 'a list }

let temp = {small = [1]; medium = [2]; large = [3]}

let f x = if x < 10 then Small else if x < 100 then Medium else Large;;

let sort f alst = 
  let rec sort_rec cls lst = 
    match lst with
    | (h::t) ->
      begin
        match f h with
        | Small -> sort_rec {cls with small = h :: cls.small} t
        | Medium -> sort_rec {cls with medium = h :: cls.medium} t
        | Large -> sort_rec {cls with large = h :: cls.large} t
      end
    | [] -> cls
    in
    sort_rec {small=[]; medium=[];large=[]} alst
