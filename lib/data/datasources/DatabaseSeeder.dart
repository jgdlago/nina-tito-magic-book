const String addLevels = '''
  INSERT INTO levels (name, scenario, message, level_order) VALUES
  ('Se arrumando para a aventura', 'lib/game/scenarios/Bedroom.dart', 'Precisamos de uma roupa adequada para iniciar nossa jornada, vá até o roupeiro', 1),
  ('Hora da aula', 'lib/game/scenarios/School.dart', 'Encontre pistas que levem até o livro mágico!', 2);
''';

// TODO testar carregamento dinamico do nível da escola