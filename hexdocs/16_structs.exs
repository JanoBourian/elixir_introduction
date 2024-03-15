john = %User{make: "make"}
john.name
john.age
jane = %User{make: "make", name: "Jane"}
jane.name
jane.age
anonymous = %User{john | name: "Anonymous"}
anonymous.name
anonymous.age

%User{} = anonymous
