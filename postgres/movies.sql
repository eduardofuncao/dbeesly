-- IMDB Top 200 Movies Database with Nicolas Cage Films
-- For testing database manager search function

-- Drop existing tables if they exist
DROP TABLE IF EXISTS movie_actors CASCADE;
DROP TABLE IF EXISTS actors CASCADE;
DROP TABLE IF EXISTS movies CASCADE;

-- Movies table
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    rating DECIMAL(3,1) NOT NULL,
    genre VARCHAR(100),
    director VARCHAR(150),
    runtime INT, -- in minutes
    imdb_id VARCHAR(20) UNIQUE,
    plot TEXT,
    poster_url VARCHAR(500)
);

-- Actors table
CREATE TABLE actors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    birth_year INT,
    nationality VARCHAR(100)
);

-- Movie-Actors junction table (many-to-many)
CREATE TABLE movie_actors (
    movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
    actor_id INT REFERENCES actors(id) ON DELETE CASCADE,
    character_name VARCHAR(200),
    billing INT, -- Order in credits (1 = top billing)
    PRIMARY KEY (movie_id, actor_id)
);

-- Create indexes for search performance
CREATE INDEX idx_movies_title ON movies(title);
CREATE INDEX idx_movies_rating ON movies(rating DESC);
CREATE INDEX idx_movies_year ON movies(year);
CREATE INDEX idx_actors_name ON actors(name);
CREATE INDEX idx_movie_actors_actor ON movie_actors(actor_id);

-- Insert Nicolas Cage
INSERT INTO actors (name, birth_year, nationality) VALUES
('Nicolas Cage', 1964, 'American');

-- Insert other major actors
INSERT INTO actors (name, birth_year, nationality) VALUES
('Al Pacino', 1940, 'American'),
('Marlon Brando', 1924, 'American'),
('James Caan', 1940, 'American'),
('Robert De Niro', 1943, 'American'),
('Ray Liotta', 1954, 'American'),
('Joe Pesci', 1943, 'American'),
('Tim Robbins', 1958, 'American'),
('Morgan Freeman', 1937, 'American'),
('Harrison Ford', 1942, 'American'),
('Tom Hanks', 1956, 'American'),
('Leonardo DiCaprio', 1974, 'American'),
('Christian Bale', 1974, 'British'),
('Heath Ledger', 1979, 'Australian'),
('Ian McKellen', 1939, 'British'),
('Elijah Wood', 1981, 'American'),
('Sean Astin', 1971, 'American'),
('Viggo Mortensen', 1958, 'American'),
('Brad Pitt', 1963, 'American'),
('Edward Norton', 1969, 'American'),
('Helena Bonham Carter', 1966, 'British'),
('Kevin Spacey', 1959, 'American'),
('Gabriel Byrne', 1950, 'Irish'),
('Benicio del Toro', 1967, 'Puerto Rican'),
('Anthony Hopkins', 1937, 'British'),
('Jodie Foster', 1962, 'American'),
('Scott Glenn', 1941, 'American'),
('Ted Levine', 1957, 'American'),
('Russell Crowe', 1964, 'New Zealander'),
('Joaquin Phoenix', 1974, 'American'),
('Oliver Reed', 1938, 'British'),
('Richard Harris', 1930, 'Irish'),
('Djimon Hounsou', 1964, 'Beninese'),
('Ralph Fiennes', 1962, 'British'),
('John Hurt', 1940, 'British'),
('Ray Winstone', 1957, 'British'),
('Tom Hardy', 1977, 'British'),
('Emily Watson', 1967, 'British'),
('Liam Neeson', 1952, 'Irish'),
('Ben Kingsley', 1943, 'British'),
('Carrie-Anne Moss', 1967, 'British'),
('Laurence Fishburne', 1961, 'American'),
('Hugo Weaving', 1960, 'Australian'),
('Gloria Foster', 1936, 'American'),
('Keanu Reeves', 1964, 'Canadian'),
('Mel Gibson', 1956, 'American'),
('Sophie Marceau', 1966, 'French'),
('Patrick McGoohan', 1928, 'American'),
('David Thewlis', 1963, 'British'),
('Bruce Willis', 1955, 'American'),
('Alan Rickman', 1946, 'British'),
('Bonnie Bedelia', 1948, 'American'),
('Milla Jovovich', 1975, 'Ukrainian'),
('Gary Oldman', 1958, 'British'),
('Dustin Hoffman', 1937, 'American'),
('Tom Cruise', 1962, 'American'),
('Cuba Gooding Jr.', 1968, 'American'),
('Renee Zellweger', 1969, 'American'),
('Gene Hackman', 1930, 'American'),
('Denzel Washington', 1954, 'American'),
('Meg Ryan', 1961, 'American'),
('Matt Damon', 1970, 'American'),
('Danny DeVito', 1944, 'American'),
('James Cromwell', 1940, 'American'),
('Robin Williams', 1951, 'American'),
('Robert Duvall', 1931, 'American'),
('Philip Seymour Hoffman', 1967, 'American'),
('Clint Eastwood', 1930, 'American'),
('Hilary Swank', 1974, 'American'),
('Samuel L. Jackson', 1948, 'American'),
('John Travolta', 1954, 'American'),
('Uma Thurman', 1970, 'American'),
('Harvey Keitel', 1939, 'American'),
('Tim Roth', 1961, 'British'),
('Amanda Plummer', 1957, 'American'),
('Maria de Medeiros', 1965, 'Portuguese'),
('Ving Rhames', 1959, 'American'),
('Eric Stoltz', 1961, 'American'),
('Stephen Tobolowsky', 1951, 'American'),
('William H. Macy', 1950, 'American'),
('Frances McDormand', 1957, 'American'),
('Steve Buscemi', 1957, 'American'),
('Peter Stormare', 1953, 'Swedish'),
('Kristin Rudrüd', 1959, 'American'),
('Tony Shalhoub', 1953, 'American'),
('Jack Nicholson', 1937, 'American'),
('Shelley Duvall', 1949, 'American'),
('Danny Lloyd', 1972, 'American'),
('Scatman Crothers', 1910, 'American'),
('Barry Nelson', 1917, 'American'),
('Philip Stone', 1924, 'British'),
('Joe Pesci', 1943, 'American'),
('Robert De Niro', 1943, 'American'),
('Sharon Stone', 1958, 'American'),
('Martin Landau', 1928, 'American'),
('Al Pacino', 1940, 'American'),
('Alec Baldwin', 1958, 'American'),
('Matthew McConaughey', 1969, 'American'),
('Anne Hathaway', 1982, 'American'),
('Javier Bardem', 1969, 'Spanish'),
('Josh Brolin', 1968, 'American'),
('Woody Harrelson', 1961, 'American'),
('Kelly Macdonald', 1976, 'British'),
('Ted Danson', 1947, 'American'),
('Colin Farrell', 1976, 'Irish'),
('Abigail Breslin', 1996, 'American'),
('Greg Kinnear', 1963, 'American'),
('Alan Arkin', 1934, 'American'),
('Paul Dano', 1994, 'American'),
('Michael Caine', 1933, 'British'),
('Bale', 1974, 'British'),
('Katie Holmes', 1978, 'American'),
('Michael Gough', 1916, 'British'),
('Liam Neeson', 1952, 'Irish'),
('Gary Oldman', 1958, 'British'),
('Aaron Eckhart', 1968, 'American'),
('Maggie Gyllenhaal', 1977, 'American'),
('Monica Bellucci', 1964, 'Italian'),
('Giovanni Ribisi', 1974, 'American'),
('James Caan', 1940, 'American'),
('Robert Duvall', 1931, 'American'),
('Diane Keaton', 1946, 'American'),
('Bridget Fonda', 1964, 'American'),
('Sofia Coppola', 1971, 'American'),
('Talisa Soto', 1967, 'American'),
('Frank Vincent', 1939, 'American'),
('John Cazale', 1935, 'American'),
('Sterling Hayden', 1916, 'American'),
('Talia Shire', 1946, 'American'),
('Richard S. Castellano', 1933, 'American'),
('James Cann', 1940, 'American'),
('Robert Duvall', 1931, 'American'),
('Diane Keaton', 1946, 'American'),
('Al Pacino', 1940, 'American'),
('Marlon Brando', 1924, 'American');

-- Insert top 200 IMDB movies with Nicolas Cage films included
INSERT INTO movies (title, year, rating, genre, director, runtime, imdb_id, plot) VALUES
('The Shawshank Redemption', 1994, 9.3, 'Drama', 'Frank Darabont', 142, 'tt0111161', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),
('The Godfather', 1972, 9.2, 'Crime, Drama', 'Francis Ford Coppola', 175, 'tt0068646', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.'),
('The Dark Knight', 2008, 9.0, 'Action, Crime, Drama', 'Christopher Nolan', 152, 'tt0468569', 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological tests.'),
('The Godfather Part II', 1974, 9.0, 'Crime, Drama', 'Francis Ford Coppola', 202, 'tt0071562', 'The early life and career of Vito Corleone in 1920s New York is portrayed while his son expands the family business.'),
('12 Angry Men', 1957, 9.0, 'Crime, Drama', 'Sidney Lumet', 96, 'tt0050081', 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.'),
('Schindler''s List', 1993, 8.9, 'Biography, Drama, History', 'Steven Spielberg', 195, 'tt0108052', 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce.'),
('The Lord of the Rings: The Return of the King', 2003, 8.9, 'Action, Adventure, Drama', 'Peter Jackson', 201, 'tt0167260', 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam.'),
('Pulp Fiction', 1994, 8.9, 'Crime, Drama', 'Quentin Tarantino', 154, 'tt0110912', 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.'),
('Fight Club', 1999, 8.8, 'Drama', 'David Fincher', 139, 'tt0137523', 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club.'),
('The Lord of the Rings: The Fellowship of the Ring', 2001, 8.8, 'Action, Adventure, Drama', 'Peter Jackson', 178, 'tt0120737', 'A meek Hobbit and eight companions set out on a journey to destroy the powerful One Ring.'),
('Forrest Gump', 1994, 8.8, 'Drama, Romance', 'Robert Zemeckis', 142, 'tt0109830', 'The presidencies of Kennedy and Johnson through the eyes of an Alabama man with an IQ of 75.'),
('Inception', 2010, 8.8, 'Action, Adventure, Sci-Fi', 'Christopher Nolan', 148, 'tt1375666', 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task.'),
('The Lord of the Rings: The Two Towers', 2002, 8.8, 'Action, Adventure, Drama', 'Peter Jackson', 179, 'tt0167261', 'While Frodo and Sam edge closer to Mordor, the fellowship separates and Aragorn takes on his destiny.'),
('The Matrix', 1999, 8.7, 'Action, Sci-Fi', 'Lana Wachowski, Lilly Wachowski', 136, 'tt0133093', 'A computer hacker learns about the true nature of reality and his role in the war against its controllers.'),
('Goodfellas', 1990, 8.7, 'Biography, Crime, Drama', 'Martin Scorsese', 146, 'tt0099685', 'The story of Henry Hill and his life in the mob, covering his relationship with his wife and his partners.'),
('One Flew Over the Cuckoo''s Nest', 1975, 8.6, 'Drama', 'Milos Forman', 133, 'tt0073486', 'A criminal pleads insanity and is admitted to a mental institution, where he rebels against the oppressive nurse.'),
('Seven Samurai', 1954, 8.6, 'Action, Adventure, Drama', 'Akira Kurosawa', 207, 'tt0047478', 'A poor village under attack by bandits recruits seven unemployed samurai to help them defend themselves.'),
('Se7en', 1995, 8.6, 'Crime, Drama, Mystery', 'David Fincher', 127, 'tt0114369', 'Two detectives hunt a serial killer who uses the seven deadly sins as his motives.'),
('The Silence of the Lambs', 1991, 8.6, 'Crime, Drama, Thriller', 'Jonathan Demme', 118, 'tt0102926', 'A young F.B.I. cadet must receive the help of an incarcerated cannibalistic serial killer.'),
('Gladiator', 2000, 8.5, 'Action, Adventure, Drama', 'Ridley Scott', 155, 'tt0172495', 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family.'),
('Saving Private Ryan', 1998, 8.6, 'Drama, War', 'Steven Spielberg', 169, 'tt0120815', 'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper.'),
('City of God', 2002, 8.6, 'Crime, Drama', 'Fernando Meirelles', 130, 'tt0317248', 'Two boys growing up in a violent neighborhood of Rio de Janeiro take different paths.'),
('The Green Mile', 1999, 8.6, 'Crime, Drama, Fantasy', 'Frank Darabont', 189, 'tt0120689', 'The lives of guards on death row are affected by one of their charges.'),
('Interstellar', 2014, 8.6, 'Adventure, Drama, Sci-Fi', 'Christopher Nolan', 169, 'tt0816692', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.'),
('Parasite', 2019, 8.5, 'Comedy, Drama, Thriller', 'Bong Joon Ho', 132, 'tt6751668', 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.'),
('Leon: The Professional', 1994, 8.5, 'Action, Crime, Drama', 'Luc Besson', 110, 'tt0110413', 'Mathilda, a 12-year-old girl, is reluctantly taken in by Léon, a professional assassin.'),
('The Lion King', 1994, 8.5, 'Animation, Adventure, Drama', 'Roger Allers, Rob Minkoff', 88, 'tt0110357', 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne.'),
('Back to the Future', 1985, 8.5, 'Adventure, Comedy, Sci-Fi', 'Robert Zemeckis', 116, 'tt0088763', 'Marty McFly, a 17-year-old high school student, is accidentally sent thirty years into the past.'),
('The Usual Suspects', 1995, 8.5, 'Crime, Drama, Mystery', 'Bryan Singer', 106, 'tt0114814', 'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat.'),
('The Prestige', 2006, 8.5, 'Drama, Mystery, Sci-Fi', 'Christopher Nolan', 130, 'tt0482571', 'After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion.'),
('American History X', 1998, 8.5, 'Crime, Drama', 'Tony Kaye', 119, 'tt0120586', 'A former neo-nazi skinhead tries to prevent his younger brother from going down the same wrong path.'),
('The Pianist', 2002, 8.5, 'Biography, Drama, Music', 'Roman Polanski', 150, 'tt0253474', 'A Polish Jewish musician struggles to survive the destruction of the Warsaw ghetto of World War II.'),
('Cool Hand Luke', 1967, 8.1, 'Crime, Drama', 'Stuart Rosenberg', 127, 'tt0061512', 'A man refuses to conform to life in a rural prison.'),
('Requiem for a Dream', 2000, 8.3, 'Drama', 'Darren Aronofsky', 102, 'tt0180093', 'The drug-induced utopias of four Coney Island people are shattered when their addictions become stronger.'),
('Whiplash', 2014, 8.5, 'Drama, Music', 'Damien Chazelle', 106, 'tt2582802', 'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor.'),
('The Intouchables', 2011, 8.5, 'Biography, Comedy, Drama', 'Olivier Nakache', 112, 'tt1675434', 'After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caregiver.'),
('Modern Times', 1936, 8.5, 'Comedy, Drama, Romance', 'Charlie Chaplin', 87, 'tt0027977', 'The Tramp struggles to live in modern industrial society with the help of a young homeless woman.'),
('Once Upon a Time in America', 1984, 8.3, 'Crime, Drama', 'Sergio Leone', 229, 'tt0087843', 'A former Prohibition-era Jewish gangster returns to the Lower East Side of Manhattan over thirty years later.'),
('Casablanca', 1942, 8.5, 'Drama, Romance, War', 'Michael Curtiz', 102, 'tt0034583', 'A cynical expatriate American cafe owner struggles to decide whether or not to help his former lover and her fugitive husband escape the Nazis in French Morocco.'),
('Rear Window', 1954, 8.5, 'Mystery, Thriller', 'Alfred Hitchcock', 112, 'tt0047396', 'A wheelchair-bound photographer spies on his neighbors from his apartment window and becomes convinced one has committed murder.'),
('Apocalypse Now', 1979, 8.4, 'Drama, War', 'Francis Ford Coppola', 147, 'tt0078788', 'During the Vietnam War, Captain Willard is sent on a dangerous mission into Cambodia to assassinate a renegade colonel.'),
('Psycho', 1960, 8.5, 'Crime, Drama, Horror', 'Alfred Hitchcock', 109, 'tt0054215', 'A Phoenix secretary embezzles $40,000 from her employer''s client and goes on the run.'),
('Grave of the Fireflies', 1988, 8.5, 'Animation, Drama, War', 'Isao Takahata', 89, 'tt0095327', 'A young boy and his little sister struggle to survive in Japan during World War II.'),
('Sunset Boulevard', 1950, 8.4, 'Drama, Film-Noir', 'Billy Wilder', 110, 'tt0043014', 'A screenwriter is hired to rework a faded silent film star''s script.'),
('Dr. Strangelove', 1964, 8.4, 'Comedy, War', 'Stanley Kubrick', 95, 'tt0057012', 'An insane general triggers a path to nuclear holocaust that a war room full of politicians and generals frantically try to stop.'),
('The Great Dictator', 1940, 8.4, 'Comedy, Drama, War', 'Charlie Chaplin', 125, 'tt0032553', 'A Jewish barber returns from war to find his country ruled by a dictator.'),
('Cinema Paradiso', 1988, 8.5, 'Drama, Romance', 'Giuseppe Tornatore', 155, 'tt0095765', 'A filmmaker recalls his childhood and his relationship with the village projectionist.'),
('The Departed', 2006, 8.5, 'Crime, Drama, Thriller', 'Martin Scorsese', 151, 'tt0407887', 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.'),
('Memento', 2000, 8.4, 'Mystery, Thriller', 'Christopher Nolan', 113, 'tt0209144', 'A man with short-term memory loss attempts to track down his wife''s murderer.'),
('WALL·E', 2008, 8.4, 'Animation, Adventure, Family', 'Andrew Stanton', 98, 'tt0910970', 'In the distant future, a small waste-collecting robot inadvertently embarks on a space journey.'),
('Django Unchained', 2012, 8.4, 'Drama, Western', 'Quentin Tarantino', 165, 'tt1853728', 'With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.'),
('The Shining', 1980, 8.4, 'Drama, Horror', 'Stanley Kubrick', 146, 'tt0081505', 'A family heads to an isolated hotel for the winter where a sinister presence influences the father into violence.'),
('Paths of Glory', 1957, 8.4, 'Drama, War', 'Stanley Kubrick', 88, 'tt0050825', 'After refusing to attack an enemy position, a general accuses the soldiers of cowardice.'),
('Joker', 2019, 8.4, 'Crime, Drama, Thriller', 'Todd Phillips', 122, 'tt7286456', 'In Gotham City, mentally troubled comedian Arthur Fleck is disregarded and mistreated by society.'),
('The Apartment', 1960, 8.3, 'Comedy, Drama, Romance', 'Billy Wilder', 125, 'tt0053604', 'A man tries to advance his career by renting an apartment to his boss for his extramarital affairs.'),
('A Clockwork Orange', 1971, 8.3, 'Crime, Drama, Sci-Fi', 'Stanley Kubrick', 136, 'tt0066921', 'A delinquent street gang undergoes state-sponsored psychological rehabilitation.'),
('Full Metal Jacket', 1987, 8.3, 'Drama, War', 'Stanley Kubrick', 116, 'tt0093058', 'A pragmatic U.S. Marine observes the dehumanizing effects the Vietnam War has on his fellow recruits.'),
('Amadeus', 1984, 8.4, 'Biography, Drama, Music', 'Milos Forman', 160, 'tt0086879', 'The life of Wolfgang Amadeus Mozart as seen through the eyes of rival composer Antonio Salieri.'),
('Raging Bull', 1980, 8.2, 'Biography, Drama, Sport', 'Martin Scorsese', 129, 'tt0081398', 'The life of boxer Jake LaMotta, whose violence and temper led him to the top but destroyed him outside the ring.'),
('Taxi Driver', 1976, 8.2, 'Crime, Drama', 'Martin Scorsese', 114, 'tt0075314', 'A mentally unstable veteran works as a taxi driver in New York City, where the perceived decadence fuels his urges.'),
('Lawrence of Arabia', 1962, 8.3, 'Adventure, Biography, Drama', 'David Lean', 228, 'tt0056172', 'The story of T.E. Lawrence, the English officer who successfully united and led the Arab tribes against the Turks in World War I.'),
('Double Indemnity', 1944, 8.3, 'Crime, Drama, Film-Noir', 'Billy Wilder', 107, 'tt0036775', 'An insurance representative lets himself be talked into a murder/insurance fraud scheme.'),
('Toy Story 3', 2010, 8.3, 'Animation, Adventure, Comedy', 'Lee Unkrich', 103, 'tt0435761', 'The toys are mistakenly delivered to a day-care center instead of the attic right before Andy leaves for college.'),
('Eternal Sunshine of the Spotless Mind', 2004, 8.3, 'Drama, Romance, Sci-Fi', 'Michel Gondry', 108, 'tt0338013', 'When their relationship turns sour, a couple undergoes a medical procedure to have each other erased from their memories.'),
('Scarface', 1983, 8.3, 'Crime, Drama', 'Brian De Palma', 170, 'tt0086250', 'In 1980 Miami, a determined Cuban immigrant takes over a drug cartel and succumbs to greed.'),
('Inglourious Basterds', 2009, 8.3, 'Adventure, Drama, War', 'Quentin Tarantino', 153, 'tt0361748', 'In Nazi-occupied France during World War II, a plan to assassinate Nazi leaders by a group of Jewish U.S. soldiers coincides with a theatre owner''s vengeful plan.'),
('2001: A Space Odyssey', 1968, 8.3, 'Adventure, Mystery, Sci-Fi', 'Stanley Kubrick', 149, 'tt0062622', 'After discovering a mysterious artifact buried beneath the Lunar surface, mankind sets off on a quest to find its origins.'),
('Singin'' in the Rain', 1952, 8.3, 'Comedy, Musical, Romance', 'Stanley Donen', 103, 'tt0045152', 'A silent film star falls for a chorus girl just as he and his sound technician are trying to transition to talkies.'),
('Toy Story', 1995, 8.3, 'Animation, Adventure, Comedy', 'John Lasseter', 81, 'tt0114709', 'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.'),
('The Treasure of the Sierra Madre', 1948, 8.2, 'Adventure, Drama, Western', 'John Huston', 126, 'tt0040897', 'Fred Dobbs and Bob Curtin meet an old prospector in Mexico and head to the hills to find gold.'),
('The Third Man', 1949, 8.3, 'Film-Noir, Mystery, Thriller', 'Carol Reed', 104, 'tt0041959', 'Pulp novelist Holly Martins travels to shadowy, postwar Vienna, only to find himself investigating the mysterious death of an old friend.'),
('Reservoir Dogs', 1992, 8.3, 'Crime, Drama, Thriller', 'Quentin Tarantino', 99, 'tt0105236', 'After a simple jewelry heist goes terribly wrong, the surviving criminals begin to suspect that one of them is a police informant.'),
('A Separation', 2011, 8.3, 'Drama, Mystery', 'Asghar Farhadi', 123, 'tt1832382', 'A married couple are faced with a difficult decision - to improve the life of their child by moving abroad or to stay in Iran.'),
('My Neighbor Totoro', 1988, 8.1, 'Animation, Comedy, Family', 'Hayao Miyazaki', 86, 'tt0096283', 'When two girls move to the country to be near their ailing mother, they have adventures with the wondrous forest spirits.'),
('Princess Mononoke', 1997, 8.3, 'Animation, Adventure, Fantasy', 'Hayao Miyazaki', 134, 'tt0119698', 'On a journey to find the cure for a Tatarigami''s curse, Ashitaka finds himself in the middle of a war between the forest gods.'),
('Snatch', 2000, 8.2, 'Comedy, Crime', 'Guy Ritchie', 102, 'tt0208092', 'Unscrupulous boxing promoters, violent bookmakers, a Russian gangster and incompetent robbers all vie for a priceless diamond.'),
(' Spirited Away', 2001, 8.6, 'Animation, Adventure, Family', 'Hayao Miyazaki', 125, 'tt0245429', 'During her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits.'),
('The Kid', 1921, 8.2, 'Comedy, Drama, Family', 'Charlie Chaplin', 68, 'tt0012349', 'The Tramp cares for an abandoned child, but events put that relationship in jeopardy.'),
('L.A. Confidential', 1997, 8.2, 'Crime, Drama, Mystery', 'Curtis Hanson', 138, 'tt0119488', 'Three detectives in the corrupt police department of 1950s Los Angeles clash while investigating a murder.'),
('Rebecca', 1940, 8.1, 'Drama, Mystery, Romance', 'Alfred Hitchcock', 130, 'tt0032976', 'A self-conscious woman juggles adjusting to her new role as an aristocrat''s wife and avoiding being intimidated by his first wife''s spectral presence.'),
('Metropolis', 1927, 8.2, 'Drama, Sci-Fi', 'Fritz Lang', 153, 'tt0017131', 'In a futuristic city sharply divided between the working class and the city planners, the son of the city''s mastermind falls in love with a working-class prophet.'),
('North by Northwest', 1959, 8.2, 'Action, Adventure, Mystery', 'Alfred Hitchcock', 136, 'tt0053125', 'A New York City advertising executive goes on the run after being mistaken for a government agent.'),
('12 Years a Slave', 2013, 8.1, 'Biography, Drama, History', 'Steve McQueen', 134, 'tt2024544', 'In the antebellum United States, Solomon Northup, a free black man from upstate New York, is kidnapped and sold into slavery.'),
('Ben-Hur', 1959, 8.1, 'Adventure, Drama, History', 'William Wyler', 212, 'tt0052618', 'When a Jewish prince is betrayed and sent into slavery by a Roman friend, he regains his freedom and comes back for revenge.'),
('The Gold Rush', 1925, 8.2, 'Adventure, Comedy, Drama', 'Charlie Chaplin', 95, 'tt0015864', 'A prospector goes to the Klondike during the 1890s gold rush in hopes of making his fortune, and instead forms a bond with a gold-seeking dog companion.'),
('Vertigo', 1958, 8.3, 'Drama, Mystery, Romance', 'Alfred Hitchcock', 128, 'tt0052357', 'A former police detective juggles his fears and obsessive pursuit of a beautiful woman.'),
('The Great Escape', 1963, 8.2, 'Adventure, Drama, History', 'John Sturges', 172, 'tt0057115', 'Allied prisoners of war plan for a massive escape from a German camp during World War II.'),
('Some Like It Hot', 1959, 8.2, 'Comedy, Music', 'Billy Wilder', 120, 'tt0053291', 'After two male musicians witness a mob hit, they flee the state in an all-female band disguised as women.'),
('Alien', 1979, 8.5, 'Horror, Sci-Fi', 'Ridley Scott', 117, 'tt0078748', 'The crew of a commercial spacecraft encounter a deadly lifeform after investigating a mysterious transmission.'),
('Aliens', 1986, 8.4, 'Action, Adventure, Horror', 'James Cameron', 137, 'tt0090605', 'Ellen Ripley is rescued by a salvage crew after drifting in stasis for 57 years.'),
('Citizen Kane', 1941, 8.3, 'Drama, Mystery', 'Orson Welles', 119, 'tt0033467', 'Following the death of publishing tycoon Charles Foster Kane, reporters scramble to discover the meaning of his final utterance.'),
('The Thing', 1982, 8.1, 'Horror, Mystery, Sci-Fi', 'John Carpenter', 109, 'tt0084787', 'A research team in Antarctica is hunted by a shape-shifting alien that assumes the appearance of its victims.'),
('M', 1931, 8.3, 'Crime, Mystery, Thriller', 'Fritz Lang', 117, 'tt0022100', 'When the police in a German city are unable to catch a child-murderer, other criminals join in the manhunt.'),
('Memories of Murder', 2003, 8.1, 'Crime, Drama, Mystery', 'Bong Joon Ho', 132, 'tt0353969', 'Two detectives try to solve a series of murders in South Korea.'),
('On the Waterfront', 1954, 8.1, 'Crime, Drama', 'Elia Kazan', 108, 'tt0047296', 'An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.'),
('Witness for the Prosecution', 1957, 8.1, 'Crime, Drama, Mystery', 'Billy Wilder', 116, 'tt0051201', 'A veteran British barrister must defend his client in a murder trial that has surprise after surprise.'),
('Heat', 1995, 8.2, 'Action, Crime, Drama', 'Michael Mann', 170, 'tt0113277', 'A group of high-end professional thieves start to feel the heat from police when they unknowingly leave a clue at their latest heist.'),
('The Elephant Man', 1980, 8.1, 'Biography, Drama', 'David Lynch', 124, 'tt0080678', 'A Victorian surgeon rescues a heavily disfigured man who is mistreated while scraping a living as a side-show freak.'),
('A Beautiful Mind', 2001, 8.2, 'Biography, Drama', 'Ron Howard', 135, 'tt0268978', 'After John Nash, a brilliant mathematician, develops schizophrenia, he manages to overcome his condition and win the Nobel Prize.'),
('All About Eve', 1950, 8.2, 'Drama', 'Joseph L. Mankiewicz', 138, 'tt0042192', 'An aspiring actress manipulates her way into Broadway stardom.'),
('Rashomon', 1950, 8.2, 'Crime, Drama, Mystery', 'Akira Kurosawa', 88, 'tt0042876', 'The rape of a bride and the murder of her samurai husband are recalled from the perspectives of a bandit, the bride, the samurai''s ghost and a woodcutter.'),
('Dial M for Murder', 1954, 8.2, 'Crime, Drama, Thriller', 'Alfred Hitchcock', 105, 'tt0046912', 'A tennis player plots the murder of his wealthy wife after she discovers his affair.'),
('Terminator 2: Judgment Day', 1991, 8.5, 'Action, Sci-Fi', 'James Cameron', 137, 'tt0103064', 'A cyborg is sent from the future to protect a boy destined to lead the resistance against machines.'),
('Gone with the Wind', 1939, 8.1, 'Drama, Romance', 'Victor Fleming', 238, 'tt0031381', 'A manipulative Southern belle carries on a turbulent affair with a roguish profiteer during the American Civil War.'),
('Groundhog Day', 1993, 8.0, 'Comedy, Fantasy, Romance', 'Harold Ramis', 101, 'tt0107048', 'A weatherman finds himself living the same day over and over again.'),
('Star Wars: Episode V - The Empire Strikes Back', 1980, 8.7, 'Action, Adventure, Fantasy', 'Irvin Kershner', 124, 'tt0080684', 'After the Rebels are brutally overpowered by the Empire, Luke Skywalker begins his Jedi training.'),
('Fargo', 1996, 8.1, 'Crime, Drama, Thriller', 'Joel Coen', 98, 'tt0116282', 'A car salesmen from Minneapolis who is in debt hires two criminals to kidnap his wife.'),
('Moonlight', 2016, 8.3, 'Drama', 'Barry Jenkins', 111, 'tt4975722', 'A young African-American man grapples with his identity and sexuality while experiencing the everyday struggles of childhood, adolescence, and burgeoning adulthood.'),
('Mad Max: Fury Road', 2015, 8.1, 'Action, Adventure, Sci-Fi', 'George Miller', 120, 'tt1392190', 'In a post-apocalyptic wasteland, a woman rebels against a tyrannical ruler in search of her homeland.'),
('The Bandit', 1996, 8.5, 'Action, Comedy, Crime', 'Galip Yurtsever', 110, 'tt0116458', 'When a bandit leader falls for a beautiful woman, he must choose between love and loyalty.'),
('Catch Me If You Can', 2002, 8.1, 'Biography, Crime, Drama', 'Steven Spielberg', 141, 'tt0264464', 'A true story about Frank Abagnale Jr. who conned millions of dollars worth of checks as a pilot, doctor, and legal prosecutor.'),
('Lock, Stock and Two Smoking Barrels', 1998, 8.1, 'Comedy, Crime', 'Guy Ritchie', 107, 'tt0120735', 'A card shark and his unwilling friends end up in big trouble after they become indebted to a crime boss.'),
('Killer''s Kiss', 1955, 8.2, 'Crime, Drama, Thriller', 'Stanley Kubrick', 67, 'tt0048332', 'A boxer in New York City must protect himself from gangsters after refusing to throw a fight.'),
('Dangal', 2016, 8.4, 'Action, Biography, Drama', 'Nitesh Tiwari', 161, 'tt5074352', 'Former wrestler Mahavir Singh Phogat trains his young daughters Geeta and Babita to follow in his footsteps.'),
('Judgment at Nuremberg', 1961, 8.1, 'Drama, War', 'Stanley Kramer', 179, 'tt0055031', 'In 1948, an American court in occupied Germany tries four Nazi judges for war crimes.'),
('3 Idiots', 2009, 8.4, 'Comedy, Drama', 'Rajkumar Hirani', 170, 'tt1187043', 'Two friends embark on a quest for a lost buddy who inspired them to think differently.'),
('Up', 2009, 8.3, 'Animation, Adventure, Comedy', 'Pete Docter', 96, 'tt1049413', 'An elderly widower flies his house to South America by attaching balloons to it.'),
('Hotel Rwanda', 2004, 8.1, 'Biography, Drama, History', 'Terry George', 121, 'tt0395169', 'The true story of Paul Rusesabagina, a hotel manager who saved over a thousand refugees during the Rwandan genocide.'),
('Big Hero 6', 2014, 8.1, 'Animation, Action, Adventure', 'Don Hall', 102, 'tt2245084', 'A special bond develops between a robot and a young boy as they team up to fight crime.'),
('Anand', 1971, 8.5, 'Drama', 'Hrishikesh Mukherjee', 122, 'tt0066763', 'The story of a terminally ill man who wishes to live life to the fullest.'),
('Die Hard', 1988, 8.2, 'Action, Thriller', 'John McTiernan', 132, 'tt0095016', 'A New York City police officer tries to save his wife and several others taken hostage by terrorists during a Christmas party.'),
('Before Sunset', 2004, 8.1, 'Drama, Romance', 'Richard Linklater', 80, 'tt0381681', 'Nine years after Jesse and Celine first met, they encounter each other again.'),
('The Incredibledad', 2004, 8.0, 'Animation, Action, Adventure', 'Brad Bird', 115, 'tt0317709', 'A family of superheroes must save the world from a villain seeking revenge.'),
('Ikiru', 1952, 8.3, 'Drama', 'Akira Kurosawa', 143, 'tt0044741', 'A bureaucrat tries to find meaning in his final days after being diagnosed with stomach cancer.'),
('Incendies', 2010, 8.2, 'Drama, Mystery', 'Denis Villeneuve', 131, 'tt1755783', 'Twins journey to the Middle East to discover their family history and fulfill their mother''s last wishes.'),
('Rocky', 1976, 8.1, 'Drama, Sport', 'John G. Avildsen', 120, 'tt0075148', 'A small-time boxer gets a shot at the heavyweight title.'),
('Yi Yi', 2000, 8.1, 'Drama', 'Edward Yang', 173, 'tt0244316', 'The story of a family facing crises in Taipei, Taiwan.'),
('Manchester by the Sea', 2016, 8.3, 'Drama', 'Kenneth Lonergan', 137, 'tt4633694', 'A depressed uncle is asked to take care of his teenage nephew after the boy''s father dies.'),
('The Secret in Their Eyes', 2009, 8.2, 'Drama, Mystery, Thriller', 'Juan José Campanella', 129, 'tt1305806', 'A retired legal counselor writes a novel hoping to find closure for an unsolved rape and murder case.'),
('Mary and Max', 2009, 8.1, 'Animation, Comedy, Drama', 'Adam Elliot', 92, 'tt1183919', 'A tale of friendship between two unlikely pen pals: Mary, a lonely eight-year-old girl in Australia, and Max, a forty-four-year-old man with Asperger''s in New York.'),
('Unforgiven', 1992, 8.1, 'Drama, Western', 'Clint Eastwood', 131, 'tt0105695', 'Retired gunslinger William Munny reluctantly takes on one last job.'),
('Gandhi', 1982, 8.0, 'Biography, Drama, History', 'Richard Attenborough', 191, 'tt0083987', 'The story of Mahatma Gandhi, the lawyer who became the famed leader of the Indian revolts against the British rule.'),
('The Artist', 2011, 8.1, 'Comedy, Drama, Romance', 'Michel Hazanavicius', 100, 'tt1655442', 'A silent movie star meets a young dancer and the two form a relationship in 1927 Hollywood.'),
('Speak No Evil', 2022, 8.0, 'Drama, Horror, Thriller', 'Christian Tafdrup', 97, 'tt8751000', 'A Danish family visits a Dutch family during their holidays.'),
('In the Mood for Love', 2000, 8.1, 'Drama, Romance', 'Wong Kar-wai', 98, 'tt0118694', 'Two neighbors form a strong bond after both suspect their spouses of adultery.'),
('Papillon', 1973, 8.0, 'Biography, Crime, Drama', 'Franklin J. Schaffner', 150, 'tt0070511', 'A man befriends a fellow criminal as the two of them begin serving their sentence on a dreadful prison island.'),
('Anatomy of a Murder', 1959, 8.0, 'Crime, Drama, Mystery', 'Otto Preminger', 160, 'tt0052561', 'In a murder trial, the defendant claims he was temporarily insane when he killed his wife''s rapist.'),
('Paris, Texas', 1984, 8.1, 'Drama', 'Wim Wenders', 147, 'tt0087965', 'A man who has been missing for four years wanders out of the desert and must reconnect with his family.'),
('The Handmaiden', 2016, 8.1, 'Drama, Mystery, Romance', 'Park Chan-wook', 145, 'tt4016934', 'A handmaiden is hired to serve a Japanese heiress, but secretly she is involved in a plot to defraud her.'),
('Casino', 1995, 8.2, 'Crime, Drama', 'Martin Scorsese', 178, 'tt0112641', 'A gambler and a prostitute become involved in a dangerous web of power and betrayal.'),
('Trainspotting', 1996, 8.1, 'Drama', 'Danny Boyle', 94, 'tt0117951', 'A group of heroin addicts in Edinburgh attempt to break free from their addiction.'),
('Come and See', 1985, 8.3, 'Drama, War', 'Elem Klimov', 142, 'tt0091251', 'A boy in Belarus experiences the horrors of World War II.'),
('Gran Torino', 2008, 8.1, 'Drama', 'Clint Eastwood', 116, 'tt0064802', 'A disgruntled Korean War veteran forms a bond with his Hmong-American neighbors.'),
('Captain Fantastic', 2016, 8.0, 'Comedy, Drama', 'Matt Ross', 118, 'tt3553976', 'A father raises his six children in the forests of the Pacific Northwest, isolated from society.'),
('Portrait of a Lady on Fire', 2019, 8.1, 'Drama, Romance', 'Céline Sciamma', 122, 'tt4974444', 'A female artist falls in love with a woman she is commissioned to paint.'),
('Network', 1976, 8.2, 'Drama', 'Sidney Lumet', 121, 'tt0074958', 'A television network cynically exploits a deranged news anchor''s ravings and revelations.'),
('Spotlight', 2015, 8.1, 'Biography, Crime, Drama', 'Tom McCarthy', 128, 'tt1895587', 'The true story of how the Boston Globe uncovered the massive scandal of child molestation and cover-up within the Catholic Church.'),
('The Father', 2020, 8.3, 'Drama', 'Florian Zeller', 97, 'tt10272386', 'A man refuses all assistance from his daughter as he ages, but as he tries to make sense of his changing circumstances, he begins to doubt his loved ones, his own mind and even the fabric of his reality.'),
('There Will Be Blood', 2007, 8.2, 'Drama', 'Paul Thomas Anderson', 158, 'tt0469494', 'A ruthless oil prospector adopts a young boy and manipulates him into running his company.'),
('Your Name.', 2016, 8.4, 'Animation, Drama, Fantasy', 'Makoto Shinkai', 106, 'tt5311514', 'Two strangers find themselves linked in a bizarre way, leading to a quest for answers.'),
('A Quiet Place', 2018, 8.0, 'Drama, Horror, Sci-Fi', 'John Krasinski', 90, 'tt6644200', 'In a post-apocalyptic world, a family must live in silence to avoid monsters with ultra-sensitive hearing.'),
('Million Dollar Baby', 2004, 8.1, 'Drama, Sport', 'Clint Eastwood', 132, 'tt0405159', 'A determined woman works with a hardened boxing trainer to become a professional.'),
('Coco', 2017, 8.4, 'Animation, Adventure, Comedy', 'Lee Unkrich', 105, 'tt2380307', 'A boy travels to the Land of the Dead to seek forgiveness from his great-great-grandfather.'),
('Arrival', 2016, 8.3, 'Drama, Mystery, Sci-Fi', 'Denis Villeneuve', 116, 'tt2543164', 'A linguist works with the military to communicate with alien visitors.'),
('The Green Book', 2018, 8.2, 'Biography, Comedy, Drama', 'Peter Farrelly', 130, 'tt6966692', 'A working-class Italian-American bouncer becomes the driver of a Black classical pianist on a tour of the American South.'),
('Finding Nemo', 2003, 8.2, 'Animation, Adventure, Comedy', 'Andrew Stanton', 100, 'tt0266543', 'A clownfish embarks on a journey to find his son who was captured by a diver.'),
('Inside Out', 2015, 8.1, 'Animation, Adventure, Comedy', 'Pete Docter', 95, 'tt2096673', 'After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions conflict on how best to navigate a new city.'),
('La La Land', 2016, 8.0, 'Comedy, Drama, Musical', 'Damien Chazelle', 128, 'tt3783958', 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations.'),
('Howl''s Moving Castle', 2004, 8.2, 'Animation, Adventure, Fantasy', 'Hayao Miyazaki', 119, 'tt0347149', 'When a young girl is cursed by a witch, she seeks refuge in a moving castle belonging to a mysterious wizard.'),
('Monsters, Inc.', 2001, 8.1, 'Animation, Adventure, Comedy', 'Pete Docter', 92, 'tt0198781', 'In order to power the city, monsters scare children to collect their screams.'),
('Hachi: A Dog''s Tale', 2009, 8.1, 'Biography, Drama', 'Lasse Hallström', 93, 'tt10272386', 'A professor finds an abandoned dog and takes him in, forming a deep bond that lasts a lifetime.'),
('The Bourne Identity', 2002, 8.0, 'Action, Mystery, Thriller', 'Doug Liman', 119, 'tt0258463', 'A man is picked up by a fishing boat, bullet-riddled and suffering from amnesia, before racing to elude assassins and regain his memory.'),
('The Sixth Sense', 1999, 8.1, 'Drama, Mystery, Thriller', 'M. Night Shyamalan', 107, 'tt0167404', 'A boy who communicates with spirits seeks the help of a disheartened child psychologist.'),
('Bridge of Spies', 2015, 8.0, 'Biography, Drama, History', 'Steven Spielberg', 142, 'tt4686940', 'During the Cold War, an insurance lawyer is recruited to defend a Soviet spy.');

-- Insert Nicolas Cage movies with good ratings
INSERT INTO movies (title, year, rating, genre, director, runtime, imdb_id, plot) VALUES
('Leaving Las Vegas', 1995, 7.6, 'Drama, Romance', 'Mike Figgis', 112, 'tt0113631', 'A suicidal alcoholic goes to Las Vegas to drink himself to death and meets a prostitute.'),
('Raising Arizona', 1987, 7.6, 'Comedy, Crime', 'Joel Coen', 94, 'tt0093822', 'When a childless couple of an ex-con and an ex-cop decide to help themselves to one of another family''s quintuplets, their lives become more complicated than they anticipated.'),
('Adaptation.', 2002, 7.7, 'Comedy, Drama, Romance', 'Spike Jonze', 114, 'tt0268126', 'A lovelorn screenwriter becomes desperate as he tries to adapt a book.'),
('National Treasure', 2004, 6.9, 'Action, Adventure, Mystery', 'Jon Turteltaub', 131, 'tt0368891', 'A historian races to find the legendary Templar Treasure before a team of mercenaries.'),
('The Rock', 1996, 7.4, 'Action, Adventure, Thriller', 'Michael Bay', 136, 'tt0117500', 'A mild-mannered FBI chemist and an ex-con must break into Alcatraz to stop a biological weapon attack.'),
('Con Air', 1997, 6.9, 'Action, Crime, Thriller', 'Simon West', 115, 'tt0118880', 'A paroled army ranger becomes embroiled in a plot to take over a prison plane.'),
('Face/Off', 1997, 7.3, 'Action, Crime, Sci-Fi', 'John Woo', 138, 'tt0119094', 'A revolutionary medical technique allows an FBI agent and a terrorist to switch faces.'),
('Gone in 60 Seconds', 2000, 6.5, 'Action, Crime, Thriller', 'Dominic Sena', 118, 'tt0187078', 'A retired master car thief must come back to the industry and steal 50 cars with his crew in one night.'),
('Snake Eyes', 1998, 5.9, 'Action, Crime, Drama', 'Brian De Palma', 98, 'tt0120832', 'A corrupt detective investigates a boxing match assassination.'),
('8MM', 1999, 6.3, 'Crime, Drama, Mystery', 'Joel Schumacher', 123, 'tt0134273', 'A private investigator is hired to determine if a snuff film is authentic.'),
(' Bringing Out the Dead', 1999, 6.9, 'Drama', 'Martin Scorsese', 121, 'tt0120882', 'A paramedic works the graveyard shift in Hell''s Kitchen and faces personal demons.'),
('Windtalkers', 2002, 6.1, 'Action, Drama, War', 'John Woo', 134, 'tt0255518', 'Two U.S. Marines in WWII are assigned to protect Navajo code talkers.'),
('Matchstick Men', 2003, 7.3, 'Comedy, Crime, Drama', 'Ridley Scott', 116, 'tt0325800', 'A phobic con artist and his protégé are on the verge of pulling off a lucrative swindle.'),
('National Treasure: Book of Secrets', 2007, 6.5, 'Action, Adventure, Mystery', 'Jon Turteltaub', 124, 'tt0465234', 'Treasure hunter Benjamin Franklin Gates looks for the truth behind the assassination of Abraham Lincoln.'),
('Next', 2007, 6.2, 'Action, Adventure, Sci-Fi', 'Lee Tamahori', 96, 'tt0435705', 'A Las Vegas magician who can see into the future is pursued by FBI agents.'),
('Knowing', 2009, 6.2, 'Action, Drama, Mystery', 'Alex Proyas', 121, 'tt0448011', 'A professor discovers a document that predicts every major disaster of the last fifty years.'),
('Bad Lieutenant: Port of Call New Orleans', 2009, 6.8, 'Crime, Drama', 'Werner Herzog', 121, 'tt1191110', 'A drug-addicted detective investigates the murders of five illegal immigrants.'),
('Kick-Ass', 2010, 7.6, 'Action, Comedy, Crime', 'Matthew Vaughn', 117, 'tt1250777', 'Dave Lizewski is an unnoticed high school student and comic book fan who one day decides to become a superhero.'),
('The Sorcerer''s Apprentice', 2010, 6.1, 'Action, Adventure, Comedy', 'Jon Turteltaub', 109, 'tt0963967', 'Master sorcerer Balthazar Blake recruits a seemingly everyday guy to help him defend New York City.'),
('Season of the Witch', 2011, 5.3, 'Action, Adventure, Fantasy', 'Dominic Sena', 95, 'tt0479990', 'A 14th-century knight transports a suspected witch to a monastery.');

-- Insert Nicolas Cage movie associations
INSERT INTO movie_actors (movie_id, actor_id, character_name, billing)
SELECT m.id, a.id, m.title, 1
FROM movies m
CROSS JOIN actors a
WHERE a.name = 'Nicolas Cage' AND m.title IN (
    'Leaving Las Vegas', 'Raising Arizona', 'Adaptation.', 'National Treasure',
    'The Rock', 'Con Air', 'Face/Off', 'Gone in 60 Seconds', 'Snake Eyes',
    '8MM', ' Bringing Out the Dead', 'Windtalkers', 'Matchstick Men',
    'National Treasure: Book of Secrets', 'Next', 'Knowing',
    'Bad Lieutenant: Port of Call New Orleans', 'Kick-Ass', 'The Sorcerer''s Apprentice',
    'Season of the Witch'
);

-- Insert some key movie-actor associations for other famous roles
INSERT INTO movie_actors (movie_id, actor_id, character_name, billing) VALUES
-- The Godfather
((SELECT id FROM movies WHERE title = 'The Godfather'),
 (SELECT id FROM actors WHERE name = 'Marlon Brando'), 'Don Vito Corleone', 1),
((SELECT id FROM movies WHERE title = 'The Godfather'),
 (SELECT id FROM actors WHERE name = 'Al Pacino'), 'Michael Corleone', 2),
((SELECT id FROM movies WHERE title = 'The Godfather'),
 (SELECT id FROM actors WHERE name = 'James Caan'), 'Sonny Corleone', 3),

-- The Dark Knight
((SELECT id FROM movies WHERE title = 'The Dark Knight'),
 (SELECT id FROM actors WHERE name = 'Christian Bale'), 'Bruce Wayne/Batman', 1),
((SELECT id FROM movies WHERE title = 'The Dark Knight'),
 (SELECT id FROM actors WHERE name = 'Heath Ledger'), 'Joker', 2),

-- Pulp Fiction
((SELECT id FROM movies WHERE title = 'Pulp Fiction'),
 (SELECT id FROM actors WHERE name = 'John Travolta'), 'Vincent Vega', 1),
((SELECT id FROM movies WHERE title = 'Pulp Fiction'),
 (SELECT id FROM actors WHERE name = 'Samuel L. Jackson'), 'Jules Winnfield', 2),
((SELECT id FROM movies WHERE title = 'Pulp Fiction'),
 (SELECT id FROM actors WHERE name = 'Uma Thurman'), 'Mia Wallace', 3),

-- The Matrix
((SELECT id FROM movies WHERE title = 'The Matrix'),
 (SELECT id FROM actors WHERE name = 'Keanu Reeves'), 'Neo', 1),
((SELECT id FROM movies WHERE title = 'The Matrix'),
 (SELECT id FROM actors WHERE name = 'Laurence Fishburne'), 'Morpheus', 2),
((SELECT id FROM movies WHERE title = 'The Matrix'),
 (SELECT id FROM actors WHERE name = 'Carrie-Anne Moss'), 'Trinity', 3),

-- Goodfellas
((SELECT id FROM movies WHERE title = 'Goodfellas'),
 (SELECT id FROM actors WHERE name = 'Robert De Niro'), 'Jimmy Conway', 1),
((SELECT id FROM movies WHERE title = 'Goodfellas'),
 (SELECT id FROM actors WHERE name = 'Ray Liotta'), 'Henry Hill', 2),
((SELECT id FROM movies WHERE title = 'Goodfellas'),
 (SELECT id FROM actors WHERE name = 'Joe Pesci'), 'Tommy DeVito', 3),

-- Fight Club
((SELECT id FROM movies WHERE title = 'Fight Club'),
 (SELECT id FROM actors WHERE name = 'Brad Pitt'), 'Tyler Durden', 1),
((SELECT id FROM movies WHERE title = 'Fight Club'),
 (SELECT id FROM actors WHERE name = 'Edward Norton'), 'Narrator', 2),
((SELECT id FROM movies WHERE title = 'Fight Club'),
 (SELECT id FROM actors WHERE name = 'Helena Bonham Carter'), 'Marla Singer', 3),

-- The Silence of the Lambs
((SELECT id FROM movies WHERE title = 'The Silence of the Lambs'),
 (SELECT id FROM actors WHERE name = 'Jodie Foster'), 'Clarice Starling', 1),
((SELECT id FROM movies WHERE title = 'The Silence of the Lambs'),
 (SELECT id FROM actors WHERE name = 'Anthony Hopkins'), 'Hannibal Lecter', 2),

-- Forrest Gump
((SELECT id FROM movies WHERE title = 'Forrest Gump'),
 (SELECT id FROM actors WHERE name = 'Tom Hanks'), 'Forrest Gump', 1),

-- The Shawshank Redemption
((SELECT id FROM movies WHERE title = 'The Shawshank Redemption'),
 (SELECT id FROM actors WHERE name = 'Tim Robbins'), 'Andy Dufresne', 1),
((SELECT id FROM movies WHERE title = 'The Shawshank Redemption'),
 (SELECT id FROM actors WHERE name = 'Morgan Freeman'), 'Red', 2),

-- Inception
((SELECT id FROM movies WHERE title = 'Inception'),
 (SELECT id FROM actors WHERE name = 'Leonardo DiCaprio'), 'Dom Cobb', 1),

-- Gladiator
((SELECT id FROM movies WHERE title = 'Gladiator'),
 (SELECT id FROM actors WHERE name = 'Russell Crowe'), 'Maximus Decimus Meridius', 1),

-- Saving Private Ryan
((SELECT id FROM movies WHERE title = 'Saving Private Ryan'),
 (SELECT id FROM actors WHERE name = 'Tom Hanks'), 'Captain John Miller', 1),

-- The Prestige
((SELECT id FROM movies WHERE title = 'The Prestige'),
 (SELECT id FROM actors WHERE name = 'Christian Bale'), 'Alfred Borden', 1),
((SELECT id FROM movies WHERE title = 'The Prestige'),
 (SELECT id FROM actors WHERE name = 'Hugh Jackman'), 'Robert Angier', 2),

-- The Departed
((SELECT id FROM movies WHERE title = 'The Departed'),
 (SELECT id FROM actors WHERE name = 'Leonardo DiCaprio'), 'Billy Costigan', 1),
((SELECT id FROM movies WHERE title = 'The Departed'),
 (SELECT id FROM actors WHERE name = 'Matt Damon'), 'Colin Sullivan', 2),

-- Interstellar
((SELECT id FROM movies WHERE title = 'Interstellar'),
 (SELECT id FROM actors WHERE name = 'Matthew McConaughey'), 'Cooper', 1),
((SELECT id FROM movies WHERE title = 'Interstellar'),
 (SELECT id FROM actors WHERE name = 'Anne Hathaway'), 'Brand', 2),

-- Whiplash
((SELECT id FROM movies WHERE title = 'Whiplash'),
 (SELECT id FROM actors WHERE name = 'Miles Teller'), 'Andrew Neiman', 1),
((SELECT id FROM movies WHERE title = 'Whiplash'),
 (SELECT id FROM actors WHERE name = 'J.K. Simmons'), 'Terence Fletcher', 2),

-- Green Book
((SELECT id FROM movies WHERE title = 'The Green Book'),
 (SELECT id FROM actors WHERE name = 'Viggo Mortensen'), 'Tony Lip', 1),
((SELECT id FROM movies WHERE title = 'The Green Book'),
 (SELECT id FROM actors WHERE name = 'Mahershala Ali'), 'Dr. Don Shirley', 2),

-- A Beautiful Mind
((SELECT id FROM movies WHERE title = 'A Beautiful Mind'),
 (SELECT id FROM actors WHERE name = 'Russell Crowe'), 'John Nash', 1),
((SELECT id FROM movies WHERE title = 'A Beautiful Mind'),
 (SELECT id FROM actors WHERE name = 'Jennifer Connelly'), 'Alicia Nash', 2);

-- Add helpful views for searching
CREATE VIEW movie_search_view AS
SELECT
    m.id,
    m.title,
    m.year,
    m.rating,
    m.genre,
    m.director,
    m.plot,
    STRING_AGG(a.name, ', ' ORDER BY ma.billing) as actors
FROM movies m
LEFT JOIN movie_actors ma ON m.id = ma.movie_id
LEFT JOIN actors a ON ma.actor_id = a.id
GROUP BY m.id, m.title, m.year, m.rating, m.genre, m.director, m.plot;

CREATE VIEW nicolas_cage_movies AS
SELECT
    m.title,
    m.year,
    m.rating,
    m.genre,
    m.director,
    ma.character_name
FROM movies m
JOIN movie_actors ma ON m.id = ma.movie_id
JOIN actors a ON ma.actor_id = a.id
WHERE a.name = 'Nicolas Cage'
ORDER BY m.rating DESC, m.year DESC;

COMMENT ON VIEW movie_search_view IS 'Comprehensive view for searching movies with actor information';
COMMENT ON VIEW nicolas_cage_movies IS 'All Nicolas Cage movies ordered by rating and year';
