abstract class SqfliteInterface {
  Future read(String sql);
  Future update(String sql, List arguments);
  Future insert(String sql, List arguments);
  Future delete(String sql, List arguments);
}
