/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     IF = 259,
     DECL = 260,
     END = 261,
     WHILE = 262,
     ENDWHILE = 263,
     ENDIF = 264,
     RETURN = 265,
     READ = 266,
     WRITE = 267,
     ELSE = 268,
     BOOLEAN = 269,
     INTEGER = 270,
     ENDDECL = 271,
     RELOP = 272,
     LOGOP = 273,
     ID = 274,
     DO = 275,
     MAIN = 276,
     THEN = 277,
     BEG = 278,
     NOT = 279,
     AND = 280,
     OR = 281
   };
#endif
/* Tokens.  */
#define NUMBER 258
#define IF 259
#define DECL 260
#define END 261
#define WHILE 262
#define ENDWHILE 263
#define ENDIF 264
#define RETURN 265
#define READ 266
#define WRITE 267
#define ELSE 268
#define BOOLEAN 269
#define INTEGER 270
#define ENDDECL 271
#define RELOP 272
#define LOGOP 273
#define ID 274
#define DO 275
#define MAIN 276
#define THEN 277
#define BEG 278
#define NOT 279
#define AND 280
#define OR 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 12 "sil2.y"

 Node *ptr;



/* Line 2068 of yacc.c  */
#line 108 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


