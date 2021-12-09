package biz.gelicon.core.dialect;

/**
 * Различные системные функции, зависящие от СУБД
 */
public interface DBDialect {

    public String sequenceNextValueSQL(String seqName);

    public String alterSequence(String sequenceName, Integer value);

    public String createSequence(String sequenceName, Integer startValue);

    /**
     * Возвращает текст запроса для проверки существования последовательности
     *
     * @param sequenceName  - имя последовательности
     * @return
     */
    public String sequenceExist(String sequenceName);
    /**
     * Возвращает текст запроса для проверки существования таблицы
     *
     * @param tableName  - имя таблицы
     * @return
     */
    public String tableExist(String tableName);
    /**
     * Возвращает текст запроса для проверки существования представления
     *
     * @param viewName  - имя представления
     * @return
     */
    public String viewExist(String viewName);

    public String extractColumnNameFromDuplicateMessage(String message);

    public String extractTableNameFromForeignKeyMessage(String message);

    public String stringAggFunc(String columnName);

    /**
     * Преобразует текст запроса для выполнения запроса на возвращение одной или нуля записей
     *
     * @param sql
     * @return
     */
    public String existsSql(String sql);

    /**
     * Преобразует текст запроса для возвращений количества записей в запросе
     *
     * @param sql
     * @return
     */
    public String countRecord(String sql);


    /**
     * Собирает секцию ограничения по записям и смещению
     * @param limit - сколько записей выбирать
     * @param offset - смещение в страницах
     * @return - секция пагинации для SDL-запроса
     */
    public String limitAndOffset(Integer limit, Integer offset);

    /**
     * Строит текст SQL-запроса с лимитом и смещением
     * @param sqlText - исходный запрос
     * @param limit - лимит записей на страницу
     * @param offset - смещение в страницах
     * @return - Новый текст SQL-запроса
     */
    public default String buildSqlTextWithLimit(
            String sqlText,
            Integer limit,
            Integer offset
    ) {
        if (sqlText == null) return null;
        if (limit == null || offset ==null) return sqlText;
        return sqlText + " " + limitAndOffset(limit, offset);
    }

}
