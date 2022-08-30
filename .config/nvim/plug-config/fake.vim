call fake#define('sex', 'fake#choice(["male", "female"])')
call fake#define('name', 'fake#int(1) ? fake#gen("male_name") : fake#gen("female_name")')
call fake#define('fullname', 'fake#gen("name") . " " . fake#gen("surname")')
call fake#define('sentence', 'fake#capitalize(join(map(range(fake#int(3,15)),"fake#gen(\"nonsense\")")) . fake#chars(1,"..............!?"))')
call fake#define('paragraph', 'join(map(range(fake#int(3,10)),"fake#gen(\"sentence\")"))')
call fake#define('lipsum', 'fake#gen("paragraph")')
call fake#define('id', 'fake#int(9999)')

