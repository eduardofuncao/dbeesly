-- Create table distros
CREATE TABLE distros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    release_year INT NOT NULL
);

-- Create table packages
CREATE TABLE packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    version VARCHAR(50) NOT NULL,
    distro_id INT,
    FOREIGN KEY (distro_id) REFERENCES distros(id)
);

-- Insert 20+ distros
INSERT INTO distros (name, release_year) VALUES
('Ubuntu', 2004),
('Fedora', 2003),
('Debian', 1993),
('Arch Linux', 2002),
('openSUSE', 2005),
('CentOS', 2004),
('Red Hat Enterprise Linux', 2000),
('Linux Mint', 2006),
('Manjaro', 2011),
('Kali Linux', 2013),
('Slackware', 1993),
('Gentoo', 2000),
('Elementary OS', 2011),
('Pop!_OS', 2017),
('Zorin OS', 2009),
('Solus', 2015),
('MX Linux', 2014),
('Parrot OS', 2013),
('Alpine Linux', 2005),
('Peppermint OS', 2010),
('Clear Linux', 2015),
('EndeavourOS', 2019);

-- Insert 20+ packages, linking to distros by id (assumes order above)
INSERT INTO packages (name, version, distro_id) VALUES
('bash', '5.1', 1),
('coreutils', '8.32', 1),
('vim', '8.2', 1),
('nano', '6.2', 2),
('dnf', '4.8.0', 2),
('gcc', '10.2', 2),
('apt', '2.2.4', 3),
('dpkg', '1.20.9', 3),
('pacman', '6.0.2', 4),
('zypper', '1.14.52', 5),
('yum', '4.2.23', 6),
('rpm', '4.16.1', 7),
('synaptic', '0.90.2', 8),
('pamac', '10.5.5', 9),
('metasploit', '6.1.21', 10),
('slackpkg', '15.0.0', 11),
('portage', '3.0.18', 12),
('pantheon-files', '4.0.4', 13),
('pop-shell', '1.2.0', 14),
('zorin-connect', '1.0.0', 15),
('eopkg', '3.8.0', 16),
('mx-tools', '20.3', 17),
('parrot-tools', '4.11', 18),
('apk-tools', '2.12.7', 19),
('peppermint-setup', '10.0', 20),
('clr-installer', '2.0.47', 21),
('eos-welcome', '3.8.18', 22),
('htop', '3.2.2', 1),
('neofetch', '7.1.0', 2),
('gimp', '2.10.34', 3);
