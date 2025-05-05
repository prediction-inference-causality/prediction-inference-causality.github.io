# Translation Guide

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
This guide describes how to translate a lecture presentation (lecture/LectureX.qmd) into a prose version (lecture/LectureX-prose.qmd). The goal is to maintain all content while improving readability and flow.

## Writing Style Preferences
- Preserve the original text unless specifically asked to change it
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

1. **Initial Pass: Convert Bullet Points to Prose**
   - Convert each bullet point into a complete sentence
   - Maintain the same section structure as the presentation
   - Keep all content, even if it seems redundant
   - Maintain original order of all content

2. **Title and Structure Changes**
   - Use the presentation's subtitle as the main title
   - Remove the original title if it's just "Lecture X"
   - Convert section headers to be more descriptive rather than numbered steps

3. **Prose Style and Flow**
   - Study the style in homework/homework*.qmd
   - Match the level of detail and explanation
   - Use similar sentence structures and paragraph organization
   - Maintain consistent voice and perspective

4. **Content Organization**
   - Convert panel-tabsets into flowing prose, except for:
     - Visualizations showing different views of the same data
     - Code examples that benefit from side-by-side comparison
   - Add transitions between sections to improve narrative flow

5. **References and Labels**
   - Add proper labels to all tables and figures (e.g., `#tbl-predictions`)
   - Add descriptive captions to tables
   - Add cross-references between sections using `@fig-` and `@tbl-` labels
   - Convert vague references to explicit cross-references

6. **Specific Text Changes**
   - Replace "Today we'll" with "In this chapter, we'll"
   - Remove references to specific class days
   - Ensure consistent formatting of percentages and numbers

7. **Final Verification**
   - Ensure all cross-references work
   - Check that all figures and tables are properly labeled
   - Verify that the prose flows naturally
   - Run `quarto render` to check for compilation issues
   - If compilation warnings or errors occur:
     - DO NOT automatically fix them
     - DO report them to the user
     - DO wait for explicit approval before implementing any fixes 