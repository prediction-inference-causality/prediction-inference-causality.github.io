# Translation Guide

::: {.callout-note}
## Primary Goal: Preserve Original Wording
The main task is to convert the structure (e.g., bullet points to prose sentences) while keeping the exact wording from the source `.qmd` file. **Do not** rewrite sentences for style, clarity, or flow unless specifically instructed otherwise later. Adhere strictly to the math and code handling rules below.
:::

::: {.callout-warning}
## CRITICAL WARNING: Math and Code Handling

### Decision Tree for Math and Code Modifications
1. IF user has NOT explicitly requested changes to math or code:
   - DO NOT modify any math blocks or code blocks
   - DO NOT suggest changes to math or code
   - DO NOT rewrite math or code in different notation
   - DO NOT "improve" or "optimize" math or code
   - DO NOT fix perceived errors in math or code

2. IF you notice potential issues in math or code:
   - DO point out the issue to the user
   - DO NOT attempt to fix the issue
   - DO NOT suggest fixes unless specifically asked

3. IF user has explicitly requested changes to math or code:
   - DO make ONLY the specific changes requested
   - DO NOT make additional changes
   - DO NOT modify surrounding math or code

This is the most important rule in these guidelines. The mathematical notation and code in the documents are carefully crafted for pedagogical purposes.

### LaTeX Integrity
Be extremely careful with LaTeX math environments (`$...$` and `$$...$$`). Edits can easily introduce errors, especially incorrect escaping (changing `\` to `\\` or vice-versa). After converting surrounding text, meticulously check all LaTeX commands (e.g., `\bar`, `\approx`, `\frac`, `\in`, `\text`, `\vdots`, `\\` line breaks in arrays) to ensure single backslashes are used where appropriate. Run `quarto render` specifically to check for LaTeX errors after major edits involving math.

### Code Chunk Integrity
Verify that code chunks (` ```{r} ... ``` `) remain intact. Ensure the opening and closing delimiters are present and correct. Check that no code *within* the chunks has been accidentally deleted or altered. Pay attention to chunk options like `#| label:` and ensure they are preserved. A deleted or corrupted code chunk can cause hard-to-diagnose render errors.
:::

# Critical Warning About Math and Code Modifications

**DO NOT MODIFY MATH OR CODE UNLESS EXPLICITLY REQUESTED BY THE USER.**

This is the most important rule. Never change mathematical expressions, code blocks, or their order unless specifically asked to do so. This includes:

- Never modify the contents of code blocks
- Never change the order of code blocks
- Never add or remove code blocks
- Never modify code block labels or options
- Never change mathematical expressions or equations
- Never modify includes or their order

When reorganizing content into tabs or merging sections:
- Only move prose text around the fixed code blocks
- Keep all code blocks exactly where they are
- Preserve all code block labels and options
- Maintain the exact order of all code blocks and includes
- Even code blacks that are identical in merged sections should be put into tabs at first. Tell me about this redundancy and I will instruct you to delete them if i want them deleted. 

**IMPORTANT: Code block modifications can break compilation**
- Code blocks often have dependencies on each other through variable definitions and function calls
- Changing the order of code blocks can break these dependencies
- Adding or removing code blocks can create undefined variables or missing functions
- Modifying code block contents can introduce errors or change the behavior
- Breaking compilation is unacceptable - the document must compile successfully after any changes

## Overview
This guide describes how to translate a lecture presentation (lecture/LectureX.qmd) into a prose version (lecture/LectureX-prose.qmd). The goal is to maintain all content while improving readability and flow, **primarily by converting bullet points to prose and preserving the original wording.**

## Writing Style Preferences
- Preserve the original text unless specifically asked to change it
- **Focus on structural conversion (bullets to prose) first.** Stylistic adjustments should only be made if explicitly requested *after* the structural conversion is complete and verified.
- Use shorter, more direct sentences
- Replace colons and m-dashes with periods where appropriate
- Keep sentence fragments when they serve the pedagogical purpose
- Maintain a conversational, lecture-like quality
- Use "we" and "you" to engage the reader directly
- Include parenthetical explanations and asides
- Use footnotes for additional context or references
- Always add a blank line before and after lists
- Use triple dashes (---) instead of double dashes (--) or single dashes (-)

## Translation Process

### Before Starting
1. Read several homework/homework*.qmd files to understand the prose style
2. Ask which lecture to translate if not specified
3. Confirm the source file (lecture/LectureX.qmd) exists
4. Create the target file by copying the source file:
   ```bash
   cp lecture/LectureX.qmd lecture/LectureX-prose.qmd
   ```
5. IMPORTANT: Never make any changes to the original LectureX.qmd file

### Translation Steps

1. **Initial Pass: Convert Bullet Points to Prose (Preserving Wording)**
   - Convert each bullet point into a complete sentence or integrate it naturally into surrounding sentences.
   - **Crucially, preserve the original wording from the source file.**
   - Maintain the same section structure as the presentation.
   - Keep all content, even if it seems redundant.
   - Maintain original order of all content.

2. **Title and Structure Changes**
   - Use the presentation's subtitle as the main title.
   - Remove the original title if it's just "Lecture X".
   - **Do not change section headers.** Maintain the original section titles from the source file.

3. **Prose Style and Flow (If Requested)**
   - **Only perform this step if explicitly asked by the user.**
   - If requested, study the style in `homework/homework*.qmd`.
   - Match the level of detail and explanation.
   - Use similar sentence structures and paragraph organization.
   - Maintain consistent voice and perspective.

4. **Content Organization**
   - Convert panel-tabsets into flowing prose, except for:
     - Visualizations showing different views of the same data
     - Code examples that benefit from side-by-side comparison
   - Add transitions between sections to improve narrative flow (use original wording where possible).
   - **Complex Layouts (`columns`, `panel-tabset`):** Exercise caution when editing content inside complex Quarto structures like `:::: columns ... ::: ... ::::`, `::: {.panel-tabset} ... :::`, etc. Ensure all opening/closing delimiters (`:::` and `::::`) are correctly maintained and nested. If `quarto render` gives warnings about 'fenced divs', check for missing/extra delimiters or try adding blank lines before `:::: columns` blocks.

5. **References and Labels**
   - **Figure Options:** For figure-generating code chunks, add a Quarto label option (`#| label: fig-...`, using a descriptive name based on the section/content). Remove any existing caption options (`#| fig-cap:`). Preserve other chunk options.
   - Add proper labels to all tables (e.g., `#tbl-predictions`).
   - Add descriptive captions to tables (`#| tbl-cap:`).
   - Add cross-references between sections using `@fig-` and `@tbl-` labels where appropriate (e.g., referencing a figure discussed in the text).
   - Convert vague references ("see the figure above") to explicit cross-references if a label exists.

6. **Specific Text Changes (Use with Caution)**
   - Consider replacing "Today we'll" with "In this chapter, we'll" (confirm if necessary).
   - Remove references to specific class days (e.g., "On Friday, we...") unless it provides essential context.
   - Ensure consistent formatting of percentages and numbers.

7. **Final Verification (Frequent Render Checks)**
   - Run `quarto render <filename.qmd>` **frequently**, especially after edits involving LaTeX, code chunks, or complex layouts like `columns`.
   - **Do not proceed if errors or warnings occur.** Analyze the error messages (paying attention to line numbers or specific warnings like 'fenced div' or LaTeX errors), identify the cause (often related to recent edits), fix the issue, and re-render successfully before continuing.
   - Ensure all cross-references work.
   - Check that all figures and tables are properly labeled as requested.
   - Verify that the prose flows naturally (if stylistic edits were requested).
   - If compilation warnings or errors persist after attempts to fix:
     - DO report them clearly to the user, explaining the error and the attempted fixes.
     - DO wait for user guidance before proceeding. 