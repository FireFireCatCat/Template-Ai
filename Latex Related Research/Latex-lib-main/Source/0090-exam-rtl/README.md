README.md

# exam-rtl – Create Professional Exams in Arabic (RTL)

**exam-rtl** is a LaTeX package that helps you create beautiful, professional exams in Arabic and right-to-left (RTL) languages without worrying about formatting. Just write your questions naturally, and the package takes care of numbering, layout, and answer keys.

Whether you're a teacher preparing a quiz or an exam setter creating a comprehensive test, this package makes your job easier.

## ✨ Key Features

- **8 Question Types**: Multiple Choice, True/False, Fill in the Blank, Ordering, Matching, Essay, Short Answer, and Reading Passage.
- **Automatic Answer Keys**: Answers are collected and displayed automatically in teacher mode.
- **Smart Randomization**: Shuffles options and matching items in a reproducible way.
- **Clean Output**: Student version has no hints; teacher version shows full answers.
- **Simple to Use**: Write your questions in plain LaTeX, and the package handles the rest.
- **Arabic Support**: Eastern Arabic numerals and RTL text alignment.

## 🚀 Getting Started in 3 Steps

### 1. Load the Package

```latex 
\documentclass{article}
\usepackage{exam-rtl}
```

### 2. Set the Mode

```latex 
\TeacherMode
\ShowCorrection
\ExamID{1234}
```

### 3. Write Your Questions

```latex 
\begin{Question}{MC}{سهل}{٢}{اختر الإجابة الصحيحة}
\begin{MC}
    \MCQuestion{ما هو ناتج ٢ + ٢ ؟}{2}
        \MCOption{٣}
        \MCOption{٤}
        \MCOption{٥}
\end{MC}
\end{Question}
```
That's it! Compile with xelatex and you have a complete exam with an answer key.

## 📦 Installation
The package is available on CTAN and included in all major LaTeX distributions (TeX Live, MiKTeX, MacTeX). Just use it — your system will handle the rest.

If you need to install manually: Place exam-rtl.sty in your working directory, or install it permanently using your local texmf tree.

## 🎯 Quick Overview of Commands

Commandn		| Description
----------------|-------------------------------------------
\StudentMode	| Hide answer keys (default)
\TeacherMode	| Show answer keys
\ShowMarks		| Display marks
\ShowDifficulty	| Display difficulty levels
\ShowTags		| Display question type
\ShowCorrection	| Show answer boxes (requires \TeacherMode)
\ExamID{number} | Set a fixed seed for randomization

## 📝 Question Types at a Glance

Type              | Environment    | Purpose
------------------|----------------|-------------
Multiple Choice	  | MC	           | Choose from options
True/False	      | TF	           | True or false statements
Fill in the Blank | FillBlank	   | Complete sentences
Ordering	      | Ordering	   | Arrange items in correct order
Matching	      | Matching	   | Match two columns
Essay	          | Essay	       | Long-form written answers
Short Answer      | ShortAnswer    | Brief responses
Reading Passage   | ReadingPassage | Comprehension texts

## ⚠️ Requirements

- **LaTeX engine:** XeLaTeX (PDFLaTeX and LuaLaTeX are not supported)
- **Font:** IBM Plex Sans Arabic (ensure it is installed on your system)

## 📚 Need More Details?

- Check the `example.tex` file included with the package.
- Check For Arabic documentation with examples, see `exam-rtl-doc.tex`.
- Read the full technical documentation `exam-rtl.pdf`.

## 📄 License

This package is distributed under the LaTeX Project Public License (LPPL), version 1.3c or later.

## 👤 Author

Nadeer Aljaroudi

---

Happy Exam Writing! 😊