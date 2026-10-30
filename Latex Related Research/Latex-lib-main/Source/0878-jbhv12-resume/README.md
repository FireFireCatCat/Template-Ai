# The Ultimate Resume: Clean, ATS Optimized, Auto-Generated

![Build Status](https://github.com/jbhv12/resume/actions/workflows/compile.yml/badge.svg)
![Stars](https://img.shields.io/github/stars/jbhv12/resume?style=social)

This project allows you to create a clean, professional and ATS Optimized Resume in PDF format right from GitHub, without any local setup!

## ⭐ ATS Optimizations:
- **Unique Action Verbs** – All bullet points start with unique action verbs.
- **Quantifiable Impact** – Most points show measurable quantitative results.
- **Standard Fonts** – Uses CMU (Computer Modern Unicode), a widely accepted scientific standard.
- **Reverse Chronological Order** – Most recent job first.
- **Standard Sections** – Skills, Work Experience, Education etc.
- **No Fancy Formatting** – No columns, text boxes, tables, or graphics, as ATS struggles to read them.
- **PDF Format** – Maintains consistency and ensures compatibility.
- **Keyword Optimization** – Includes job-relevant keywords at the top.
- **No Headers or Footers** – Some ATS ignore or misread them.
- **Simple Bullet Points** – Uses simple and consistent `•` for points, avoids special characters.
- **No Images & Logos** – ATS reads text only.
- **No Personal Info** – Excludes unnecessary personal details that might be flagged by ATS.
- **External Links** – Clearly highlights links for contact details (email, phone, website, etc.) and external projects.
- **Length** – Does not exceed 2 pages in standard PDF.
- **Acronyms** – Uncommon acronyms are spelled out (e.g., SEO (Search Engine Optimization)) for keyword matching.

## 🚀 Why LaTeX?

Unlike traditional word processors, LaTeX is not WYSIWYG (What You See Is What You Get). Instead, it relies on a markup-based approach, ensuring precise, structured, and consistent formatting. This allows you to focus on your content while maintaining a polished and professional layout every time.

LaTeX provides a high-quality typesetting system; it includes features designed for the production of technical and scientific documentation. LaTeX is the de facto standard for the communication and publication of scientific documents.

## 🛠️ How to Use

1. Fork this repository.
2. Enable GitHub Actions in your fork.
3. Edit the `main.txt` file with your personal information.
4. Commit & push your changes to your forked repository.
5. The automated GitHub Action will compile the `main.txt` file using LaTeX and generate a PDF.
6. Once the action is completed, you can download the generated artifact from the "Artifacts" section in the "Actions" tab of your forked repository.
7. Unzip the file and start using your professional resume!

### Local Compilation with Docker

To compile the resume locally using Docker, run the following command in your project directory:

```bash
docker run --rm -i -v $(pwd):/data mingc/latex pdflatex main.tex
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📜 License

[MIT](https://choosealicense.com/licenses/mit/)

---

💌 _Maintained by [Jay Bhavsar](https://jay.is-savvy.dev/)_
docker run --rm -i -v $(pwd):/data mingc/latex pdflatex main.tex    