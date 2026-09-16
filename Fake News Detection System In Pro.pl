% Fake News Detection System in Prolog
% This system analyzes news articles based on multiple criteria

% Knowledge base of verified sources
verified_source(bbc).
verified_source(reuters).
verified_source(ap_news).
verified_source(guardian).
verified_source(nyt).

% Knowledge base of unreliable sources
unreliable_source(fake_daily).
unreliable_source(conspiracy_times).
unreliable_source(clickbait_central).

% Sensational keywords that might indicate fake news
sensational_keyword(shocking).
sensational_keyword(unbelievable).
sensational_keyword(miracle).
sensational_keyword(exposed).
sensational_keyword(secret).
sensational_keyword(they_dont_want_you_to_know).

% Credibility indicators
has_author(Article, yes) :- article_info(Article, author, _).
has_author(Article, no) :- \+ article_info(Article, author, _).

has_date(Article, yes) :- article_info(Article, date, _).
has_date(Article, no) :- \+ article_info(Article, date, _).

has_sources_cited(Article, yes) :- article_info(Article, sources_cited, Count), Count > 0.
has_sources_cited(Article, no) :- article_info(Article, sources_cited, 0).

% Analyze emotional language
high_emotional_language(Article) :- 
    article_info(Article, emotional_score, Score), 
    Score > 7.

moderate_emotional_language(Article) :- 
    article_info(Article, emotional_score, Score), 
    Score >= 4, Score =< 7.

low_emotional_language(Article) :- 
    article_info(Article, emotional_score, Score), 
    Score < 4.

% Check for sensationalism
contains_sensational_words(Article) :-
    article_info(Article, keywords, Keywords),
    member(Word, Keywords),
    sensational_keyword(Word).

% Grammar and spelling quality check
poor_grammar(Article) :- 
    article_info(Article, grammar_score, Score), 
    Score < 4.

good_grammar(Article) :- 
    article_info(Article, grammar_score, Score), 
    Score >= 7.

% URL analysis
suspicious_url(Article) :-
    article_info(Article, url, URL),
    (contains_multiple_hyphens(URL) ; ends_with_odd_extension(URL)).

contains_multiple_hyphens(URL) :- atom_chars(URL, Chars), count_char(Chars, '-', Count), Count > 3.
ends_with_odd_extension(URL) :- sub_atom(URL, _, _, 0, '.co.xyz').
ends_with_odd_extension(URL) :- sub_atom(URL, _, _, 0, '.info').

% Helper predicate to count characters
count_char([], _, 0).
count_char([H|T], Char, Count) :-
    (H = Char -> count_char(T, Char, Count1), Count is Count1 + 1
    ; count_char(T, Char, Count)).

% Fact-checking cross-reference
contradicts_known_facts(Article) :-
    article_info(Article, claims, Claims),
    member(Claim, Claims),
    known_false_claim(Claim).

% Some known false claims
known_false_claim(earth_is_flat).
known_false_claim(vaccines_cause_autism).
known_false_claim(5g_spreads_virus).

% Calculate credibility score (0-10)
calculate_credibility(Article, Score) :-
    (article_info(Article, source, Source), verified_source(Source) -> S1 = 3 ; S1 = 0),
    (article_info(Article, source, Source), unreliable_source(Source) -> S2 = -3 ; S2 = 0),
    (has_author(Article, yes) -> S3 = 1 ; S3 = 0),
    (has_date(Article, yes) -> S4 = 1 ; S4 = 0),
    (has_sources_cited(Article, yes) -> S5 = 2 ; S5 = 0),
    (contains_sensational_words(Article) -> S6 = -2 ; S6 = 0),
    (high_emotional_language(Article) -> S7 = -1 ; S7 = 0),
    (good_grammar(Article) -> S8 = 1 ; S8 = 0),
    (poor_grammar(Article) -> S9 = -2 ; S9 = 0),
    (suspicious_url(Article) -> S10 = -2 ; S10 = 0),
    (contradicts_known_facts(Article) -> S11 = -4 ; S11 = 0),
    TotalScore is S1 + S2 + S3 + S4 + S5 + S6 + S7 + S8 + S9 + S10 + S11 + 5,
    (TotalScore > 10 -> Score = 10 ; (TotalScore < 0 -> Score = 0 ; Score = TotalScore)).

% Classification rules
classify(Article, real) :-
    calculate_credibility(Article, Score),
    Score >= 7.

classify(Article, likely_real) :-
    calculate_credibility(Article, Score),
    Score >= 5, Score < 7.

classify(Article, uncertain) :-
    calculate_credibility(Article, Score),
    Score >= 3, Score < 5.

classify(Article, likely_fake) :-
    calculate_credibility(Article, Score),
    Score >= 1, Score < 3.

classify(Article, fake) :-
    calculate_credibility(Article, Score),
    Score < 1.

% Generate detailed report
generate_report(Article) :-
    format('~n=== FAKE NEWS DETECTION REPORT ===~n', []),
    format('Article: ~w~n', [Article]),
    format('~n--- Credibility Analysis ---~n', []),
    calculate_credibility(Article, Score),
    format('Credibility Score: ~w/10~n', [Score]),
    classify(Article, Classification),
    format('Classification: ~w~n', [Classification]),
    format('~n--- Detailed Factors ---~n', []),
    (article_info(Article, source, Source) -> 
        format('Source: ~w~n', [Source]) ; 
        format('Source: Unknown~n', [])),
    (has_author(Article, yes) -> 
        format('Author: Present~n', []) ; 
        format('Author: Missing (Red Flag)~n', [])),
    (has_sources_cited(Article, yes) -> 
        format('Citations: Present~n', []) ; 
        format('Citations: Missing (Red Flag)~n', [])),
    (contains_sensational_words(Article) -> 
        format('Sensationalism: Detected (Red Flag)~n', []) ; 
        format('Sensationalism: Not detected~n', [])),
    (contradicts_known_facts(Article) -> 
        format('Fact Check: Contradicts known facts (Major Red Flag)~n', []) ; 
        format('Fact Check: No contradictions found~n', [])),
    format('~n=================================~n', []).

% Sample data for testing
article_info(article1, source, bbc).
article_info(article1, author, john_smith).
article_info(article1, date, '2024-01-15').
article_info(article1, sources_cited, 3).
article_info(article1, emotional_score, 3).
article_info(article1, grammar_score, 8).
article_info(article1, keywords, [research, study, scientists]).
article_info(article1, url, 'bbc.com/news/science').
article_info(article1, claims, [climate_warming]).

article_info(article2, source, clickbait_central).
article_info(article2, sources_cited, 0).
article_info(article2, emotional_score, 9).
article_info(article2, grammar_score, 3).
article_info(article2, keywords, [shocking, exposed, secret]).
article_info(article2, url, 'click-bait-news-today.co.xyz').
article_info(article2, claims, [vaccines_cause_autism]).

article_info(article3, source, reuters).
article_info(article3, author, jane_doe).
article_info(article3, date, '2024-01-20').
article_info(article3, sources_cited, 5).
article_info(article3, emotional_score, 4).
article_info(article3, grammar_score, 9).
article_info(article3, keywords, [government, policy, report]).
article_info(article3, url, 'reuters.com/world').
article_info(article3, claims, [economic_growth]).
