/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_HOC_TAB_H_INCLUDED
# define YY_YY_HOC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    PRINT = 259,
    STRING = 260,
    PI = 261,
    READ = 262,
    BLTIN = 263,
    PROCEDURE = 264,
    PROC = 265,
    VAR = 266,
    FUNC = 267,
    FUNCTION = 268,
    ELSE = 269,
    WHILE = 270,
    IF = 271,
    RETURN = 272,
    OR = 273,
    AND = 274,
    GT = 275,
    GE = 276,
    LT = 277,
    LE = 278,
    EQ = 279,
    NE = 280,
    NEG = 281,
    NOT = 282
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{

  /* NUM  */
  double NUM;
  /* PRINT  */
  double PRINT;
  /* STRING  */
  double STRING;
  /* PI  */
  double PI;
  /* READ  */
  double READ;
  /* BLTIN  */
  double BLTIN;
  /* PROCEDURE  */
  double PROCEDURE;
  /* PROC  */
  double PROC;
  /* VAR  */
  double VAR;
  /* FUNC  */
  double FUNC;
  /* FUNCTION  */
  double FUNCTION;
  /* ELSE  */
  double ELSE;
  /* WHILE  */
  double WHILE;
  /* IF  */
  double IF;
  /* RETURN  */
  double RETURN;
  /* expr  */
  double expr;
  /* asig  */
  double asig;
#line 117 "hoc.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_HOC_TAB_H_INCLUDED  */
