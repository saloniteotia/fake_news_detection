# FAKE NEWS DETECTION SYSTEM
## OVERVIEW OF THE PROJECT
-A Prolog-based system to analyze and detect fake news in articles.

-Uses knowledge bases of verified and unreliable sources for credibility checks.

-Flags sensational keywords and checks emotional language intensity.

-Assesses presence of author, date, and cited sources as credibility indicators.

-Evaluates grammar quality and suspicious URL patterns.

-Fact-checks claims against known falsehoods.

-Calculates a credibility score to classify articles as real, fake, or uncertain.

-Generates detailed reports highlighting credibility and red flags.

## FEATURES
-The system analyzes news articles for credibility by cross-referencing verified and unreliable source databases.

-It detects the presence of sensational keywords and measures the emotional intensity of the article’s language to flag misleading content.

-Metadata checks include verification of author information, publication date, and whether credible sources are cited.

-Grammar and spelling quality are evaluated, as poor language often corresponds with lower credibility.

-The system analyzes URLs for suspicious characteristics such as multiple hyphens or uncommon extensions.

-Claims are fact-checked against a knowledge base of known falsehoods to detect contradictions.

-A composite credibility score is calculated, scoring articles from real to fake, and detailed reports are generated outlining reasons for suspicion or authenticity.

## TECHNOLOGIES/TOOLS USED
-Written in Prolog, leveraging its strength in logic programming and knowledge representation.

-Knowledge bases storing verified and unreliable news sources and sensational keywords.

-Natural Language Processing like emotional language detection and keyword matching.

-Fact-checking algorithms and rule-based reasoning to assess claim veracity.

-Logic-based classification rules to assign credibility scores and labels.
## STEPS TO INSTALL AND RUN THE PROJECT
-Install a Prolog environment or interpreter compatible with the program (e.g., SWI-Prolog).

-Load all Prolog source files including the main code and knowledge bases into the environment.

-Input the news article data for analysis in the specified format.

-Run the program’s main predicate to perform fake news detection.

-Output will include credibility classification and a detailed report.

## INSTRUCTIONS FOR TESTING
-Prepare a set of sample news articles with known credibility status.

-Input them individually to the system and observe classification results.

-Confirm whether the system correctly identifies real and fake articles.

-Review the generated reports for each test to understand the detected flags and score.

-Adjust input formats or knowledge bases if needed for improved accuracy.
