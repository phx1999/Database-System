create table country
(
    idCOUNTRY         int auto_increment
        primary key,
    COUNTRY_NAME      varchar(45) not null,
    COUNTRY_CONTINENT varchar(45) not null,
    constraint COUNTRY_NAME_UNIQUE
        unique (COUNTRY_NAME)
);

create table book
(
    idBOOK             int auto_increment
        primary key,
    BOOK_TITLE         varchar(45)  null,
    BOOK_PUBLISH_DATE  int          null,
    BOOK_PAGE_NUM      int          not null,
    BOOK_PRICE         int          not null,
    BOOK_LAYOUT        tinyint      not null,
    BOOK_PUBLISH       varchar(45)  not null,
    BOOK_ISBN          varchar(45)  not null,
    BOOK_INTRO         varchar(300) not null,
    BOOK_SCORE         double       not null,
    BOOK_RECOMMAND_NUM int          not null,
    book_country       int          null,
    constraint BOOK_TITLE_LAYOUT_PUBLISH
        unique (BOOK_TITLE, BOOK_LAYOUT, BOOK_PUBLISH),
    constraint book___country
        foreign key (book_country) references country (idCOUNTRY)
);

create table festival
(
    idAWARD          int auto_increment
        primary key,
    FESTIVAL_NAME    varchar(45) not null,
    FESTIVAL_DATE    int         not null,
    FESTIVAL_COUNTRY int         null,
    FESTIVAL_CITY    varchar(45) null,
    constraint NAME_DATE
        unique (FESTIVAL_NAME, FESTIVAL_DATE),
    constraint FESTIVAL_COUNTRY
        foreign key (FESTIVAL_COUNTRY) references country (idCOUNTRY)
);

create index COUNTRY_idx
    on festival (FESTIVAL_COUNTRY);

create table movie
(
    idMOVIE             int auto_increment
        primary key,
    MOVIE_TITLE         varchar(45)  not null,
    MOVIE_RELEASED_DAY  int          null,
    MOVIE_RUNTIME       int          null,
    MOVIE_LANGUAGE      varchar(45)  not null,
    MOVIE_IMDB          varchar(45)  not null,
    MOVIE_SCORE         double       not null,
    MOVIE_INTRO         varchar(300) not null,
    MOVIE_RECOMMAND_NUM int          not null,
    MOVIE_SOURCE_LINK   varchar(45)  null,
    MOVIE_IS_RUNNING    tinyint      not null,
    MOVIE_COUNTRY       int          null,
    constraint movie___COUNTRY
        foreign key (MOVIE_COUNTRY) references country (idCOUNTRY)
);

create table people
(
    idPEOPLE                    int auto_increment
        primary key,
    PEOPLE_FIRST_NAME_FOREIGNER varchar(45)  null,
    PEOPLE_SURNAME_FOREIGNER    varchar(45)  null,
    PEOPLE_GENDER               varchar(45)  not null,
    PEOPLE_BIRTHDAY             int          null,
    PEOPLE_BIRTH_PLACE          varchar(45)  null,
    PEOPLE_CONSTELLATION        varchar(45)  null,
    PEOPLE_INTRO                varchar(300) null,
    PEOPLE_COUNTRY              int          not null,
    constraint PEOPLE_COUNTRY
        foreign key (PEOPLE_COUNTRY) references country (idCOUNTRY)
);

create table award
(
    idAWARD        int auto_increment
        primary key,
    AWARD_FESTIVAL int         not null,
    AWARD_MOVIE    int         null,
    AWARD_PEOPLE   int         null,
    AWARD_NAME     varchar(45) not null,
    constraint AWARD_FESTIVAL
        foreign key (AWARD_FESTIVAL) references festival (idAWARD),
    constraint AWARD_MOVIE
        foreign key (AWARD_MOVIE) references movie (idMOVIE),
    constraint AWARD_PEOPLE
        foreign key (AWARD_PEOPLE) references people (idPEOPLE)
);

create index AWARD_FESTIVAL_idx
    on award (AWARD_FESTIVAL);

create index AWARD_MOVIE_idx
    on award (AWARD_MOVIE);

create index AWARD_PEOPLE_idx
    on award (AWARD_PEOPLE);

create table book_people
(
    BOOK   int not null,
    PEOPLE int not null,
    primary key (BOOK, PEOPLE),
    constraint BOOK_PEOPLE_BOOK
        foreign key (BOOK) references book (idBOOK),
    constraint BOOK_PEOPLE_PEOPLE
        foreign key (PEOPLE) references people (idPEOPLE)
);

create index BOOK_PEOPLE_PEOPLE_idx
    on book_people (PEOPLE);

create table movie_people
(
    MOVIE  int         not null,
    PEOPLE int         not null,
    TYPE   varchar(45) null,
    primary key (MOVIE, PEOPLE),
    constraint MOVIE_PEOPLE_MOVIE
        foreign key (MOVIE) references movie (idMOVIE),
    constraint MOVIE_PEOPLE_PEOPLE
        foreign key (PEOPLE) references people (idPEOPLE)
);

create index PEOPLE_idx
    on movie_people (PEOPLE);

create index PEOPLE_COUNTRY_idx
    on people (PEOPLE_COUNTRY);

create table tag
(
    idTAG    int auto_increment
        primary key,
    TAG_NAME varchar(45) not null,
    constraint TAG_NAME_UNIQUE
        unique (TAG_NAME)
);

create table book_tag
(
    BOOK int not null,
    TAG  int not null,
    primary key (BOOK, TAG),
    constraint BOOK_TAG_BOOK
        foreign key (BOOK) references book (idBOOK),
    constraint BOOK_TAG_TAG
        foreign key (TAG) references tag (idTAG)
);

create index TAG_idx
    on book_tag (TAG);

create table tag_movie
(
    TAG   int not null,
    MOVIE int not null,
    primary key (TAG, MOVIE),
    constraint TAG_MOVIE_MOVIE
        foreign key (MOVIE) references movie (idMOVIE),
    constraint TAG_MOVIE_TAG
        foreign key (TAG) references tag (idTAG)
);

create index MOVIE_idx
    on tag_movie (MOVIE);

create table user
(
    idUSER         int auto_increment
        primary key,
    USER_ACCOUNT   varchar(45)  not null,
    USER_PASSWORD  varchar(45)  not null,
    USER_NICKNAME  varchar(45)  not null,
    USER_GENDER    varchar(1)   null,
    USER_AGE       int          null,
    USER_CITY      varchar(45)  null,
    USER_STATEMENT varchar(200) null,
    constraint USER_ACCOUNT_UNIQUE
        unique (USER_ACCOUNT)
);

create table friend_user
(
    FOLLOWER  int not null,
    FOLLOWING int not null,
    primary key (FOLLOWER, FOLLOWING),
    constraint FOLLOWER
        foreign key (FOLLOWER) references user (idUSER),
    constraint FOLLOWING
        foreign key (FOLLOWING) references user (idUSER)
);

create index FOLLOWING_idx
    on friend_user (FOLLOWING);

create table list
(
    idLIST    int auto_increment
        primary key,
    LIST_NAME varchar(45) not null,
    LIST_USER int         not null,
    LIST_DATE date        not null,
    LIST_TYPE varchar(1)  not null,
    constraint LIST_USER
        foreign key (LIST_USER) references user (idUSER)
);

create index USER_idx
    on list (LIST_USER);

create table list_book
(
    LIST int not null,
    BOOK int not null,
    primary key (LIST, BOOK),
    constraint LIST_BOOK_BOOK
        foreign key (BOOK) references book (idBOOK),
    constraint LIST_BOOK_LIST
        foreign key (LIST) references list (idLIST)
);

create index BOOK_idx
    on list_book (BOOK);

create table list_movie
(
    LIST  int not null,
    MOVIE int not null,
    primary key (LIST, MOVIE),
    constraint LIST_MOVIE_LIST
        foreign key (LIST) references list (idLIST),
    constraint LIST_MOVIE_MOVIE
        foreign key (MOVIE) references movie (idMOVIE)
);

create index MOVIE_idx
    on list_movie (MOVIE);

create table list_user_collection
(
    LIST int not null,
    USER int not null,
    primary key (LIST, USER),
    constraint LIST_USER_COLLECTION_LIST
        foreign key (LIST) references list (idLIST),
    constraint LIST_USER_COLLECTION_USER
        foreign key (USER) references user (idUSER)
);

create index USER_idx
    on list_user_collection (USER);

create table message
(
    SEND      int          not null,
    RECIEVE   int          not null,
    CONTENT   varchar(300) not null,
    TIME      time         not null,
    idMESSAGE int auto_increment
        primary key,
    constraint RECIEVE
        foreign key (RECIEVE) references user (idUSER),
    constraint SEND
        foreign key (SEND) references user (idUSER)
);

create index RECIEVE_idx
    on message (RECIEVE);

create table user_comment_book
(
    USER              int            not null,
    BOOK              int            not null,
    STATUS            varchar(45)    not null,
    LONG_COMMENT      varchar(10000) null,
    LIKE_NUM          int            not null,
    SHORT_COMMENT     varchar(45)    null,
    READED_TIME       date           null,
    READING_TIME      date           null,
    WANT_TO_READ_TIME date           null,
    SCORE             int            null,
    primary key (USER, BOOK),
    constraint USER_COMMENT_BOOK_BOOK
        foreign key (BOOK) references book (idBOOK),
    constraint USER_COMMENT_BOOK_USER
        foreign key (USER) references user (idUSER)
);

create index BOOK_idx
    on user_comment_book (BOOK);

create table user_comment_movie
(
    USER          int            not null,
    MOVIE         int            not null,
    LONG_COMMENT  varchar(10000) null,
    STATUS        varchar(45)    not null,
    LIKE_NUM      int            not null,
    SHORT_COMMENT varchar(45)    null,
    WATCHED_TIME  date           null,
    WANT_TO_WATCH date           null,
    SCORE         int            null,
    primary key (USER, MOVIE),
    constraint USER_COMMENT_MOVIE_MOVIE
        foreign key (MOVIE) references movie (idMOVIE),
    constraint USER_COMMENT_MOVIE_USER
        foreign key (USER) references user (idUSER)
);

create index MOVIE_idx
    on user_comment_movie (MOVIE);


