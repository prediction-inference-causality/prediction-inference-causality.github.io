# Translation Guide

::: {.callout-warning}
## CRITICAL WARNING: Math and Code Handling

### Decision Tree for Math and Code Modifications
1. IF user has NOT explicitly requested changes to math or code:
   - DO NOT modify any math blocks
   - DO NOT modify any code blocks
   - DO NOT suggest changes to math or code
   - DO NOT rewrite math or code in different notation
   - DO NOT "improve" or "optimize" math or code
   - DO NOT fix perceived errors in math or code
   - DO NOT change formatting of math or code
   - DO NOT add or remove comments in code
   - DO NOT change variable names in code
   - DO NOT change mathematical symbols or notation
   - DO NOT change \qqtext{} content in math blocks
   - DO NOT change the structure of equations
   - DO NOT change the structure of code blocks
   - DO NOT change the order of mathematical operations
   - DO NOT change the order of code statements
   - DO NOT change any aspect of math or code without explicit request

2. IF you notice potential issues in math or code:
   - DO point out the issue to the user
   - DO NOT attempt to fix the issue
   - DO NOT suggest fixes unless specifically asked
   - DO NOT make any changes without explicit permission

3. IF user has explicitly requested changes to math or code:
   - DO make ONLY the specific changes requested
   - DO NOT make additional changes
   - DO NOT "improve" other aspects
   - DO NOT change anything not explicitly mentioned
   - DO NOT modify surrounding math or code

### Examples of Prohibited Actions
- ❌ "I'll fix this equation to be more clear..."
- ❌ "Let me optimize this code..."
- ❌ "I'll rewrite this in a better notation..."
- ❌ "I'll add some helpful comments..."
- ❌ "I'll fix this error in the math..."
- ❌ "I'll improve the formatting..."

### Examples of Allowed Actions
- ✅ "I notice a potential issue in this equation..."
- ✅ "There might be an error in this code..."
- ✅ "This math block seems to have a problem..."
- ✅ "This code might not work as intended..."

This is the most important rule in these guidelines. The mathematical notation and code in the documents are carefully crafted for pedagogical purposes. Even seemingly small changes can significantly impact the learning experience.
:::

## Overview
This guide describes how to translate a lecture presentation (lecture/LectureX.qmd) into a prose version (lecture/LectureX-prose.qmd). The goal is to maintain all content while improving readability and flow.

## Writing Style Preferences

1. **Faithfulness to Original Text**
   - Preserve the original text unless specifically asked to change it
   - Only make the specific changes requested, not "improvements" to surrounding text
   - Maintain the direct, conversational tone of the original text

2. **Prose Style**
   - Use shorter, more direct sentences
   - Replace colons and m-dashes with periods where appropriate
   - Keep sentence fragments when they serve the pedagogical purpose
   - Use lists to break down concepts
   - Maintain a conversational, lecture-like quality
   - Use "we" and "you" to engage the reader directly
   - Include parenthetical explanations and asides
   - Use footnotes for additional context or references
   - Start sections with clear summaries of what's coming
   - Use examples and analogies to explain concepts
   - Mix formal mathematical notation with informal explanations

3. **Specific Formatting**
   - Use triple dashes (---) instead of double dashes (--) or single dashes (-)
   - Preserve sentences ending in "like this" or similar phrases
   - Use bullet points and sub-bullets for hierarchical organization
   - Maintain consistent voice throughout the document
   - Use code blocks with clear labels and explanations
   - Include visualizations with descriptive captions
   - Use cross-references to other sections or exercises

4. **Mathematical Notation**
   - Use consistent notation (e.g., $Y_i$ and $y_j$ for samples and population)
   - Use \qqtext{} for explanatory text in equations
   - Clearly distinguish between mathematical concepts and real-world interpretations
   - Use italics for emphasis on key terms
   - Clearly distinguish between population parameters and sample statistics
   - Define mathematical operators and symbols before use
   - Use aligned equations for complex expressions
   - Include explanatory text within math blocks

5. **Mathematical Writing**
   - Include explanatory text directly in math blocks using \qqtext{}
   - Use math blocks for both equations and conceptual explanations
   - Maintain conversational tone within mathematical notation
   - Use math blocks to highlight important concepts
   - Mix text and math in the same block when appropriate
   - Use mathematical notation to reinforce concepts
   - Include examples of calculations
   - Show step-by-step derivations when helpful

6. **Code Style**
   - Write code that closely mirrors mathematical notation
   - Use clear variable names that match mathematical symbols
   - Include comments that explain the mathematical concepts
   - Break complex calculations into steps
   - Use functions to encapsulate repeated operations
   - Include visualizations to illustrate concepts
   - Show both simple and complex implementations when helpful

## Translation Process

### Before Starting
1. Ask which lecture to translate if not specified
2. Confirm the source file (lecture/LectureX.qmd) exists
3. Create the target file (lecture/LectureX-prose.qmd)
4. IMPORTANT: Never make any changes to the original LectureX.qmd file

### Translation Steps

1. **Initial Pass: Preserve All Content**
   - First, create a version where every section from the presentation appears in the prose
   - Keep all content, even if it seems redundant
   - Maintain the same section structure as the presentation
   - Maintain original order of all content, including figures and tables
   - Keep visual structure intact when converting from tabs to prose
   - This ensures no content is lost in the initial transformation

2. **Title and Structure Changes**
   - Use the presentation's subtitle as the main title
   - Remove the original title if it's just "Lecture X"
   - Convert section headers to be more descriptive rather than numbered steps
   - Replace "Step X" with descriptive section titles that reflect the content

3. **Prose Style and Flow**
   - Study the style in homework/homework*.qmd
   - Note the tone, level of formality, and writing patterns
   - Pay attention to how technical concepts are explained
   - Observe how transitions are made between sections
   - Notice how examples are introduced and discussed
   - Match the level of detail and explanation
   - Use similar sentence structures and paragraph organization
   - Maintain consistent voice and perspective
   - First pass: Maintain original bullet point emphasis/hierarchy
   - Second pass: Can propose improvements to bullet structure and flow

4. **Content Organization**
   - Convert panel-tabsets into flowing prose, except for:
     - Visualizations showing different views of the same data
     - Code examples that benefit from side-by-side comparison
   - Add transitions between sections to improve narrative flow
   - Remove redundant content that was split across tabs
   - Group related content together
   - Ensure each section flows naturally into the next

5. **References and Labels**
   - Add proper labels to all tables and figures (e.g., `#tbl-predictions`)
   - Add descriptive captions to tables
   - Add cross-references between sections using `@fig-` and `@tbl-` labels
   - Convert vague references (e.g., "the plot we just looked at") to explicit cross-references
   - Ensure all code chunks are properly labeled:
     - Use `#| label: fig-` for figures
     - Use `#| label: tbl-` for tables
   - Add labels/IDs to plots/tables if needed to support cross-references

6. **Specific Text Changes**
   - Replace "Today we'll" with "In this chapter, we'll"
   - Remove references to specific class days (e.g., "on Friday")
   - Ensure consistent formatting of percentages and numbers
   - Convert em-dashes to proper LaTeX notation (`---`)

7. **Two-Pass Approach**
   - First pass: Focus on structural conversion and content preservation
     - Maintain original order and structure
     - Convert tabs to prose while keeping visual order
     - Add necessary labels and cross-references
     - Preserve all mathematical notation exactly
     - Maintain original bullet point emphasis/hierarchy
   - Second pass: Propose improvements
     - Suggest additional context for mathematical notation
     - Propose improvements to bullet structure and flow
     - Suggest better transitions between sections
     - Identify sections that could be merged for better flow
     - All improvements require approval before implementation

8. **Final Verification**
   - Ensure all cross-references work
   - Check that all figures and tables are properly labeled
   - Verify that the prose flows naturally
   - Ensure consistent formatting throughout
   - Verify that all code chunks are properly labeled
   - Ensure that all panel-tabsets are properly formatted
   - Verify that all mathematical expressions remain unchanged
   - Check that the tone and style match homework/homework*.qmd
   - Ensure consistent use of terminology
   - Run `quarto render` to check for compilation issues
   - If compilation warnings or errors occur:
     - DO NOT automatically fix them
     - DO report them to the user
     - DO suggest potential fixes
     - DO wait for explicit approval before implementing any fixes
     - DO NOT make any changes to math blocks or code without permission
   - If the document compiles successfully:
     - DO open the generated HTML file in a browser
     - DO verify that all mathematical expressions render correctly in the HTML
     - DO check that all cross-references work in the HTML output
     - DO ensure all figures and tables appear correctly in the HTML
     - DO verify that all code blocks are properly formatted in the HTML
     - DO check that all panel-tabsets display correctly in the HTML
     - DO report any visual or functional issues in the HTML to the user 