import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const AthlonLevelUpApp());
}

class AthlonLevelUpApp extends StatelessWidget {
  const AthlonLevelUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athlon Level Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        cardColor: const Color(0xFF121829),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2563EB),
          secondary: Color(0xFFF59E0B),
          surface: Color(0xFF121829),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ==========================================
// 1. MODELLI DATI
// ==========================================

class PlayerProfile {
  final String teamLabel;
  final String fullName;
  final int level;
  final String role;
  final String shirtNumber;
  final String birthDate;
  final String height;
  final String weight;
  final String description;
  final int currentLevelExp;
  final int nextLevelExpThreshold;
  final int totalExp;
  final int expForNextLevelTotal;
  final Map<String, int> stats;
  final List<StrengthItem> strengths;
  final List<TechTestCategory> testCategories;
  final List<SeasonCareerEntry> careerSeasons;
  final List<InnateAbility> abilities;
  final List<SpecializationItem> specializations;
  final MonthlyMission currentMission;
  final List<ExpHistoryPoint> expChartPoints;
  final List<LevelUpEvent> levelUpHistory;
  final List<TrainingExpLog> trainingExpLogs;

  PlayerProfile({
    required this.teamLabel,
    required this.fullName,
    required this.level,
    required this.role,
    required this.shirtNumber,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.description,
    required this.currentLevelExp,
    required this.nextLevelExpThreshold,
    required this.totalExp,
    required this.expForNextLevelTotal,
    required this.stats,
    required this.strengths,
    required this.testCategories,
    required this.careerSeasons,
    required this.abilities,
    required this.specializations,
    required this.currentMission,
    required this.expChartPoints,
    required this.levelUpHistory,
    required this.trainingExpLogs,
  });
}

class StrengthItem {
  final String title;
  final String detail;
  const StrengthItem(this.title, this.detail);
}

enum TechInputType { numericUnit, target20, rating012 }

class TechTestItem {
  final String code;
  final String name;
  final TechInputType inputType;
  final String unit;
  String? inputValue;
  int? selectedRating; // null = Non effettuato, oppure 0, 1, 2

  TechTestItem({
    required this.code,
    required this.name,
    required this.inputType,
    this.unit = '',
    this.inputValue,
    this.selectedRating,
  });
}

class TechTestCategory {
  final String emoji;
  final String title;
  final List<TechTestItem> items;

  const TechTestCategory({
    required this.emoji,
    required this.title,
    required this.items,
  });
}

class SeasonCareerEntry {
  String seasonLabel;
  String teamAndCategory;
  String roleAndShirt;
  String? achievementBadge;

  SeasonCareerEntry({
    required this.seasonLabel,
    required this.teamAndCategory,
    required this.roleAndShirt,
    this.achievementBadge,
  });
}

class InnateAbility {
  final String stageLabel;
  final String title;
  final String bonuses;
  final bool isLocked;
  const InnateAbility({
    required this.stageLabel,
    this.title = '',
    this.bonuses = '',
    this.isLocked = false,
  });
}

class SpecializationItem {
  final String iconEmoji;
  final String name;
  final int step;
  final bool pendingApproval;
  const SpecializationItem({
    required this.iconEmoji,
    required this.name,
    required this.step,
    this.pendingApproval = false,
  });
}

class MissionTask {
  final String description;
  int current;
  final int target;
  MissionTask({
    required this.description,
    this.current = 0,
    required this.target,
  });
}

class MonthlyMission {
  final String title;
  final String status;
  final List<MissionTask> tasks;
  final int expReward;
  final String statRewardLabel;
  MonthlyMission({
    required this.title,
    required this.status,
    required this.tasks,
    required this.expReward,
    required this.statRewardLabel,
  });
}

class ExpHistoryPoint {
  final String dateLabel;
  final double cumulativeExp;
  final double sessionExp;
  const ExpHistoryPoint({
    required this.dateLabel,
    required this.cumulativeExp,
    required this.sessionExp,
  });
}

class LevelUpEvent {
  final String date;
  final int fromLevel;
  final int toLevel;
  final Map<String, int> statGains;
  const LevelUpEvent({
    required this.date,
    required this.fromLevel,
    required this.toLevel,
    required this.statGains,
  });
}

class TrainingExpLog {
  final String date;
  final int expGained;
  const TrainingExpLog(this.date, this.expGained);
}

class MatchItem {
  final int giornata;
  final String matchCode;
  final String opponent;
  final bool isHome;
  final String date;
  final String time;
  final bool isPast;
  final String? result;
  final String? homeTeamFull;
  final String? awayTeamFull;
  final List<String> setScores;

  const MatchItem({
    required this.giornata,
    this.matchCode = '',
    required this.opponent,
    required this.isHome,
    required this.date,
    required this.time,
    this.isPast = false,
    this.result,
    this.homeTeamFull,
    this.awayTeamFull,
    this.setScores = const [],
  });
}

class LeaderboardPlayer {
  final int rank;
  final String name;
  final int level;
  final String shirtNumber;
  final bool isCurrentUser;

  const LeaderboardPlayer({
    required this.rank,
    required this.name,
    required this.level,
    required this.shirtNumber,
    this.isCurrentUser = false,
  });
}

// ==========================================
// 2. DATI GIOCATORE, TEST, CARRIERA, CALENDARIO
// ==========================================

final PlayerProfile riccardoProfile = PlayerProfile(
  teamLabel: 'Athlon · Serie D',
  fullName: 'Riccardo Pirrone',
  level: 56,
  role: 'Schiacciatore',
  shirtNumber: '#10',
  birthDate: '26/03/2000 (26 anni)',
  height: '176 cm',
  weight: '72 kg',
  description:
      "Riccardo è un giocatore reattivo, rapido nelle risposte e dotato di una buona predisposizione difensiva. Una delle sue caratteristiche più interessanti è l'astuzia: sa trovare soluzioni diverse e può mettere in difficoltà l'avversario senza affidarsi esclusivamente alla potenza. Le statistiche mostrano una base fisica e difensiva solida, mentre il margine di crescita più evidente riguarda la precisione. Deve rendere più stabile la ricezione, aumentare il controllo dell'attacco e costruire una battuta più continua. Se riuscirà a trasformare la sua rapidità e la capacità di leggere gli spazi in gesti tecnici più precisi, potrà diventare un giocatore molto fastidioso da affrontare e particolarmente utile nelle situazioni di equilibrio.",
  currentLevelExp: 163,
  nextLevelExpThreshold: 1720,
  totalExp: 64563,
  expForNextLevelTotal: 66120,
  stats: const {
    'Forza': 120,
    'Agilità': 120,
    'Difesa': 120,
    'Resistenza': 110,
    'Precisione': 70,
    'IQ Volley': 100,
    'Mentalità': 95,
  },
  strengths: const [
    StrengthItem(
      'REATTIVITÀ NEI MOVIMENTI',
      'Risponde rapidamente agli stimoli e riesce a cambiare direzione con buona efficacia nelle situazioni impreviste.',
    ),
    StrengthItem(
      'BUONA DIFESA',
      'Ha predisposizione al recupero della palla e riesce a tenere vive azioni che sembrano compromesse.',
    ),
    StrengthItem(
      'ASTUZIA NEI COLPI',
      'Non cerca sempre la forza: sa trovare soluzioni intelligenti, cambiare direzione e sfruttare gli spazi lasciati liberi.',
    ),
    StrengthItem(
      'BUONA LETTURA DELLA SITUAZIONE',
      "Quando rimane lucido riesce a utilizzare velocità e intuito per anticipare l'azione.",
    ),
  ],
  // PAGINA 2 DEL PROFILO TECNICO: TUTTE LE CATEGORIE DI TEST
  testCategories: [
    TechTestCategory(
      emoji: '💪',
      title: 'Forza',
      items: [
        TechTestItem(
          code: 'F1',
          name: 'Salto verticale',
          inputType: TechInputType.numericUnit,
          unit: 'cm',
        ),
        TechTestItem(
          code: 'F2',
          name: 'Lancio palla medica da 3 kg',
          inputType: TechInputType.numericUnit,
          unit: 'm',
        ),
      ],
    ),
    TechTestCategory(
      emoji: '⚡',
      title: 'Agilità',
      items: [
        TechTestItem(
          code: 'A1',
          name: 'Sprint 10 metri',
          inputType: TechInputType.numericUnit,
          unit: 's',
        ),
        TechTestItem(
          code: 'A2',
          name: 'T-test',
          inputType: TechInputType.numericUnit,
          unit: 's',
        ),
      ],
    ),
    TechTestCategory(
      emoji: '❤️',
      title: 'Resistenza',
      items: [
        TechTestItem(
          code: 'R1',
          name: 'Corsa 10 minuti',
          inputType: TechInputType.numericUnit,
          unit: 'm',
        ),
        TechTestItem(
          code: 'R2',
          name: 'Piegamenti',
          inputType: TechInputType.numericUnit,
          unit: 'ripetizioni',
        ),
      ],
    ),
    TechTestCategory(
      emoji: '🎯',
      title: 'Precisione',
      items: [
        TechTestItem(
          code: 'P1',
          name: 'Palleggio a bersaglio',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
        TechTestItem(
          code: 'P2',
          name: 'Bagher a bersaglio',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
        TechTestItem(
          code: 'P3',
          name: 'Battuta a bersaglio',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
        TechTestItem(
          code: 'P4',
          name: 'Attacco a bersaglio',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
      ],
    ),
    TechTestCategory(
      emoji: '🛡️',
      title: 'Difesa',
      items: [
        TechTestItem(
          code: 'D1',
          name: 'Difesa su attacco',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
        TechTestItem(
          code: 'D2',
          name: 'Recupero pallonetto',
          inputType: TechInputType.target20,
          unit: '/ 20',
        ),
      ],
    ),
    TechTestCategory(
      emoji: '🧠',
      title: 'IQ Volley',
      items: [
        TechTestItem(
          code: 'IQ1',
          name: 'Anticipazione delle situazioni di gioco',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'IQ2',
          name: 'Posizionamento in campo',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'IQ3',
          name: 'Scelte tattiche in relazione al ruolo',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'IQ4',
          name: 'Battuta tattica',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'IQ5',
          name: 'Copertura e responsabilità',
          inputType: TechInputType.rating012,
        ),
      ],
    ),
    TechTestCategory(
      emoji: '🔥',
      title: 'Mentalità',
      items: [
        TechTestItem(
          code: 'M1',
          name: 'Reazione dopo un errore',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'M2',
          name: 'Iniziativa personale',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'M3',
          name: 'Supporto ai compagni',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'M4',
          name: 'Atteggiamento costruttivo',
          inputType: TechInputType.rating012,
        ),
        TechTestItem(
          code: 'M5',
          name: 'Impegno nelle situazioni di svantaggio',
          inputType: TechInputType.rating012,
        ),
      ],
    ),
  ],
  // PAGINA 3 DEL PROFILO TECNICO: STORICO STAGIONI E CAMPIONATI
  careerSeasons: [
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2026/27',
      teamAndCategory: 'Athlon · Serie D',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2023/24',
      teamAndCategory: 'Athlon · Serie C',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2022/23',
      teamAndCategory: 'Athlon · Serie D',
      roleAndShirt: 'Schiacciatore · Maglia 10',
      achievementBadge: 'Vittoria campionato',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2021/22',
      teamAndCategory: 'Athlon · Prima Divisione',
      roleAndShirt: 'Schiacciatore · Maglia 10',
      achievementBadge: 'Vittoria campionato',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2019/20',
      teamAndCategory: 'Athlon · Prima Divisione',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2018/19',
      teamAndCategory: 'Athlon · Serie C',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2017/18',
      teamAndCategory: 'Trinisi · Serie C',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2016/17',
      teamAndCategory: 'Athlon · Serie D',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2015/16',
      teamAndCategory: 'Athlon · Serie D',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2014/15',
      teamAndCategory: 'Athlon · Prima Divisione',
      roleAndShirt: 'Schiacciatore · Maglia 10',
      achievementBadge: 'Promozione in Serie D',
    ),
    SeasonCareerEntry(
      seasonLabel: 'Stagione 2013/14',
      teamAndCategory: 'Athlon · Prima Divisione',
      roleAndShirt: 'Schiacciatore · Maglia 10',
    ),
  ],
  abilities: const [
    InnateAbility(
      stageLabel: 'Risveglio · liv. 0',
      title: 'Braccio Pesante',
      bonuses: '💪 Forza ×1,5',
    ),
    InnateAbility(
      stageLabel: 'Evoluzione · liv. 30',
      title: 'Motore da Battaglia',
      bonuses: '❤️ Resistenza ×1,5 · 💪 Forza ×1,5',
    ),
    InnateAbility(stageLabel: 'Potenziamento · liv. 60', isLocked: true),
    InnateAbility(stageLabel: 'Maestria · liv. 90', isLocked: true),
  ],
  specializations: const [
    SpecializationItem(iconEmoji: '⚡', name: 'Scattista', step: 1),
    SpecializationItem(iconEmoji: '🛡️', name: 'Difensore', step: 1),
    SpecializationItem(iconEmoji: '❤️', name: 'Combattente', step: 1),
    SpecializationItem(iconEmoji: '🧠', name: 'Lettore del Gioco', step: 1),
    SpecializationItem(
      iconEmoji: '🔥',
      name: 'Determinato',
      step: 1,
      pendingApproval: true,
    ),
    SpecializationItem(iconEmoji: '🎯', name: 'Tiratore Scelto', step: 1),
  ],
  currentMission: MonthlyMission(
    title: 'AUMENTARE PRECISIONE',
    status: 'IN CORSO',
    tasks: [
      MissionTask(
        description: 'attacchi mirando alla diagonale indicata',
        current: 0,
        target: 50,
      ),
      MissionTask(
        description: 'attacchi mirando alla parallela indicata',
        current: 0,
        target: 50,
      ),
      MissionTask(
        description: 'pallonetti verso il bersaglio indicato',
        current: 0,
        target: 50,
      ),
    ],
    expReward: 100,
    statRewardLabel: '+20 Precisione',
  ),
  expChartPoints: const [
    ExpHistoryPoint(dateLabel: '09 set 2026', cumulativeExp: 100, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 200, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 300, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '16 set 2026', cumulativeExp: 480, sessionExp: 190),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 505, sessionExp: 25),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 530, sessionExp: 25),
    ExpHistoryPoint(dateLabel: '23 set 2026', cumulativeExp: 650, sessionExp: 120),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 770, sessionExp: 120),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 880, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 980, sessionExp: 94),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 1080, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '04 nov 2026', cumulativeExp: 1180, sessionExp: 100),
    ExpHistoryPoint(dateLabel: '', cumulativeExp: 1180, sessionExp: 0),
  ],
  levelUpHistory: const [
    LevelUpEvent(
      date: '04 ott 2026',
      fromLevel: 22,
      toLevel: 23,
      statGains: {
        '💪': 11,
        '⚡': 14,
        '🛡️': 6,
        '❤️': 16,
        '🎯': 3,
        '🧠': 1,
        '🔥': 6,
      },
    ),
  ],
  trainingExpLogs: const [
    TrainingExpLog('04 nov 2026', 0),
    TrainingExpLog('05 ott 2026', 100),
    TrainingExpLog('30 set 2026', 94),
    TrainingExpLog('29 set 2026', 100),
    TrainingExpLog('25 set 2026', 100),
    TrainingExpLog('23 set 2026', 120),
    TrainingExpLog('21 set 2026', 120),
    TrainingExpLog('18 set 2026', 25),
    TrainingExpLog('17 set 2026', 25),
    TrainingExpLog('16 set 2026', 190),
    TrainingExpLog('14 set 2026', 100),
    TrainingExpLog('11 set 2026', 100),
    TrainingExpLog('09 set 2026', 100),
  ],
);

// CALENDARIO COMPLETO SERIE D MASCHILE - GIRONE B (22 GIORNATE)
final List<MatchItem> allSeasonMatches = const [
  MatchItem(
    giornata: 1,
    matchCode: '3133',
    opponent: "VOLLEY VALLEY FUNIVIA DELL'ETNA",
    isHome: false,
    date: '24 ott 2026',
    time: '17:00',
    isPast: true,
    result: '0 - 3',
    homeTeamFull: "VOLLEY VALLEY FUNIVIA DELL'ETNA",
    awayTeamFull: 'LABOCHEM ATHLON PACE DEL MELA',
    setScores: ['23-25', '18-25', '23-25'],
  ),
  MatchItem(
    giornata: 2,
    matchCode: '3139',
    opponent: 'CICLOPE VOLLEY BRONTE',
    isHome: true,
    date: '01 nov 2026',
    time: '18:00',
    isPast: true,
    result: '3 - 2',
    homeTeamFull: 'LABOCHEM ATHLON PACE DEL MELA',
    awayTeamFull: 'CICLOPE VOLLEY BRONTE',
    setScores: ['21-25', '25-14', '15-25', '25-18', '15-9'],
  ),
  MatchItem(
    giornata: 3,
    matchCode: '3144',
    opponent: 'PAPIRO FIUMEFREDDO',
    isHome: false,
    date: '07 nov 2026',
    time: '16:00',
  ),
  MatchItem(
    giornata: 4,
    matchCode: '3150',
    opponent: 'AREA-VOLLEY',
    isHome: true,
    date: '15 nov 2026',
    time: '18:00',
  ),
  MatchItem(
    giornata: 5,
    matchCode: '3156',
    opponent: 'APD ASCI CANICATTINI',
    isHome: true,
    date: '22 nov 2026',
    time: '18:00',
  ),
  MatchItem(
    giornata: 6,
    matchCode: '3163',
    opponent: 'PALLAVOLO AUGUSTA',
    isHome: false,
    date: '29 nov 2026',
    time: '17:30',
  ),
  MatchItem(
    giornata: 7,
    matchCode: '3169',
    opponent: 'ACADEMY WARRIORS VIAGRANDE',
    isHome: true,
    date: '06 dic 2026',
    time: '18:00',
  ),
  MatchItem(
    giornata: 8,
    matchCode: '3179',
    opponent: 'KENTRON VOLLEY SCHOOL',
    isHome: false,
    date: '12 dic 2026',
    time: '19:00',
  ),
  MatchItem(
    giornata: 9,
    matchCode: '3181',
    opponent: 'EXONGRAPHIC ASTRA STADIUM CATANIA',
    isHome: true,
    date: '18 dic 2026',
    time: '19:30',
  ),
  MatchItem(
    giornata: 10,
    matchCode: '3188',
    opponent: 'PALLAVOLO ACIREALE',
    isHome: false,
    date: '10 gen 2027',
    time: '18:30',
  ),
  MatchItem(
    giornata: 11,
    matchCode: '3194',
    opponent: "A.S.D. PATERNO' VOLLEY",
    isHome: true,
    date: '17 gen 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 12,
    matchCode: '3199',
    opponent: "VOLLEY VALLEY FUNIVIA DELL'ETNA",
    isHome: true,
    date: '31 gen 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 13,
    matchCode: '3205',
    opponent: 'CICLOPE VOLLEY BRONTE',
    isHome: false,
    date: '07 feb 2027',
    time: '18:30',
  ),
  MatchItem(
    giornata: 14,
    matchCode: '3210',
    opponent: 'PAPIRO FIUMEFREDDO',
    isHome: true,
    date: '14 feb 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 15,
    matchCode: '3216',
    opponent: 'AREA-VOLLEY',
    isHome: false,
    date: '20 feb 2027',
    time: '17:00',
  ),
  MatchItem(
    giornata: 16,
    matchCode: '3222',
    opponent: 'APD ASCI CANICATTINI',
    isHome: false,
    date: '07 mar 2027',
    time: '18:30',
  ),
  MatchItem(
    giornata: 17,
    matchCode: '3229',
    opponent: 'PALLAVOLO AUGUSTA',
    isHome: true,
    date: '14 mar 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 18,
    matchCode: '3235',
    opponent: 'ACADEMY WARRIORS VIAGRANDE',
    isHome: false,
    date: '20 mar 2027',
    time: '18:30',
  ),
  MatchItem(
    giornata: 19,
    matchCode: '3245',
    opponent: 'KENTRON VOLLEY SCHOOL',
    isHome: true,
    date: '04 apr 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 20,
    matchCode: '3247',
    opponent: 'EXONGRAPHIC ASTRA STADIUM CATANIA',
    isHome: false,
    date: '10 apr 2027',
    time: '19:00',
  ),
  MatchItem(
    giornata: 21,
    matchCode: '3254',
    opponent: 'PALLAVOLO ACIREALE',
    isHome: true,
    date: '18 apr 2027',
    time: '18:00',
  ),
  MatchItem(
    giornata: 22,
    matchCode: '3260',
    opponent: "A.S.D. PATERNO' VOLLEY",
    isHome: false,
    date: '01 mag 2027',
    time: '20:00',
  ),
];

final List<LeaderboardPlayer> top5Players = const [
  LeaderboardPlayer(
    rank: 1,
    name: 'Santino Costa',
    level: 76,
    shirtNumber: '#1',
  ),
  LeaderboardPlayer(
    rank: 2,
    name: 'Giorgio Sulfaro',
    level: 61,
    shirtNumber: '#2',
  ),
  LeaderboardPlayer(
    rank: 3,
    name: 'Riccardo Pirrone',
    level: 56,
    shirtNumber: '#10',
    isCurrentUser: true,
  ),
  LeaderboardPlayer(
    rank: 4,
    name: 'Nicolas Cattafi',
    level: 51,
    shirtNumber: '#12',
  ),
  LeaderboardPlayer(
    rank: 5,
    name: 'Alessio Cattafi',
    level: 48,
    shirtNumber: '#91',
  ),
];

// ==========================================
// 3. SHELL DI NAVIGAZIONE PRINCIPALE (8 TAB)
// ==========================================

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ProfileScreen(
        player: riccardoProfile,
        onMissionUpdated: () => setState(() {}),
      ),
      TrainingsScreen(player: riccardoProfile),
      MatchesScreen(matches: allSeasonMatches),
      const ScoutScreen(),
      ProgressScreen(player: riccardoProfile),
      MissionDedicatedScreen(
        mission: riccardoProfile.currentMission,
        onMissionUpdated: () => setState(() {}),
      ),
      Top5Screen(players: top5Players),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0A0E1A),
            border: Border(
              bottom: BorderSide(color: Color(0xFF1E293B), width: 1),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                      ),
                      border: Border.all(color: Colors.white24),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'ATHLON',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131B2E),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF1E293B)),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      size: 20,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    final items = [
      {'icon': Icons.grid_view_rounded, 'label': 'Profilo'},
      {'icon': Icons.assignment_outlined, 'label': 'Allenamenti'},
      {'icon': Icons.sports_volleyball_outlined, 'label': 'Partite'},
      {'icon': Icons.center_focus_strong_outlined, 'label': 'Scout'},
      {'icon': Icons.trending_up_rounded, 'label': 'Progressi'},
      {'icon': Icons.auto_awesome_outlined, 'label': 'Missione'},
      {'icon': Icons.emoji_events_outlined, 'label': 'Top 5'},
      {'icon': Icons.logout_rounded, 'label': 'Esci'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D1322),
        border: Border(top: BorderSide(color: Color(0xFF1E293B), width: 1)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = _selectedIndex == index;
              final color = isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF64748B);
              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (index == 7) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Disconnessione...')),
                      );
                      return;
                    }
                    setState(() => _selectedIndex = index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(items[index]['icon'] as IconData, size: 20, color: color),
                      const SizedBox(height: 4),
                      Text(
                        items[index]['label'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. SCHERMATA: PROFILO (CON FOTO E 3 PAGINE PROFILO TECNICO)
// ==========================================

class ProfileScreen extends StatefulWidget {
  final PlayerProfile player;
  final VoidCallback onMissionUpdated;
  const ProfileScreen({
    super.key,
    required this.player,
    required this.onMissionUpdated,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTechTab = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.player;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Le mie squadre:  ',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Text(
                  p.teamLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHeroProfileCard(p),
          const SizedBox(height: 16),
          _buildDescriptionCard(p),
          const SizedBox(height: 16),
          _buildLevelProgressionCard(p),
          const SizedBox(height: 16),
          _buildStatsBarsCard(p),
          const SizedBox(height: 16),
          _buildRadarChartCard('Disegno statistiche', p, showIcon: true),
          const SizedBox(height: 16),
          _buildTechnicalProfileCard(p),
          const SizedBox(height: 16),
          _buildInnateAbilitiesCard(p),
          const SizedBox(height: 16),
          _buildSpecializationsCard(p),
          const SizedBox(height: 16),
          MissionCardWidget(
            mission: p.currentMission,
            onIncrementTask: (task) {
              setState(() {
                if (task.current < task.target) task.current++;
              });
              widget.onMissionUpdated();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeroProfileCard(PlayerProfile p) {
    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              // Carica prima pirrone_card.jpg; se l'utente l'ha salvata come .png, prova .png
              child: Image.asset(
                'assets/images/pirrone_card.jpg',
                width: 290,
                height: 370,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/pirrone_card.png',
                    width: 290,
                    height: 370,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) {
                      return Container(
                        width: 290,
                        height: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0F172A),
                              Color(0xFF1E3A8A),
                              Color(0xFF090D16),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFF3B82F6),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RICCARDO',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      'PIRRONE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  p.shirtNumber,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF60A5FA),
                                  ),
                                ),
                              ],
                            ),
                            const Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 54,
                                    color: Colors.white38,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Salva la foto generata in:\nassets/images/pirrone_card.jpg',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'SCHIACCIATORE',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            p.fullName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              _buildPillBadge(
                'LV ${p.level}',
                bgColor: const Color(0xFF2E2614),
                textColor: const Color(0xFFFBBF24),
              ),
              _buildPillBadge(
                p.role,
                bgColor: const Color(0xFF172554),
                textColor: const Color(0xFF60A5FA),
              ),
              _buildPillBadge(
                p.shirtNumber,
                bgColor: const Color(0xFF1E293B),
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoTile(Icons.calendar_today_outlined, 'Data di nascita', p.birthDate),
          const SizedBox(height: 10),
          _buildInfoTile(Icons.person_outline_rounded, 'Altezza', p.height),
          const SizedBox(height: 10),
          _buildInfoTile(Icons.fitness_center_rounded, 'Peso', p.weight),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1424),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3B82F6), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(PlayerProfile p) {
    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: Color(0xFF3B82F6), size: 22),
              SizedBox(width: 8),
              Text(
                'Descrizione atleta',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            p.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgressionCard(PlayerProfile p) {
    final double progress = p.currentLevelExp / p.nextLevelExpThreshold;
    final int percent = (progress * 100).round();
    final int remaining = p.nextLevelExpThreshold - p.currentLevelExp;

    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.workspace_premium_outlined, color: Color(0xFFFBBF24), size: 22),
              SizedBox(width: 8),
              Text(
                'Livello e progressione',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Livello ${p.level}',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              Text(
                '$percent%',
                style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: const Color(0xFF1E293B),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${p.currentLevelExp} / ${p.nextLevelExpThreshold} EXP',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              Text(
                '$remaining mancanti',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E1424),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EXP TOTALI',
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '64.563',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E1424),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXP NEL LIVELLO',
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${p.currentLevelExp}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBarsCard(PlayerProfile p) {
    final Map<String, String> statEmojis = {
      'Forza': '💪',
      'Agilità': '⚡',
      'Difesa': '🛡️',
      'Resistenza': '❤️',
      'Precisione': '🎯',
      'IQ Volley': '🧠',
      'Mentalità': '🔥',
    };

    const double maxBarReference = 500.0;

    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.trending_up_rounded, color: Color(0xFF3B82F6), size: 22),
              SizedBox(width: 8),
              Text(
                'Statistiche',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...p.stats.entries.map((entry) {
            final emoji = statEmojis[entry.key] ?? '📊';
            final ratio = (entry.value / maxBarReference).clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  SizedBox(
                    width: 125,
                    child: Row(
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: ratio,
                        minHeight: 8,
                        backgroundColor: const Color(0xFF1E293B),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E1424),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${entry.value}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==========================================
  // PROFILO TECNICO COMPLETO (PAGINE 1, 2, 3)
  // ==========================================
  Widget _buildTechnicalProfileCard(PlayerProfile p) {
    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con selettore 1 - 2 - 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.person_outline, color: Color(0xFF3B82F6), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Profilo tecnico',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E1424),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Row(
                  children: List.generate(3, (index) {
                    final active = _selectedTechTab == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTechTab = index),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? const Color(0xFF3B82F6) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: active ? Colors.white : const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_selectedTechTab == 0) _buildTechTabPage1(p),
          if (_selectedTechTab == 1) _buildTechTabPage2(p),
          if (_selectedTechTab == 2) _buildTechTabPage3(p),
        ],
      ),
    );
  }

  // PAGINA 1: Punti di forza
  Widget _buildTechTabPage1(PlayerProfile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFFFBBF24), size: 16),
            SizedBox(width: 6),
            Text(
              'Punti di forza',
              style: TextStyle(
                color: Color(0xFFFBBF24),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2229),
            borderRadius: BorderRadius.circular(12),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.55,
                color: Color(0xFFE2E8F0),
              ),
              children: p.strengths.map((item) {
                return TextSpan(
                  children: [
                    TextSpan(
                      text: '${item.title} — ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '${item.detail} '),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // PAGINA 2: Test Fisici, Tecnici, IQ Volley e Mentalità + Bottoni Storico / Salva risultati
  Widget _buildTechTabPage2(PlayerProfile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 430,
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 6),
              itemCount: p.testCategories.length,
              itemBuilder: (context, catIndex) {
                final category = p.testCategories[catIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(category.emoji, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            category.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...category.items.map((testItem) {
                        return _buildTechTestRow(testItem);
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Barra pulsanti in basso a destra: Storico | Salva risultati
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nessuno storico test salvato in precedenza.'),
                  ),
                );
              },
              icon: const Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: Colors.white,
              ),
              label: const Text(
                'Storico',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF0A0E1A),
                side: const BorderSide(color: Color(0xFF1E293B)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Risultati del profilo tecnico salvati!'),
                  ),
                );
              },
              icon: const Icon(
                Icons.save_outlined,
                size: 16,
                color: Color(0xFF0A0E1A),
              ),
              label: const Text(
                'Salva risultati',
                style: TextStyle(
                  color: Color(0xFF0A0E1A),
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3898FF),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTechTestRow(TechTestItem item) {
    final bool hasValue = (item.inputValue != null && item.inputValue!.trim().isNotEmpty) ||
        item.selectedRating != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1424),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E293B).withValues(alpha:0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 34,
            child: Text(
              item.code,
              style: const TextStyle(
                color: Color(0xFF3898FF),
                fontWeight: FontWeight.bold,
                fontSize: 12.5,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasValue ? 'Effettuato' : 'Non effettuato',
                  style: TextStyle(
                    fontSize: 12,
                    color: hasValue
                        ? const Color(0xFF34D399)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.inputType == TechInputType.rating012)
            Row(
              children: [0, 1, 2].map((val) {
                final isSelected = item.selectedRating == val;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      item.selectedRating = isSelected ? null : val;
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(left: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF131B2E),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF60A5FA)
                            : const Color(0xFF1E293B),
                      ),
                    ),
                    child: Text(
                      '$val',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : const Color(0xFFCBD5E1),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          else
            Row(
              children: [
                GestureDetector(
                  onTap: () => _showTestValueDialog(item),
                  child: Container(
                    width: 64,
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF121829),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF1E293B)),
                    ),
                    child: Text(
                      (item.inputValue == null || item.inputValue!.isEmpty)
                          ? '—'
                          : item.inputValue!,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 58,
                  child: Text(
                    item.unit,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showTestValueDialog(TechTestItem item) {
    final controller = TextEditingController(text: item.inputValue ?? '');
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF121829),
          title: Text(
            '${item.code} · ${item.name}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'Inserisci valore (${item.unit})',
              suffixText: item.unit,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  item.inputValue = controller.text.trim();
                });
                Navigator.pop(ctx);
              },
              child: const Text('Conferma'),
            ),
          ],
        );
      },
    );
  }

  // PAGINA 3: Storico Stagioni / Campionati
  Widget _buildTechTabPage3(PlayerProfile p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => _showSeasonDialog(p),
          icon: const Icon(Icons.add, size: 18, color: Color(0xFF0A0E1A)),
          label: const Text(
            'Aggiungi stagione / campionato',
            style: TextStyle(
              color: Color(0xFF0A0E1A),
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3898FF),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 410,
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 6),
              itemCount: p.careerSeasons.length,
              itemBuilder: (context, index) {
                final s = p.careerSeasons[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.seasonLabel,
                        style: const TextStyle(
                          color: Color(0xFF3898FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E1424),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF1E293B).withValues(alpha:0.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    s.teamAndCategory,
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    s.roleAndShirt,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                  if (s.achievementBadge != null &&
                                      s.achievementBadge!.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      s.achievementBadge!,
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFBBF24),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _showSeasonDialog(p, editItem: s),
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                    color: Color(0xFFCBD5E1),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      p.careerSeasons.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    size: 18,
                                    color: Color(0xFFEF4444),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showSeasonDialog(PlayerProfile p, {SeasonCareerEntry? editItem}) {
    final seasonCtrl = TextEditingController(
      text: editItem?.seasonLabel ?? 'Stagione 2026/27',
    );
    final teamCtrl = TextEditingController(
      text: editItem?.teamAndCategory ?? 'Athlon · Serie D',
    );
    final roleCtrl = TextEditingController(
      text: editItem?.roleAndShirt ?? 'Schiacciatore · Maglia 10',
    );
    final badgeCtrl = TextEditingController(
      text: editItem?.achievementBadge ?? '',
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF121829),
          title: Text(
            editItem == null
                ? 'Aggiungi stagione / campionato'
                : 'Modifica stagione',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: seasonCtrl,
                  decoration: const InputDecoration(labelText: 'Stagione (es. Stagione 2024/25)'),
                ),
                TextField(
                  controller: teamCtrl,
                  decoration: const InputDecoration(labelText: 'Squadra e Categoria'),
                ),
                TextField(
                  controller: roleCtrl,
                  decoration: const InputDecoration(labelText: 'Ruolo e Maglia'),
                ),
                TextField(
                  controller: badgeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Titolo / Risultato (opzionale)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (editItem == null) {
                    p.careerSeasons.insert(
                      0,
                      SeasonCareerEntry(
                        seasonLabel: seasonCtrl.text.trim(),
                        teamAndCategory: teamCtrl.text.trim(),
                        roleAndShirt: roleCtrl.text.trim(),
                        achievementBadge: badgeCtrl.text.trim().isEmpty
                            ? null
                            : badgeCtrl.text.trim(),
                      ),
                    );
                  } else {
                    editItem.seasonLabel = seasonCtrl.text.trim();
                    editItem.teamAndCategory = teamCtrl.text.trim();
                    editItem.roleAndShirt = roleCtrl.text.trim();
                    editItem.achievementBadge = badgeCtrl.text.trim().isEmpty
                        ? null
                        : badgeCtrl.text.trim();
                  }
                });
                Navigator.pop(ctx);
              },
              child: const Text('Salva'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInnateAbilitiesCard(PlayerProfile p) {
    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.military_tech_outlined, color: Color(0xFFFBBF24), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Abilità innate',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              _buildPillBadge(
                'Fase Evoluzione',
                bgColor: const Color(0xFF172554),
                textColor: const Color(0xFF60A5FA),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...p.abilities.map((ab) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0E1424),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E293B)),
              ),
              child: ab.isLocked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ab.stageLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.lock_outline, size: 15, color: Color(0xFF64748B)),
                            SizedBox(width: 4),
                            Text(
                              'Bloccata',
                              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ab.stageLabel,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ab.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ab.bonuses,
                          style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
            );
          }),
          const SizedBox(height: 4),
          const Text(
            'Bonus EXP sulle attività pertinenti: +10%. I moltiplicatori valgono solo sui nuovi punti.',
            style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationsCard(PlayerProfile p) {
    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.emoji_events_outlined, color: Color(0xFF38BDF8), size: 22),
              SizedBox(width: 8),
              Text(
                'Specializzazioni',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF13203B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1E3A8A)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Specializzazione principale',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
                SizedBox(height: 4),
                Text(
                  'Picchiatore',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '💪 Forza 120 · Grado I',
                  style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...p.specializations.map((spec) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(spec.iconEmoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(spec.name, style: const TextStyle(fontSize: 14)),
                      if (spec.pendingApproval) ...[
                        const SizedBox(width: 6),
                        const Text('⚠️', style: TextStyle(fontSize: 13)),
                      ],
                    ],
                  ),
                  Row(
                    children: List.generate(4, (i) {
                      final active = i < spec.step;
                      return Container(
                        width: 18,
                        height: 7,
                        margin: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          const Text(
            '⚠️ Da verificare: i titoli di Mentalità sono una proposta in attesa di approvazione.',
            style: TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. SCHERMATA: ALLENAMENTI
// ==========================================

class TrainingsScreen extends StatefulWidget {
  final PlayerProfile player;
  const TrainingsScreen({super.key, required this.player});

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    final pastTrainings = widget.player.trainingExpLogs;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Allenamenti',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTogglePill(
                  label: 'Prossimi (0)',
                  selected: _showUpcoming,
                  onTap: () => setState(() => _showUpcoming = true),
                ),
                _buildTogglePill(
                  label: 'Passati (${pastTrainings.length})',
                  selected: !_showUpcoming,
                  onTap: () => setState(() => _showUpcoming = false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_showUpcoming)
            const _SectionContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 22),
                child: Center(
                  child: Text(
                    'Nessun allenamento in programma.',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                  ),
                ),
              ),
            )
          else
            ...pastTrainings.map((log) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF121829),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.event_available_rounded,
                          color: Color(0xFF3B82F6),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sessione Allenamento Athlon',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              log.date,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '+${log.expGained} EXP',
                      style: const TextStyle(
                        color: Color(0xFFFBBF24),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

// ==========================================
// 6. SCHERMATA: PARTITE (20 PROSSIME + 2 PASSATE CON PARZIALI)
// ==========================================

class MatchesScreen extends StatefulWidget {
  final List<MatchItem> matches;
  const MatchesScreen({super.key, required this.matches});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    final upcomingMatches = widget.matches.where((m) => !m.isPast).toList();
    final pastMatches = widget.matches.where((m) => m.isPast).toList();
    final displayed = _showUpcoming ? upcomingMatches : pastMatches;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF131B2E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTogglePill(
                  label: 'Prossime (${upcomingMatches.length})',
                  selected: _showUpcoming,
                  onTap: () => setState(() => _showUpcoming = true),
                ),
                _buildTogglePill(
                  label: 'Passate (${pastMatches.length})',
                  selected: !_showUpcoming,
                  onTap: () => setState(() => _showUpcoming = false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...displayed.map((m) {
            return m.isPast
                ? _buildPastMatchCard(m)
                : _buildUpcomingMatchCard(m);
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatchCard(MatchItem m) {
    final iconEmoji = m.isHome ? '🏠' : '✈️';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF121829),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(iconEmoji, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        m.opponent,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'SERIE D MASCHILE · Giornata ${m.giornata} · ${m.date} · ${m.time}',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF64748B),
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildPastMatchCard(MatchItem m) {
    final iconEmoji = m.isHome ? '🏠' : '✈️';
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121829),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E3A8A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(iconEmoji, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            m.opponent,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SERIE D MASCHILE · Giornata ${m.giornata} · Gara ${m.matchCode} · ${m.date} · ${m.time}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF064E3B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF10B981)),
                ),
                child: Text(
                  'VITTORIA ${m.result}',
                  style: const TextStyle(
                    color: Color(0xFF34D399),
                    fontWeight: FontWeight.w900,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0E1424),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${m.homeTeamFull}  vs  ${m.awayTeamFull}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFCBD5E1),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'PARZIALI SET:',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: List.generate(m.setScores.length, (i) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF172554),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF2563EB)),
                      ),
                      child: Text(
                        '${i + 1}° Set: ${m.setScores[i]}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF93C5FD),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. SCHERMATA: IL MIO SCOUT
// ==========================================

class ScoutScreen extends StatelessWidget {
  const ScoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.center_focus_strong_outlined,
                color: Color(0xFF3B82F6),
                size: 28,
              ),
              SizedBox(width: 10),
              Text(
                'Il mio scout',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          SizedBox(height: 20),
          _SectionContainer(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 22),
              child: Center(
                child: Text(
                  'Nessuna statistica scout disponibile.',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 8. SCHERMATA: I MIEI PROGRESSI
// ==========================================

class ProgressScreen extends StatelessWidget {
  final PlayerProfile player;
  const ProgressScreen({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final remainingExp = player.nextLevelExpThreshold - player.currentLevelExp;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'I miei progressi',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),

          _SectionContainer(
            child: Column(
              children: [
                _buildStatSummaryBox('LIVELLO ATTUALE', 'LV ${player.level}'),
                const SizedBox(height: 12),
                _buildStatSummaryBox('EXP TOTALI', '64.563'),
                const SizedBox(height: 12),
                _buildStatSummaryBox('EXP PER LV ${player.level + 1}', '66.120'),
                const SizedBox(height: 12),
                _buildStatSummaryBox(
                  'EXP MANCANTI',
                  '$remainingExp',
                  valueColor: const Color(0xFFFBBF24),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildRadarChartCard('Radar attuale', player, showIcon: false),
          const SizedBox(height: 16),

          _SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progressione EXP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: ExpProgressionChartPainter(
                      points: player.expChartPoints,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Storico Level Up',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ...player.levelUpHistory.map((ev) {
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E1424),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ev.date,
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 14,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(text: 'LV ${ev.fromLevel} → '),
                                  TextSpan(
                                    text: '${ev.toLevel}',
                                    style: const TextStyle(color: Color(0xFFFBBF24)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 14,
                          runSpacing: 8,
                          children: ev.statGains.entries.map((e) {
                            return Text(
                              '${e.key} +${e.value}',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFFCBD5E1),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _SectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EXP per allenamento',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ...player.trainingExpLogs.map((log) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E1424),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          log.date,
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '+${log.expGained} EXP',
                          style: const TextStyle(
                            color: Color(0xFFFBBF24),
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatSummaryBox(
    String label,
    String value, {
    Color valueColor = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1424),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 9. SCHERMATA: LA MIA MISSIONE
// ==========================================

class MissionDedicatedScreen extends StatefulWidget {
  final MonthlyMission mission;
  final VoidCallback onMissionUpdated;
  const MissionDedicatedScreen({
    super.key,
    required this.mission,
    required this.onMissionUpdated,
  });

  @override
  State<MissionDedicatedScreen> createState() => _MissionDedicatedScreenState();
}

class _MissionDedicatedScreenState extends State<MissionDedicatedScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Text('🎯', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'La mia\nmissione',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 14, color: Color(0xFF94A3B8)),
                    SizedBox(width: 6),
                    Text(
                      'I progressi vengono\nconvalidati dal coach',
                      style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          MissionCardWidget(
            mission: widget.mission,
            onIncrementTask: (task) {
              setState(() {
                if (task.current < task.target) task.current++;
              });
              widget.onMissionUpdated();
            },
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 10. SCHERMATA: TOP 5
// ==========================================

class Top5Screen extends StatelessWidget {
  final List<LeaderboardPlayer> players;
  const Top5Screen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.emoji_events_outlined,
                color: Color(0xFFFBBF24),
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                'Top 5',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Classifica per livello. I profili dei compagni non sono consultabili.',
            style: TextStyle(
              fontSize: 14.5,
              color: Color(0xFF94A3B8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          ...players.map((p) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF121829),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: p.isCurrentUser
                      ? const Color(0xFF2563EB).withValues(alpha:0.6)
                      : const Color(0xFF1E293B),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text(
                      '${p.rank}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
                      ),
                      border: Border.all(
                        color: const Color(0xFF3B82F6),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 22,
                          color: Color(0xFF93C5FD),
                        ),
                        Text(
                          p.shirtNumber,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF172554),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'LV ${p.level}',
                      style: const TextStyle(
                        color: Color(0xFF60A5FA),
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ==========================================
// 11. COMPONENTI GRAFICI CONDIVISI
// ==========================================

Widget _buildTogglePill({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0A0E1A) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Colors.white : const Color(0xFF94A3B8),
        ),
      ),
    ),
  );
}

class MissionCardWidget extends StatelessWidget {
  final MonthlyMission mission;
  final void Function(MissionTask task) onIncrementTask;

  const MissionCardWidget({
    super.key,
    required this.mission,
    required this.onIncrementTask,
  });

  @override
  Widget build(BuildContext context) {
    final totalDone = mission.tasks.fold<int>(0, (sum, t) => sum + t.current);
    final totalTarget = mission.tasks.fold<int>(0, (sum, t) => sum + t.target);
    final double ratio = totalTarget == 0 ? 0 : totalDone / totalTarget;

    return _SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.track_changes_rounded, color: Color(0xFFEF4444), size: 22),
              SizedBox(width: 8),
              Text(
                'Missione del mese',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                mission.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 8),
              _buildPillBadge(
                mission.status,
                bgColor: const Color(0xFF2E2614),
                textColor: const Color(0xFFFBBF24),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...mission.tasks.map((task) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                task.description,
                                style: const TextStyle(fontSize: 13.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${task.current}/${task.target}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: OutlinedButton.icon(
                      onPressed: () => onIncrementTask(task),
                      icon: const Icon(Icons.add, size: 16, color: Colors.white),
                      label: const Text(
                        'Invia progresso',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A0E1A),
                        side: const BorderSide(color: Color(0xFF1E293B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0E1424),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ricompensa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text('✨ +${mission.expReward} EXP', style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                Text('🎯 ${mission.statRewardLabel}', style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF0E1424),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: ratio,
                        strokeWidth: 9,
                        backgroundColor: const Color(0xFF1E3A8A).withValues(alpha:0.4),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                      Center(
                        child: Text(
                          '${(ratio * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Progresso missione',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRadarChartCard(String title, PlayerProfile p, {bool showIcon = true}) {
  return _SectionContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (showIcon) ...[
              const Icon(Icons.trending_up_rounded, color: Color(0xFF3B82F6), size: 22),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            width: 280,
            height: 280,
            child: CustomPaint(
              painter: RadarChartPainter(
                stats: p.stats,
                maxStatValue: 500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

Widget _buildPillBadge(
  String text, {
  required Color bgColor,
  required Color textColor,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class RadarChartPainter extends CustomPainter {
  final Map<String, int> stats;
  final double maxStatValue;

  RadarChartPainter({required this.stats, required this.maxStatValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 34;
    final keys = stats.keys.toList();
    final count = keys.length;
    final angleStep = (2 * pi) / count;

    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int level = 1; level <= 4; level++) {
      final r = radius * (level / 4);
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = -pi / 2 + i * angleStep;
        final point = Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    for (int i = 0; i < count; i++) {
      final angle = -pi / 2 + i * angleStep;
      final outerPoint = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(center, outerPoint, gridPaint);

      final labelRadius = radius + 22;
      final labelPoint = Offset(
        center.dx + labelRadius * cos(angle),
        center.dy + labelRadius * sin(angle),
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: keys[i],
          style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(
        labelPoint.dx - textPainter.width / 2,
        labelPoint.dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }

    final dataPath = Path();
    for (int i = 0; i < count; i++) {
      final val = (stats[keys[i]] ?? 0).clamp(0, maxStatValue);
      final r = radius * (val / maxStatValue);
      final angle = -pi / 2 + i * angleStep;
      final pt = Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
      if (i == 0) {
        dataPath.moveTo(pt.dx, pt.dy);
      } else {
        dataPath.lineTo(pt.dx, pt.dy);
      }
    }
    dataPath.close();

    final fillPaint = Paint()
      ..color = const Color(0xFF3B82F6).withValues(alpha:0.35)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(dataPath, fillPaint);
    canvas.drawPath(dataPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ExpProgressionChartPainter extends CustomPainter {
  final List<ExpHistoryPoint> points;
  ExpProgressionChartPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPad = 36;
    const double bottomPad = 26;
    const double topPad = 10;
    const double rightPad = 12;

    final chartW = size.width - leftPad - rightPad;
    final chartH = size.height - topPad - bottomPad;
    const double maxY = 1200.0;

    final axisPaint = Paint()
      ..color = const Color(0xFF475569)
      ..strokeWidth = 1;

    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..strokeWidth = 1;

    final yTicks = [0, 300, 600, 900, 1200];
    for (final tick in yTicks) {
      final y = topPad + chartH * (1 - tick / maxY);
      canvas.drawLine(Offset(leftPad, y), Offset(leftPad + chartW, y), gridPaint);

      final tp = TextPainter(
        text: TextSpan(
          text: '$tick',
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPad - tp.width - 6, y - tp.height / 2));
    }

    canvas.drawLine(Offset(leftPad, topPad), Offset(leftPad, topPad + chartH), axisPaint);
    canvas.drawLine(
      Offset(leftPad, topPad + chartH),
      Offset(leftPad + chartW, topPad + chartH),
      axisPaint,
    );

    if (points.length < 2) return;

    final cumulativePath = Path();
    final sessionPath = Path();

    for (int i = 0; i < points.length; i++) {
      final x = leftPad + (i / (points.length - 1)) * chartW;
      final yCum = topPad + chartH * (1 - (points[i].cumulativeExp / maxY).clamp(0.0, 1.0));
      final ySes = topPad + chartH * (1 - (points[i].sessionExp / maxY).clamp(0.0, 1.0));

      if (i == 0) {
        cumulativePath.moveTo(x, yCum);
        sessionPath.moveTo(x, ySes);
      } else {
        cumulativePath.lineTo(x, yCum);
        sessionPath.lineTo(x, ySes);
      }

      if (points[i].dateLabel.isNotEmpty) {
        final tp = TextPainter(
          text: TextSpan(
            text: points[i].dateLabel,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9.5),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(
          canvas,
          Offset((x - tp.width / 2).clamp(leftPad, size.width - tp.width), topPad + chartH + 8),
        );
      }
    }

    final blueLinePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final goldLinePaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(cumulativePath, blueLinePaint);
    canvas.drawPath(sessionPath, goldLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SectionContainer extends StatelessWidget {
  final Widget child;
  const _SectionContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF121829),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: child,
    );
  }
}