import Array "mo:base/Array";
import Bool "mo:base/Bool";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
module  {
    public func nat_to_nat8(n : Nat) : Nat8{
        if(n > 255){
          return 0;
        }else{
          return Nat8.fromNat(n);
        };
      };
    public func max_number_with_n_bits(n : Nat ) : Nat {
      return (n**(2) -1 );

    };
    public func decimal_to_bits (n : Nat ) : Text{
       var m = n;
        var bits : Text= "";
        while(m > 0){
            var remainder = m % 2;
             m := m / 2;
            if(remainder == 1){
                bits := "1" # bits;
            } else {
                bits := "0" # bits;
            };
        };
        return(bits);
    };
    public func capitalize_character (c : Char) : Char{
        let unicodeChar = Char.toNat32(c);
        if(unicodeChar >= 97 and unicodeChar <= 122){
          return (Char.fromNat32(unicodeChar-32));
        }else{
          return c;
        };
    };
    public func capitalize_text ( string : Text ) : Text{
      var capText : Text = "";
      for(char in string.chars()){
        capText #= Char.toText(capitalize_character(char));
      };
      return capText;

    };
    public func is_inside (string : Text , c : Char) : Bool {
      for(char in string.chars()){
        if(Char.equal(char, c )) {
          return true;
        };
      };
      return false;
    };
    public func trim_whitespace (string : Text ) : Text {
      let pattent = #text(" ");
      return (Text.trim(string, pattent));
    };
    public func duplicated_character (t :  Text ) : Text{
      var arr : [Char] = [];
      var count = 0;
      var stringx = "";
      for(val in t.chars()) {
        arr := Array.append<Char>(arr,[val]);
      };
      var arr_mutable = Array.thaw<Char>(arr);
      for(i in Iter.range( 0, arr.size())){
        for(j in Iter.range(i+1, arr.size()-1)){
          if(Char.equal(arr[i],arr[j])and Char.equal(arr[i],' ') == false){
            count += 1;
            arr_mutable[j] := '0';
          };
        };
      if(count > 1 and Char.equal(arr_mutable[i], '0')  ){
        stringx := stringx # Char.toText(arr[i]);

      };
      };
      if(stringx.size() > 0){
        return stringx;
      }else{
        return t ;
      };
    };
    public func duplicatedCharacter(t : Text): Text{
        var characters : [Char] = [];
        for (character in t.chars()){
            let ret = Array.filter(characters, func(x : Char) : Bool{x == character});
            if(ret.size() == 0){
              characters := Array.append<Char>(characters, [character]);
            }else {
              return Char.toText(ret[0]);
            }
        };
        return (t);
    };
    public func size_in_bytes (t : Text) :  Nat {
        let utf_blob = Text.encodeUtf8(t);
        let array_bytes = Blob.toArray(utf_blob);
        return(array_bytes.size()); 
    };
    func _swap(array : [var Nat], i : Nat, j : Nat){
        let tmp = array[i];
        array[i] := array[j];
        array[j] := tmp;
    };

    public func bubble_sort(array : [Nat]) :  [Nat] {
        var sorted = Array.thaw<Nat>(array);
        let size = array.size();
        for(i in Iter.range(0, size - 1)){
            for (j in Iter.range(0, size - 2 - i)){
                if(sorted[j] > sorted[j + 1]){
                    _swap(sorted, j , j+1);
                };
            };
        };
        return (Array.freeze<Nat>(sorted));
    };
    public func nat_opt_to_nat(n : ?Nat, m : Nat) :  Nat {
    switch(n){
      case(null) return m;
      case(?n) return n; 
    };
  };
  public func day_of_the_week(day : Nat) :  Text {  
    switch(day){
      case(1) return "Monday";
      case(2) return "Thursday";
      case(3) return "Wednesday";
      case(4) return "Tuesday";
      case(5) return "Friday";
      case(6) return "Saturday";
      case(7) return "Sunday";
      case(_) return "null";
    };
  };
  // public func populate_array(array : [?Nat]) :  [Nat] {
  //   Array.map<?Nat,Nat>(array, func(x) {
  //     switch(x){
  //       case(null) return 0;
  //       case(?x) return x;
  //     };
  //   });
  // };
  public func sum_of_array(array : [Nat]) : Nat {
    let sum = Array.foldLeft<Nat, Nat>(array, 0, func(a , b) {a + b});
    return(sum);
  };
  public func squared_array(array : [Nat]) : [Nat] {
    return(Array.map<Nat,Nat>(array, func(x) { x*x }));
  };
  public func increase_by_index(array : [Nat]) : [Nat] {
    return(Array.mapEntries<Nat,Nat>(array, func(a, index) {a + index}));
  };  

}
