"I commonly hold shift too long when saving this was easier"
command W w

let topvar = "/************************************************************************\n	Program:\n	Author:\n	Class:\n	Instructor:\n	Date:\n 	Description:\n	Input:\n	Output:\n	Compilation instructions:\n	Usage:\n	Known bugs/missing features:\n	Modifications:\n   Date                Comment            \n    ----    ------------------------------------------------\n************************************************************************/"

let headvar  = "/************************************************************************\nFunction:\nAuthor: Zacharious Owen\nDescription:\nParameters:\n************************************************************************/"

let iferrvar = "if(    )\n{\nprintf(\"ErrorCodeName: \\nExiting\");\nreturn -1;\n}\n"


command IFERR call append ( line('.'), split ( iferrvar , "\n") ) | :execute 'normal =5j'

command HEAD call append ( line('.'), split ( headvar , "\n") )

command TOP call append ( line('.'), split ( topvar , "\n") )

"do you ever not want line numbers and syntax highlighting"
set number
syntax on
