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

### Column Syntax (`::: columns`)
Pay close attention to the syntax for column divs:
```markdown
::: {.columns}

::: {.column width="60%"}
Content for column 1...
:::

::: {.column width="40%"}
Content for column 2...
:::

:::
```
Ensure each opening `:::` has a corresponding closing `:::`. Incorrect nesting or missing closers will cause `quarto render` warnings or errors (often about fenced divs). Blank lines around the `:::` delimiters can sometimes help prevent render issues.
:::

::: {.callout-info}
## AI Assistant Tool Limitations
The editing tools used by the AI assistant may occasionally make mistakes, such as:
- Incorrectly applying edits (e.g., adding/deleting extra lines).
- Deleting entire code chunks or sections accidentally.
- Introducing syntax errors (especially with LaTeX or column divs).

If an edit seems incorrect or causes rendering errors, please:
1. Point out the specific error to the assistant.
2. Ask the assistant to revert the change or re-apply the edit carefully.
3. If errors persist after retries, manual correction might be necessary.
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
- **Primary Goal:** Preserve the original text verbatim unless specifically asked to change it. The main focus is structural conversion (bullets to prose).
- **Secondary Goal (If requested *after* structural conversion):** Adjustments for conversational tone or flow.
- Use shorter, more direct sentences (if rewriting).
- Preserve the original text unless specifically asked to change it
- **Focus on structural conversion (bullets to prose) first.** Stylistic adjustments should only be made if explicitly requested *after* the structural conversion is complete and verified.
- Replace colons and m-dashes with periods where appropriate
- Keep sentence fragments when they serve the pedagogical purpose
- Maintain a conversational, lecture-like quality
- Use "we" and "you" to engage the reader directly
- Include parenthetical explanations and asides
- Use footnotes for additional context or references
- Always add a blank line before and after lists
- Use triple dashes (---) instead of double dashes (--) or single dashes (-)

## Translation Process

This process is typically done in two stages.

**Stage 1: Structural Translation (Preserve Content & Wording)**

*Goal: Convert the presentation structure to a basic prose structure while preserving all original content and wording.* 

### Before Starting
1. Read several homework/homework*.qmd files to understand the prose style
2. Ask which lecture to translate if not specified
3. Confirm the source file (lecture/LectureX.qmd) exists
4. Create the target file by copying the source file:
   ```bash
   cp lecture/LectureX.qmd lecture/LectureX-prose.qmd
   ```
5. IMPORTANT: Never make any changes to the original LectureX.qmd file

### Stage 1 Steps

1.  **Initial Pass: Convert Bullet Points to Prose (Preserving Wording)**
    -   Convert each bullet point into a complete sentence or integrate it naturally into surrounding sentences.
    -   **Crucially, preserve the original wording from the source file.** Do not rephrase or change terminology.
    -   Maintain the same section structure and headings as the presentation.
    -   Keep all content, even if it seems redundant.
    -   Maintain original order of all content.

2.  **Title Change**
    -   Ensure the `title:` field in the YAML header of the prose file (`LectureX-prose.qmd`) contains the descriptive title for the lecture content.
    -   This title is usually found in the `title:` field of the original presentation file (`LectureX.qmd`).
    -   If the original file has only a generic `title:` (e.g., "Lecture X"), ask the user for an appropriate title for the prose version.
    -   Adjust the `title:` field in the prose file's YAML header accordingly.

3.  **Figure Labels**
    -   **Figure Options:** For figure-generating code chunks, add a Quarto label option (`#| label: fig-...`, using a descriptive name based on the section/content). Remove any existing caption options (`#| fig-cap:`). Preserve other chunk options. Check for correct syntax (`#| label: ...`, not `# label: ...`).

4.  **Initial Verification**
    -   Run `quarto render <filename.qmd>`. Check for and fix any critical errors (especially LaTeX, code execution, or column div errors) introduced during the initial conversion.
    -   Ensure all original headings are present.

**Stage 2: Prose Refinement (Improve Flow & Structure)**

*Goal: Restructure and rewrite the Stage 1 output to create a cohesive, flowing prose document suitable for reading.* 

### Stage 2 Steps

1.  **Identify Merge/Restructure Opportunities:** Review the Stage 1 document. Identify consecutive sections covering related topics, series of examples, or overly granular subsections that could be combined or restructured for better narrative flow.

2.  **Merge & Restructure Sections:**
    -   Combine related sections. This might involve:
        -   Removing intermediate headings and letting the text flow under the main section heading.
        -   Consolidating content under a revised heading (confirm title changes if necessary).
    -   Reorganize content presentation, for example:
        -   Grouping related figures or code examples into a `panel-tabset` under a single heading (e.g., multiple simulated polls, different views of interval estimates).
        -   Converting minor `###` subsections into integrated prose with bold text or paragraph breaks if it improves flow.

3.  **Adjust Headings:**
    -   Unlike Stage 1, headings *can* be adjusted in Stage 2 for prose clarity:
        -   Rename headings if the merged content warrants a different title (confirm if unsure).
        -   Adjust heading levels (e.g., H2 `##` to H3 `###` or vice-versa) as needed by the new structure.

4.  **Rewrite Prose & Transitions:**
    -   Rewrite text as needed to create smooth transitions between previously separate sections.
    -   Rephrase sentences for clarity and flow in the prose format (while still aiming to retain the core meaning and key terms).
    -   Explicitly reference figures/tabs when needed (e.g., "See the second tab (@fig-...) for an example...").

5.  **Handle Asides/Footnotes:**
    -   Convert `:::: aside` blocks into footnotes `^[...]` or integrate their content directly into the main text where appropriate.

6.  **Refine Code/Figures (Use Caution!):**
    -   Minor adjustments to figure aesthetics (e.g., removing `fill` if faceting is used) or chunk labels (`#| label: ...`) *may* be acceptable if they improve clarity in the static prose format.
    -   Redundant figures (e.g., overview plots made unnecessary by tabsets) *may* be removed.
    -   **CRITICAL:** Do *not* alter core code logic, variable names, or calculations. Ensure changes do not break execution. **Confirm significant code/figure changes** before implementing.

7.  **Add Cross-References & Table Formatting:**
    -   Add proper labels to all tables (e.g., `#tbl-predictions`).
    -   Add descriptive captions to tables (`#| tbl-cap:`).
    -   Add cross-references between sections using `@fig-` and `@tbl-` labels where appropriate (e.g., referencing a figure discussed in the text).
    -   Convert vague references ("see the figure above") to explicit cross-references if a label exists.

8.  **Final Verification (Frequent Render Checks)**
    -   Run `quarto render <filename.qmd>` **frequently** during Stage 2 edits, especially after changes involving columns, LaTeX, or code chunks.
    -   **Do not proceed if errors or warnings occur.** Analyze the error messages (paying attention to line numbers or specific warnings like 'fenced div' or LaTeX errors), identify the cause (often related to recent edits), fix the issue, and re-render successfully before continuing.
    -   Ensure all cross-references work.
    -   Check that all figures and tables are properly labeled/captioned as requested.
    -   Verify that the final prose flows naturally.
    -   If compilation warnings or errors persist after attempts to fix:
        -   DO report them clearly to the user, explaining the error and the attempted fixes.
        -   DO wait for user guidance before proceeding. 