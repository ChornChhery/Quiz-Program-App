import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(const ProgrammerQuizApp());

class ProgrammerQuizApp extends StatelessWidget {
  const ProgrammerQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programmer Quiz Terminal',
      theme: _buildNeoTerminalTheme(),
      home: const CategoryPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildNeoTerminalTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF00BFFF), // Electric Blue
      scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Deep Charcoal
      fontFamily: 'Courier', // Monospace font
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C2C),
          foregroundColor: const Color(0xFF00BFFF),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Courier',
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: Color(0xFF00BFFF), width: 1),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2C2C2C),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: Color(0xFF00BFFF), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1A1A1A),
        foregroundColor: Color(0xFF00BFFF),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Courier',
          color: Color(0xFF00BFFF),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE0E0E0),
          fontFamily: 'Courier',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF00BFFF),
          fontFamily: 'Courier',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFFE0E0E0),
          fontFamily: 'Courier',
        ),
      ),
    );
  }
}

class Question {
  final String questionText, category;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.category,
  });
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const categories = [
    'Fundamentals',
    'Data Structures & Algorithms',
    'Web Development',
    'Object-Oriented Programming',
    'Databases',
    'Version Control (Git)',
    'Software Testing',
    'Cloud Computing'
  ];

  static const _categoryData = {
    'fundamentals': {'icon': Icons.code, 'color': Color(0xFF00BFFF)},
    'data structures & algorithms': {'icon': Icons.account_tree, 'color': Color(0xFF39FF14)},
    'web development': {'icon': Icons.web, 'color': Color(0xFFFFA500)},
    'object-oriented programming': {'icon': Icons.class_, 'color': Color(0xFFFF6B6B)},
    'databases': {'icon': Icons.storage, 'color': Color(0xFF4ECDC4)},
    'version control (git)': {'icon': Icons.merge_type, 'color': Color(0xFFFFE66D)},
    'software testing': {'icon': Icons.bug_report, 'color': Color(0xFFFF8A80)},
    'cloud computing': {'icon': Icons.cloud, 'color': Color(0xFF81C784)},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('> SELECT CATEGORY'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFF00BFFF),
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF0D1117)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildTerminalHeader(context),
            const SizedBox(height: 30),
            Expanded(child: _buildCategoryList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '╭─ PROGRAMMER QUIZ TERMINAL',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF00BFFF),
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '├─ Test your programming knowledge',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF888888),
              ),
        ),
        Text(
          '╰─ Choose a category to begin...',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF888888),
              ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => _buildCategoryItem(context, categories[index], index),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String category, int index) {
    final data = _categoryData[category.toLowerCase()]!;
    final color = data['color'] as Color;
    final icon = data['icon'] as IconData;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToQuiz(context, category),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color, width: 1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color, width: 1),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(index + 1).toString().padLeft(2, '0')}. ${category.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'Courier',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '6 questions • Programming concepts',
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFF888888),
                          fontFamily: 'Courier',
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context, String category) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => QuizPage(selectedCategory: category),
        transitionsBuilder: (context, animation, _, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String selectedCategory;

  const QuizPage({super.key, required this.selectedCategory});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  static const _allQuestions = [
    // Fundamentals
    Question(category: 'Fundamentals', questionText: 'What is the primary purpose of a `for` loop in most programming languages?', options: ['To define a new function', 'To execute a block of code a specific number of times', 'To handle errors in a program', 'To declare a variable'], correctIndex: 1),
    Question(category: 'Fundamentals', questionText: 'Which of the following data types is typically used to store whole numbers?', options: ['float', 'string', 'boolean', 'integer'], correctIndex: 3),
    Question(category: 'Fundamentals', questionText: 'In programming, what does the term "variable" refer to?', options: ['A fixed value that cannot be changed', 'A named storage location that holds a value', 'A type of error in code', 'A command to print output to the console'], correctIndex: 1),
    Question(category: 'Fundamentals', questionText: 'What is the output of `print(5 + 3 * 2)` in most programming languages?', options: ['16', '11', '13', '10'], correctIndex: 1),
    Question(category: 'Fundamentals', questionText: 'Which concept allows a function to call itself?', options: ['Iteration', 'Polymorphism', 'Recursion', 'Abstraction'], correctIndex: 2),
    Question(category: 'Fundamentals', questionText: 'What is the purpose of an `if-else` statement?', options: ['To create a loop', 'To define a class', 'To execute different code blocks based on a condition', 'To declare multiple variables'], correctIndex: 2),

    // Data Structures & Algorithms
    Question(category: 'Data Structures & Algorithms', questionText: 'Which data structure uses a Last-In, First-Out (LIFO) principle?', options: ['Queue', 'Linked List', 'Stack', 'Tree'], correctIndex: 2),
    Question(category: 'Data Structures & Algorithms', questionText: 'What is the time complexity of searching for an element in a well-balanced binary search tree in the worst case?', options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'], correctIndex: 2),
    Question(category: 'Data Structures & Algorithms', questionText: 'Which algorithm sorts elements by repeatedly swapping adjacent elements if they are in the wrong order?', options: ['Merge Sort', 'Quick Sort', 'Bubble Sort', 'Insertion Sort'], correctIndex: 2),
    Question(category: 'Data Structures & Algorithms', questionText: 'A collection of nodes where each node has a value and a pointer to the next node is called a:', options: ['Array', 'Hash Table', 'Linked List', 'Graph'], correctIndex: 2),
    Question(category: 'Data Structures & Algorithms', questionText: 'What is the primary advantage of using a hash table?', options: ['Elements are always sorted', 'Fast average-case time complexity for insertions, deletions, and lookups', 'Uses less memory than arrays', 'Guarantees constant time access in all cases'], correctIndex: 1),
    Question(category: 'Data Structures & Algorithms', questionText: 'Which traversal method visits the root node, then the left subtree, then the right subtree?', options: ['Post-order', 'Pre-order', 'In-order', 'Level-order'], correctIndex: 1),

    // Web Development
    Question(category: 'Web Development', questionText: 'Which HTML tag is used to define an internal style sheet?', options: ['<script>', '<css>', '<style>', '<link>'], correctIndex: 2),
    Question(category: 'Web Development', questionText: 'What does CSS stand for?', options: ['Creative Style Sheets', 'Cascading Style Sheets', 'Computer Style Sheets', 'Colorful Style Sheets'], correctIndex: 1),
    Question(category: 'Web Development', questionText: 'Which JavaScript keyword is used to declare a variable that cannot be reassigned?', options: ['var', 'let', 'const', 'static'], correctIndex: 2),
    Question(category: 'Web Development', questionText: 'What is the purpose of a RESTful API?', options: ['To manage databases', 'To provide a standardized way for computer systems to communicate over the web', 'To compile JavaScript code', 'To design user interfaces'], correctIndex: 1),
    Question(category: 'Web Development', questionText: 'Which of the following is a popular JavaScript framework for building user interfaces?', options: ['Django', 'Flask', 'React', 'Ruby on Rails'], correctIndex: 2),
    Question(category: 'Web Development', questionText: 'What is the default port for HTTP?', options: ['8080', '443', '80', '21'], correctIndex: 2),

    // Object-Oriented Programming
    Question(category: 'Object-Oriented Programming', questionText: 'Which OOP principle refers to the bundling of data and methods that operate on the data within a single unit?', options: ['Inheritance', 'Polymorphism', 'Encapsulation', 'Abstraction'], correctIndex: 2),
    Question(category: 'Object-Oriented Programming', questionText: 'What is the mechanism by which one class acquires the properties and behaviors of another class?', options: ['Encapsulation', 'Inheritance', 'Abstraction', 'Association'], correctIndex: 1),
    Question(category: 'Object-Oriented Programming', questionText: 'Which concept allows objects of different classes to be treated as objects of a common superclass?', options: ['Encapsulation', 'Inheritance', 'Polymorphism', 'Aggregation'], correctIndex: 2),
    Question(category: 'Object-Oriented Programming', questionText: 'What is an "abstract class" in OOP?', options: ['A class that cannot be inherited', 'A class that can only have static methods', 'A class that cannot be instantiated directly and may contain abstract methods', 'A class used only for data storage'], correctIndex: 2),
    Question(category: 'Object-Oriented Programming', questionText: 'What is method overloading?', options: ['Defining multiple methods with the same name but different parameters in the same class', 'Defining a method in a subclass with the same name and parameters as a method in its superclass', 'Calling a method too many times', 'A method that takes too many arguments'], correctIndex: 0),
    Question(category: 'Object-Oriented Programming', questionText: 'Which of the following is NOT one of the four main pillars of OOP?', options: ['Encapsulation', 'Inheritance', 'Debugging', 'Polymorphism'], correctIndex: 2),

    // Databases
    Question(category: 'Databases', questionText: 'Which SQL keyword is used to extract data from a database?', options: ['UPDATE', 'INSERT', 'SELECT', 'DELETE'], correctIndex: 2),
    Question(category: 'Databases', questionText: 'What does SQL stand for?', options: ['Structured Question Language', 'Standard Query Language', 'Structured Query Language', 'Simple Query Logic'], correctIndex: 2),
    Question(category: 'Databases', questionText: 'Which type of database stores data in tables with rows and columns?', options: ['NoSQL database', 'Graph database', 'Relational database', 'Document database'], correctIndex: 2),
    Question(category: 'Databases', questionText: 'What is a primary key in a database table?', options: ['A key that can be duplicated across multiple rows', 'A column or set of columns that uniquely identifies each row in a table', 'A key used for encryption', 'A key that links to another table'], correctIndex: 1),
    Question(category: 'Databases', questionText: 'Which of the following is an example of a NoSQL database?', options: ['MySQL', 'PostgreSQL', 'MongoDB', 'Oracle Database'], correctIndex: 2),
    Question(category: 'Databases', questionText: 'What is the purpose of a `JOIN` clause in SQL?', options: ['To insert new rows into a table', 'To combine rows from two or more tables based on a related column between them', 'To delete rows from a table', 'To update existing data in a table'], correctIndex: 1),

    // Version Control (Git)
    Question(category: 'Version Control (Git)', questionText: 'What is the command to initialize a new Git repository?', options: ['git start', 'git new', 'git init', 'git create'], correctIndex: 2),
    Question(category: 'Version Control (Git)', questionText: 'Which command is used to record changes to the repository?', options: ['git save', 'git add', 'git commit', 'git push'], correctIndex: 2),
    Question(category: 'Version Control (Git)', questionText: 'What is a "branch" in Git?', options: ['A separate copy of the entire repository', 'A lightweight movable pointer to a commit', 'A tag for a specific version', 'A remote repository'], correctIndex: 1),
    Question(category: 'Version Control (Git)', questionText: 'Which command is used to download changes from a remote repository to your local repository?', options: ['git push', 'git commit', 'git pull', 'git merge'], correctIndex: 2),
    Question(category: 'Version Control (Git)', questionText: 'What does `git status` do?', options: ['Shows the commit history', 'Shows the working tree status, including changes staged, unstaged, and untracked files', 'Uploads changes to a remote repository', 'Deletes files from the repository'], correctIndex: 1),
    Question(category: 'Version Control (Git)', questionText: 'How do you create a new branch and switch to it in one command?', options: ['git branch -new <branchname>', 'git checkout -b <branchname>', 'git switch <branchname>', 'git create branch <branchname>'], correctIndex: 1),

    // Software Testing
    Question(category: 'Software Testing', questionText: 'What is the primary goal of unit testing?', options: ['To test the entire system as a whole', 'To verify individual components or functions of a software application', 'To test the integration between different modules', 'To test the software with real users'], correctIndex: 1),
    Question(category: 'Software Testing', questionText: 'Which type of testing focuses on verifying that different modules or services used in a system work together correctly?', options: ['Unit Testing', 'Integration Testing', 'System Testing', 'Acceptance Testing'], correctIndex: 1),
    Question(category: 'Software Testing', questionText: 'What is a "test case"?', options: ['A bug found during testing', 'A set of conditions or variables under which a tester will determine if a system is working correctly', 'A tool used for automated testing', 'A report summarizing test results'], correctIndex: 1),
    Question(category: 'Software Testing', questionText: 'Which testing approach involves testing the internal structure or workings of an application, as opposed to its functionality?', options: ['Black-box testing', 'Gray-box testing', 'White-box testing', 'User acceptance testing'], correctIndex: 2),
    Question(category: 'Software Testing', questionText: 'What is the purpose of regression testing?', options: ['To test new features', 'To ensure that recent program or code changes have not adversely affected existing features', 'To test the performance of the application', 'To test the security vulnerabilities'], correctIndex: 1),
    Question(category: 'Software Testing', questionText: 'What does TDD stand for?', options: ['Test Driven Development', 'Technical Design Document', 'Test Data Definition', 'Tool Driven Design'], correctIndex: 0),

    // Cloud Computing
    Question(category: 'Cloud Computing', questionText: 'Which cloud service model provides virtualized computing resources over the internet, including virtual machines, storage, and networks?', options: ['SaaS (Software as a Service)', 'PaaS (Platform as a Service)', 'IaaS (Infrastructure as a Service)', 'FaaS (Function as a Service)'], correctIndex: 2),
    Question(category: 'Cloud Computing', questionText: 'Which of the following is a characteristic of cloud computing?', options: ['Limited scalability', 'On-premise infrastructure', 'Pay-as-you-go pricing', 'Manual resource provisioning'], correctIndex: 2),
    Question(category: 'Cloud Computing', questionText: 'What is a "public cloud"?', options: ['A cloud infrastructure operated solely for a single organization', 'A cloud infrastructure that is provisioned for open use by the general public', 'A cloud infrastructure that combines private and public clouds', 'A cloud infrastructure hosted within a company\'s own data center'], correctIndex: 1),
    Question(category: 'Cloud Computing', questionText: 'Which cloud service model allows developers to build, run, and manage applications without the complexity of building and maintaining the infrastructure typically associated with developing and launching an app?', options: ['IaaS', 'PaaS', 'SaaS', 'DaaS'], correctIndex: 1),
    Question(category: 'Cloud Computing', questionText: 'Which major cloud provider offers services like EC2, S3, and Lambda?', options: ['Google Cloud Platform (GCP)', 'Microsoft Azure', 'Amazon Web Services (AWS)', 'IBM Cloud'], correctIndex: 2),
    Question(category: 'Cloud Computing', questionText: 'What is serverless computing?', options: ['Running applications on physical servers without an operating system', 'A cloud execution model where the cloud provider dynamically manages the allocation and provisioning of servers', 'Running applications on local servers without internet access', 'A computing model that requires no servers at all'], correctIndex: 1),
  ];

  late List<Question> questions;
  int currentQuestion = 0, score = 0, timeLeft = 20;
  bool quizFinished = false, isAnswered = false;
  int? selectedAnswerIndex;
  late AnimationController _animationController, _progressController;
  late Animation<double> _fadeAnimation, _progressAnimation;
  late Animation<Offset> _slideAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _shuffleQuestions();
  }

  void _initAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _progressController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));
  }

  void _shuffleQuestions() {
    final categoryQuestions = _allQuestions.where((q) => q.category == widget.selectedCategory).toList()..shuffle();
    questions = categoryQuestions.take(6).toList();
    _resetQuizState();
    _startTimer();
  }

  void _resetQuizState() {
    currentQuestion = score = 0;
    timeLeft = 20;
    quizFinished = isAnswered = false;
    selectedAnswerIndex = null;
    _animationController.reset();
    _progressController.reset();
    _animationController.forward();
    _progressController.forward();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else if (!isAnswered) {
          _answerQuestion(-1);
        }
      });
    });
  }

  void _answerQuestion(int selectedIndex) {
    if (isAnswered) return;
    
    setState(() {
      isAnswered = true;
      selectedAnswerIndex = selectedIndex;
      if (selectedIndex == questions[currentQuestion].correctIndex) score++;
    });

    _timer.cancel();
    Future.delayed(const Duration(milliseconds: 2000), _nextQuestion);
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        isAnswered = false;
        selectedAnswerIndex = null;
        timeLeft = 20;
        _animationController.reset();
        _progressController.reset();
        _animationController.forward();
        _progressController.forward();
        _startTimer();
      } else {
        quizFinished = true;
      }
    });
  }

  void _resetQuiz() {
    _timer.cancel();
    setState(_shuffleQuestions);
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('> ${widget.selectedCategory.toUpperCase()}'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _resetQuiz,
          tooltip: 'Restart Quiz',
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFF00BFFF),
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF0D1117)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: quizFinished ? _buildResultView() : _buildQuestionView(),
      ),
    );
  }

  Widget _buildQuestionView() {
    final question = questions[currentQuestion];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        _buildProgressBar(),
        const SizedBox(height: 30),
        _buildQuestionCard(question),
        const SizedBox(height: 30),
        Expanded(child: _buildOptionsList(question)),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'QUESTION ${currentQuestion + 1}/${questions.length}',
          style: const TextStyle(
            color: Color(0xFF00BFFF),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier',
          ),
        ),
        _buildTimerDisplay(),
      ],
    );
  }

  Widget _buildTimerDisplay() {
    final isUrgent = timeLeft <= 5;
    final color = isUrgent ? const Color(0xFFFF6B6B) : const Color(0xFF39FF14);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '${timeLeft}s',
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROGRESS: ${((currentQuestion + 1) / questions.length * 100).toInt()}%',
              style: const TextStyle(
                color: Color(0xFF888888),
                fontSize: 12,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: ((currentQuestion + 1) / questions.length) * _progressAnimation.value,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00BFFF)),
                  minHeight: 4,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuestionCard(Question question) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF00BFFF), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'QUERY:',
                style: TextStyle(
                  color: const Color(0xFF00BFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                question.questionText,
                style: const TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: 'Courier',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(Question question) {
    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) => _buildOptionCard(question, index),
    );
  }

  Widget _buildOptionCard(Question question, int index) {
    final isSelected = selectedAnswerIndex == index;
    final isCorrect = index == question.correctIndex;
    final showResult = isAnswered;

    Color getColor() {
      if (!showResult) return const Color(0xFF2C2C2C);
      if (isCorrect) return const Color(0xFF39FF14).withOpacity(0.1);
      if (isSelected && !isCorrect) return const Color(0xFFFF6B6B).withOpacity(0.1);
      return const Color(0xFF2C2C2C);
    }

    Color getBorderColor() {
      if (!showResult) return const Color(0xFF555555);
      if (isCorrect) return const Color(0xFF39FF14);
      if (isSelected && !isCorrect) return const Color(0xFFFF6B6B);
      return const Color(0xFF555555);
    }

    String getPrefix() {
      if (!showResult) return String.fromCharCode(65 + index);
      if (isCorrect) return '✓';
      if (isSelected && !isCorrect) return '✗';
      return String.fromCharCode(65 + index);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAnswered ? null : () => _answerQuestion(index),
          borderRadius: BorderRadius.circular(4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: getBorderColor(), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: getBorderColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: getBorderColor(), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      getPrefix(),
                      style: TextStyle(
                        color: getBorderColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    question.options[index],
                    style: const TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 14,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultView() {
    final percentage = (score / questions.length) * 100;
    final grade = percentage >= 80 ? 'EXCELLENT' : percentage >= 60 ? 'GOOD' : percentage >= 40 ? 'AVERAGE' : 'NEEDS_IMPROVEMENT';
    final gradeColor = percentage >= 80 ? const Color(0xFF39FF14) : percentage >= 60 ? const Color(0xFF00BFFF) : percentage >= 40 ? const Color(0xFFFFA500) : const Color(0xFFFF6B6B);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: gradeColor, width: 2),
            ),
            child: Column(
              children: [
                Text(
                  '╭─ QUIZ COMPLETED ─╮',
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'RESULT: $grade',
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'SCORE: $score/${questions.length}',
                  style: const TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 14,
                    fontFamily: 'Courier',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'ACCURACY: ${percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 14,
                    fontFamily: 'Courier',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'CATEGORY: ${widget.selectedCategory.toUpperCase()}',
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                    fontFamily: 'Courier',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetQuiz,
                  child: const Text('RETRY'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C2C),
                    foregroundColor: const Color(0xFF888888),
                    side: const BorderSide(color: Color(0xFF888888), width: 1),
                  ),
                  child: const Text('EXIT'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

