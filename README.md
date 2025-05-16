# COBOL Electric Bill Calculator

A COBOL program that calculates electricity bills based on usage and customer type. This program demonstrates basic COBOL programming concepts including:

- Data Division and Working Storage
- User Input/Output
- Conditional Logic
- Mathematical Calculations
- Multi-tier Pricing
- Customer Loyalty Discounts

## Features

- Calculates electricity bills using a two-tier pricing system
- Applies different loyalty discount rates based on customer entity type
- Includes tax calculations
- Provides detailed bill breakdown

## Usage

To run the program:

1. Compile the COBOL source file:
   ```bash
   cobc -x -o sampleinvoice2 src/sampleinvoice2.cob
   ```

2. Run the compiled program:
   ```bash
   ./sampleinvoice2
   ```

3. Follow the prompts to enter:
   - Customer Name
   - Customer Entity (A-F)
   - Usage in KWH

## Customer Entity Types and Discounts

- Entity A: 75% discount
- Entity B: 50% discount
- Entity C: 25% discount
- Entity D: 15% discount
- Entity E: 15% discount
- Entity F: 5% discount
- Other: No discount
