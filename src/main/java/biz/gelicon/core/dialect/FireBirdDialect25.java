package biz.gelicon.core.dialect;

public class FireBirdDialect25 extends FireBirdDialect implements DBDialect{

    public FireBirdDialect25() {
    }

    @Override
    public String buildSqlTextWithLimit(
            String sqlText,
            Integer limit,
            Integer offset
    ) {
        if (sqlText == null) return null;
        if (limit == null || offset ==null) return sqlText;
        String s = limitAndOffset(limit, offset);
        // Заменим первый SELECT на SELECT FIRST 2 SKIP 5 без учета регистра
        sqlText = sqlText.replaceFirst("(?i)SELECT", "SELECT " + s);
        return sqlText;
    }

    @Override
    public String limitAndOffset(Integer limit, Integer offset) {
        if (limit == null && offset == null) {
            // Ни ограничения по записям ни смещения нет
            return "";
        }
        if (offset == null) {
            // смещения нет - только ограничения
            return "FIRST " + limit;
        }
        if (limit == null) {
            // ограничения по записям нет - только смещение в записях
            // бред, но оставим
            return " SKIP " + offset ;
        }
        // Смещение в записях, а не в страницах
        return "FIRST " + limit + " SKIP " + offset * limit;
    }


}
