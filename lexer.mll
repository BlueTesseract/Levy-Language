{
open Lexing
open Parser
}

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let num = ['-']? ['0'-'9']+
let id = ['a'-'z' 'A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9' '\'']*
let str = '\"' [^'\"']* '\"'

rule read =
  parse
  | white {read lexbuf}
  | newline {new_line lexbuf; read lexbuf}
  | num {NUM (int_of_string (Lexing.lexeme lexbuf))}
  | "λ" {LAM}
  | "let" {LET}
  | "be" {BE}
  | "to" {TO}
  | "in" {IN}
  | "int"  {INT}
  | "produce" {PRODUCE}
  | "force" {FORCE}
  | "thunk" {THUNK}
  | "print" {PRINT}
  | str {STR (Lexing.lexeme lexbuf)}
  | "'" {PUSH}
  | ":" {COL}
  | ";" {SCOL}
  | "->" {ARR}
  | "+"  {PLUS}
  | "-"  {MINUS}
  | "*"  {TIMES}
  | "(" {LPAR}
  | ")" {RPAR}
  | id {ID (Lexing.lexeme lexbuf)}
  | _ {failwith ("Unexpected char: " ^ Lexing.lexeme lexbuf)}
  | eof {EOF}